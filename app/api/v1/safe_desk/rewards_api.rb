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
        reward_list = Reward.where(parent_id: @parent.id)
        present reward_list
      end

      desc 'mark completed'
      params do
        requires :task_id, type: String, desc: "Mailer Config Id"
        requires :task_type, type: Integer, desc: "Mailer Config Id"
        # requires :parent_id, type: String, desc: "Mailer Config Id"
        # requires :child_id, type: String, desc: "Mailer Config Id"
      end
      post 'markcompleted' do
        task_type = params[:task_type]
        if task_type == "chore"
          task = Chore.find params[:task_id]
          task.status = true
        end
        if task_type == "homework"
          task = Homework.find params[:task_id]
          task.status = true

        end
        if task_type == "volunteer"
          task = Volunteer.find params[:task_id]
          task.status = true
        end

        task.save
        child = Child.find params[:child_id]
        reward = child.reward
        reward.unclaimed = reward.unclaimed + task.points
        reward.save
        return { message: "reward Created Successfully", status_code: 200, reward: reward }
      end

      desc 'redeem reward'
      params do
        requires :child_id, type: String, desc: "Mailer Config Id"
      end
      post "redeem" do
        child = Child.find params[:child_id]
        reward = child.reward
        reward.redeemed = reward.redeemed + reward.unclaimed
        reward.unclaimed = 0
        reward.save
        return { message: "reward edited Successfully", status_code: 200, reward: reward }
      end

      desc 'Delete Reward'
      params do
        requires :id, type: String, desc: "Mailer Config Id"
      end
      delete ":id" do
        reward = Reward.find params[:id]
        updated_reward = reward.delete
        return { message: "reward Deleted Successfully", status_code: 200 }
      end

    end
  end
end