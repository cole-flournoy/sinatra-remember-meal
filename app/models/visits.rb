class Visit < ActiveRecord::Base
  belongs_to :dish
  validates :date, presence: true
  validates :rating, presence: true
end 