class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.date :date
      t.float :rating
      t.text :review
      t.integer :dish_id
    end
  end
end
