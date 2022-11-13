class Statusadd < ActiveRecord::Migration[7.0]
  def change


    remove_column :rewards, :volunteering_json
    add_column :rewards, :rewards_json, :datetime
  end
end
