class Restaurant < ActiveRecord::Base 
  belongs_to :user
  has_many :dishes
  validates :name, presence: true
  validates :cuisine, presence: true
  validates :user_id, presence: true
end