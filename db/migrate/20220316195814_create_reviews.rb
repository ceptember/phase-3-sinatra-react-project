class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :park_id
      t.integer :user_id
      t.string :review_text
      t.integer :likes
      t.timestamps
    end
  end
end
