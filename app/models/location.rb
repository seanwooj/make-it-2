class Location < ActiveRecord::Base
  validates :address_1, :city, :zipcode, :state, :country, :user_id, presence: true
  after_validation :create_geocoded_address

  private

  def create_geocoded_address
    geocoded_string = "#{self.address_1}, #{self.city}, #{self.state} #{self.zipcode}, #{self.country}"
    self.address_for_geocoder = geocoded_string
  end
end
