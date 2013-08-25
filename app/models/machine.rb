class Machine < ActiveRecord::Base
  belongs_to :user

  has_many :locations, through: :user

  validates :category, presence: true, inclusion: { in: ["3d Printer", "Laser Cutter"]}
  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true # need to add validation to ensure that this is a real user


  def latlng
    loc = self.locations.first
    {lat: loc[:latitude], lng: loc[:longitude]}
  end

  def address_info
    info = self.latlng
    info[:address] = self.locations.first[:address]
    info[:city] = self.locations.first[:city]
    info
  end

  # I don't do anything with options yet, but plan on adding the ability to pass in category search as well as some
  # other fun stuff
  def self.search(address, opts = {distance: 20})
    lat, lng = Geocoder::Calculations.extract_coordinates(address)
    if Geocoder::Calculations.coordinates_present?(lat, lng)
      options = Location.send :near_scope_options, lat, lng, opts[:distance]
      conditions = options[:conditions]
      machines = joins(:locations).where(conditions).distinct
      machines = machines.where('lower(machines.category) = ?', opts[:category].to_s.downcase) if opts[:category]
      machines
    else
      where(false)
    end
  end

  def as_json(options = {})
    super(methods: :address_info, include: :user)
  end

end
