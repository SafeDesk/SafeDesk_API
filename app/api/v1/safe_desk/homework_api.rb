module SafeDesk
  class HomeworkAPI < Grape::API
    # version 'v1', using: :path
    format :json
    # prefix :api

    resource :homework do

      desc 'Get List of Homework Data'
      params do
        optional :child_id, type: Integer, desc: "Child ID"
        optional :parent_id, type: Integer, desc: "Child ID"

      end
      get do
        user = @parent
        homework_list = Homework.where(parent_id: @parent.id)
        present homework_list
      end


      desc 'create Homework'
      params do

      requires :task_name, type: String, desc: "Mailer Config Id"
      requires :points, type: Integer, desc: "Mailer Config Id"
      requires :task_priority, type: Integer, desc: "Mailer Config Id"
      requires :date_completed, type: Date, desc: "Mailer Config Id"
      requires :parent_id, type: String, desc: "Mailer Config Id"
      end
      post do
        homework = Homework.create(params)
        homework.udpate(parent_id: @parent.id)
        return {message: "Homework Created Successfully", status_code: 200, Homework: homework}
      end



      desc 'edit (put) homework'
      params do
      requires :task_name, type: String, desc: "Mailer Config Id"
      requires :points, type: Integer, desc: "Mailer Config Id"
      requires :task_priority, type: Integer, desc: "Mailer Config Id"
      requires :date_completed, desc: "Mailer Config Id"
      requires :id, type: String, desc: "Mailer Config Id"
      end
      put ":id" do
        homework = Homework.find params[:id]
        homework.update(params)
        return {message: "homework edited Successfully", status_code: 200, homework: homework}
      end



      desc 'Delete homework'
      params do
      requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        homework = Homework.find params[:id]
        updated_homework = homework.delete
        return {message: "homework Deleted Successfully", status_code: 200}
      end







    end
  end
end