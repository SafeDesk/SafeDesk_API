module SafeDesk
  class SosAPI < Grape::API
    # version 'v1', using: :path
    format :json
    # prefix :api

    resource :sos do

      desc 'Get List of sos Data'
      params do

      end
      get do
        sos_list = So.where(parent_id: @parent.id)
        present sos_list.order(created_at: "DESC")
      end

      desc 'create sos'
      params do
        requires :map_info, desc: "url"
      end
      post do
        params["parent_id"] = @parent.id
        sos = So.create(params)
        return { message: "SOS Created Successfully", status_code: 200, sos: sos }
      end

      desc 'Delete sos'
      params do
        requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        sos = So.find params[:id]
        updated_sos = sos.delete
        return { message: "sos Deleted Successfully", status_code: 200 }
      end

    end
  end
end