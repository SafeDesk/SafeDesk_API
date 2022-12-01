class CreateSos < ActiveRecord::Migration[7.0]
  def change
    create_table :sos, id: :uuid do |t|

      t.uuid "parent_id"
      t.string "map_url"

      t.timestamps
    end
  end
end
