class Location < ActiveRecord::Base
  validates :address_1, :city, :zipcode, :state, :country, :user_id, presence: true
end
