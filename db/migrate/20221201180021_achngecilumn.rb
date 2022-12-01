class Achngecilumn < ActiveRecord::Migration[7.0]

  def change
    remove_column :sos, :map_url
    add_column :sos, :map_info, :json
  end
end
