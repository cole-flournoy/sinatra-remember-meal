class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.date :date
      t.float :rating
      t.integer :restaurant_id
    end
  end
end
