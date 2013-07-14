class Location < ActiveRecord::Base
  validates :address_1, :city, :zipcode, :state, :country, presence: true
  belongs_to :user

  # geocoder
  geocoded_by :address_for_geocoder
  after_validation :create_geocoded_address
  after_validation :geocode, if: :address_for_geocoder_changed?

  private

  def create_geocoded_address
    geocoded_string = "#{self.address_1}, #{self.city}, #{self.state} #{self.zipcode}, #{self.country}"
    self.address_for_geocoder = geocoded_string
  end
end
