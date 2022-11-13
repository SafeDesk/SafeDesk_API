module SafeDesk
  class VolunteerAPI < Grape::API
    # version 'v1', using: :path
    format :json
    # prefix :api

    resource :volunteer do

      desc 'Get List of volunteer Data'
      params do

      end
      get do
        volunteer_list = Volunteer.all
        present volunteer_list
      end


      desc 'create Volunteer'
      params do

      requires :task_name, type: String, desc: "Mailer Config Id"
      requires :points, type: Integer, desc: "Mailer Config Id"
      requires :date_completed, type: Date, desc: "Mailer Config Id"
      requires :parent_id, type: String, desc: "Mailer Config Id"
      end
      post do
        volunteer = Volunteer.create(params)
        return {message: "volunteer Created Successfully", status_code: 200, volunteer: volunteer}
      end



      desc 'edit (put) Volunteer'
      params do
      requires :task_name, type: String, desc: "Mailer Config Id"
      requires :points, type: Integer, desc: "Mailer Config Id"
      requires :date_completed, desc: "Mailer Config Id"
      requires :id, type: String, desc: "Mailer Config Id"
      end
      put ":id" do
        volunteer = Volunteer.find params[:id]
        volunteer.update(params)
        return {message: "volunteer edited Successfully", status_code: 200, volunteer: volunteer}
      end



      desc 'Delete Volunteer'
      params do
      requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        volunteer = Volunteer.find params[:id]
        updated_volunteer= volunteer.delete
        return {message: "volunteer Deleted Successfully", status_code: 200}
      end







    end
  end
end