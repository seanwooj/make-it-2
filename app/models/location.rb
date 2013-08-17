class Location < ActiveRecord::Base
  validates :address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :city, presence: true

  belongs_to :user
  has_many :machines, through: :user

end
