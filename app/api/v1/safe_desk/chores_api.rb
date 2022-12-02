module SafeDesk
  class ChoresAPI < Grape::API
    # version 'v1', using: :path
    format :json
    # prefix :api

    resource :chores do

      desc 'Get List of Chores Data'
      params do

      end
      get do
        chores_list = Chore.where(parent_id: @parent.id)
        present chores_list.order(created_at: "DESC")
      end

      desc 'create chore'
      params do

        requires :task_name, type: String, desc: "Mailer Config Id"
        requires :points, type: Integer, desc: "Mailer Config Id"
        requires :task_priority, type: Integer, desc: "Mailer Config Id"
        requires :date_completed, type: Date, desc: "Mailer Config Id"
      end
      post do
        params["parent_id"] = @parent.id
        chore = Chore.create(params)
        chore.category = "chore"
        chore.save
        return { message: "Chore Created Successfully", status_code: 200, chore: chore }
      end

      desc 'edit (put) chore'
      params do
        requires :task_name, type: String, desc: "Mailer Config Id"
        requires :points, type: Integer, desc: "Mailer Config Id"
        requires :task_priority, type: Integer, desc: "Mailer Config Id"
        requires :date_completed, desc: "Mailer Config Id"
        requires :id, type: String, desc: "Mailer Config Id"
      end
      put ":id" do
        chore = Chore.find params[:id]
        chore.update(params)
        return { message: "Chore edited Successfully", status_code: 200, chore: chore }
      end

      desc 'Delete chore'
      params do
        requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        chore = Chore.find params[:id]
        updated_chore = chore.delete
        return { message: "chore Deleted Successfully", status_code: 200 }
      end

    end
  end
end