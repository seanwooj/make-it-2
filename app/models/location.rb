class Location < ActiveRecord::Base
  validates :address, presence: true
  belongs_to :user

  # geocoder
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  private

end
