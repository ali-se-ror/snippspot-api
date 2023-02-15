class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :title
      t.string :description
      t.string :location
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end
end
