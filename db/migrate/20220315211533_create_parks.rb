class CreateParks < ActiveRecord::Migration[6.1]
  def change
    create_table :parks do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :city
      t.string :state
      t.float :lat
      t.float :long
    end
  end
end



