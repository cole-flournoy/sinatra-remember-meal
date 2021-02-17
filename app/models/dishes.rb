class Dish < ActiveRecord::Base 
  belongs_to :restaurant
  has_many :visits
  validates :name, presence: true
  validates :restaurant_id, presence: true
end