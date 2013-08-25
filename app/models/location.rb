class Location < ActiveRecord::Base
  validates :address, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :city, presence: true

  belongs_to :user
  has_many :machines, through: :user

  geocoded_by :address
  before_validation :geocode, :if => lambda { :has_been_geocoded? || address_changed? }
  before_validation :assign_city, :if => lambda { city.nil? || (address_changed? && !city_changed? ) }

  private # -------------------------------------

  def assign_city
    Geocoder.search(address)[0].data["address_components"].each do |locality|
      self.city = locality["long_name"] if locality["types"] == ["locality", "political"]
    end
  end

  def has_been_geocoded?
    city.nil? || latitude.nil? || longitude.nil?
  end

end
