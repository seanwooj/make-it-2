class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, :email, presence: true
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, on: :create

  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true
  validates_presence_of :locations

  # lazy - this defaults to use the first address that's created. I can add more methods for having multiple
  # addresses later, but this will do for now
  def primary_location
    locations = self.locations
    if locations.length == 1
      return locations.first
    elsif locations.length > 1
      locations.each do |location|
        return location if location.is_primary?
      end
    else
      raise "user should have an address."
    end
  end
end

