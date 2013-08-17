class Location < ActiveRecord::Base
  validates :address, presence: true
  belongs_to :user
  has_many :machines, through: :user

  private

  def assign_city
    self.city = Geocoder.search(self.address)[0].city
    self.save!
  end

end
