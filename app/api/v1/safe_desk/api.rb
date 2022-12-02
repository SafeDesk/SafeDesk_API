require 'jwt'
require 'auth_token'
module SafeDesk
  class API < Grape::API
    # version 'v1', using: :path
    format :json
    prefix 'api'
    version 'v1', using: :path

    # before_do:

    helpers do
      def get_user
        token = fetch_token
        error! 'Access Denied', 401 unless env['HTTP_AUTHORIZATION'].present?
        decoded_obj = AuthToken.new.decode(token)
        # error! 'User token is expired!', 422 unless Time.now < decoded_obj['expiry_time'].to_datetime
        error!({ message: 'User token is expired!', status_code: 401 }) unless Time.now < decoded_obj['expiry_time'].to_datetime
        @parent = Parent.find_by(id: decoded_obj['parent_id'])
        @child = @parent.child.find_by_email(decoded_obj['email']) if decoded_obj['isChild']
        error! 'parent not present!', 422 unless @parent.present?
      end

      def fetch_token
        error! 'Invalid Token', 401 unless env['HTTP_AUTHORIZATION'].present?
        strategy, token = env['HTTP_AUTHORIZATION'].split(' ')
        return nil unless (strategy || '').casecmp('bearer').zero?
        token
      end
    end

    desc 'user/pos login api'
    params do
      requires :email
      requires :password
    end
    post "parent/login" do
      parent = Parent.where(email: params[:email]).first
      return { status: false, message: "parent does not exist/authentication failed!", status_code: 401 } unless parent.present?
      # parent = parent.authenticate(params[:password])
      if parent.present?
        { is_parent: true,
          parent: parent.as_json.except("password"),
          # mobile_no: parent.mobile_no,
          token: AuthToken.new.encode(
            { parent_id: parent.id,
              expiry_time: Time.now + 1.day,
              isChild: false
            })
        }
      else
        present status: false, message: "parent does not exist/authentication failed!", status_code: 401
      end
    end

    params do
      requires :email
      requires :password
    end
    post 'child/login' do
      child = Child.where(params).first
      # return { status: false, message: "parent does not exist/authentication failed!", status_code: 401 } unless child.present?
      # child = child.authenticate(params[:password])
      if child.present?
        { is_parent: false,
          child: child.as_json.except("password"),
          parent: child.parent.as_json.except("password"),
          token: AuthToken.new.encode(
            { email: child.email,
              parent_id: child.parent_id,
              expiry_time: Time.now + 1.day,
              isChild: true
            })
        }
      else
        present status: false, message: "child does not exist/authentication failed!"
      end
    end

    desc 'Create parent'
    params do
      #TODO: Need to add other fields also authentication
      requires :email
      requires :password
    end
    post "parent/signup" do
      begin
        params[:email] = params[:email].downcase
        ActiveRecord::Base.transaction do
          if Parent.where(email: params[:email]).first.present? || Child.where(email: params[:email]).first.present?
            return { message: "This email exists already", status: 304 }
          end
          parent = Parent.create(params)
          present parent
        rescue => e
          return e
        end
      end
    end

    desc 'Create Child'
    params do
      #TODO: Need to add other fields also authentication
      requires :email
      requires :password
      requires :parent_email
    end
    post "child/signup" do
      begin
        params[:email] = params[:email].downcase
        ActiveRecord::Base.transaction do
          if Parent.where(email: params[:email]).first.present? || Child.where(email: params[:email]).first.present?
            return { message: "This email exists already", status: 304 }
          end
          parent = Parent.where(email: params[:parent_email]).first
          child = parent.child.create(params.except(:parent_email))
          rewards = Reward.create(child_id: child.id, unclaimed: 0, redeemed: 0, parent_id: parent.id)
          present child
        rescue => e
          return e
        end
      end
    end

    before do
      get_user
      Rails.logger.info "Started Operation - #{env["REQUEST_METHOD"]} ,
 Path - '#{env["REQUEST_PATH"]}' , Params - #{params}"
      Thread.current[:user] = @user
    end

    mount SafeDesk::SosAPI
    mount SafeDesk::ChoresAPI
    mount SafeDesk::HomeworkAPI
    mount SafeDesk::RewardsAPI
    mount SafeDesk::VolunteerAPI
    mount SafeDesk::RewardsAPI

  end
end