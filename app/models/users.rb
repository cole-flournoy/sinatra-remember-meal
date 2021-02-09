class User < ActiveRecord::Base 
  has_many :restaurants
end