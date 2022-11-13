module SafeDesk
  class RewardsAPI < Grape::API
    # version 'v1', using: :path
    format :json
    # prefix :api

    resource :rewards do

      desc 'Get List of reward Data'
      params do

      end
      get do
        reward_list = Reward.all
        present reward_list
      end


      desc 'create Reward'
      params do

      requires :task_name, type: String, desc: "Mailer Config Id"
      requires :points, type: Integer, desc: "Mailer Config Id"
      requires :date_completed, type: Date, desc: "Mailer Config Id"
      requires :parent_id, type: String, desc: "Mailer Config Id"
      end
      post do
        reward = Reward.create(params)
        return {message: "reward Created Successfully", status_code: 200, reward: reward}
      end



      desc 'edit (put) Reward'
      params do
      optional :points, type: Integer, desc: "Mailer Config Id"
      requires :date_completed, desc: "Mailer Config Id"
      requires :id, type: String, desc: "Mailer Config Id"
      end
      put ":id" do
        reward = Reward.find params[:id]
        reward.update(params)
        return {message: "reward edited Successfully", status_code: 200, reward: reward}
      end



      desc 'Delete Reward'
      params do
      requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        reward = Reward.find params[:id]
        updated_reward = reward.delete
        return {message: "reward Deleted Successfully", status_code: 200}
      end







    end
  end
end