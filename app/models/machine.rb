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
    latlng = self.latlng
    latlng[:address] = self.locations.first[:address]
    latlng
  end

  # might be redundant because of #address_info
  def json_for_map
    loc = self.latlng
    {name: self.name, lat: loc[:lat], lng: loc[:lng]}.to_json
  end

  # I don't do anything with options yet, but plan on adding the ability to pass in category search as well as some
  # other fun stuff
  def self.search(address, opts = {distance: 20})
    machines = []
    # jesus christ, this is slow. nested loops == bad, though can't figure out how to do this better.
    # also, doesn't find by category yet
    Location.near(address, opts[:distance]).joins(:machines).each do |location|
      location.machines.each do |machine|
        if opts[:category]
          machines << machine if machine.category == opts[:category]
        else
          machines << machine
        end
      end
    end
    machines
  end

  def as_json(options = {})
    super(methods: :address_info, include: :user)
  end

end
