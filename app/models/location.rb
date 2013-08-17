class Location < ActiveRecord::Base
  validates :address, presence: true
  belongs_to :user
  has_many :machines, through: :user

  # geocoder
  geocoded_by :address
  after_validation :assign_city, if: :address_changed?

  private

  def assign_city
    self.city = Geocoder.search(self.address)[0].city
    self.save!
  end

end
