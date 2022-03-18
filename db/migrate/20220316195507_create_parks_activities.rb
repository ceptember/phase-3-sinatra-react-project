class CreateParksActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :parks_activities do |t|
      t.integer :park_id
      t.integer :activity_id
    end
  end
end
