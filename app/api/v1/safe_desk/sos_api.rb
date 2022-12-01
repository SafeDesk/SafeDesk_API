module SafeDesk
  class SosAPI < Grape::API
    # version 'v1', using: :path
    format :json
    # prefix :api

    resource :sos do

      desc 'Get List of Chores Data'
      params do

      end
      get do
        sos_list = So.where(parent_id: @parent.id)
        present sos_list.order(created_at: desc)
      end


      desc 'create sos'
      params do
        requires :map_url, type: String, desc: "url"
      end
      post do
        params["parent_id"] = @parent.id
        sos = So.create(params)
        return {message: "SOS Created Successfully", status_code: 200, sos: sos}
      end




      desc 'Delete sos'
      params do
        requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        sos = So.find params[:id]
        updated_chore = sos.delete
        return {message: "chore Deleted Successfully", status_code: 200}
      end







    end
  end
end