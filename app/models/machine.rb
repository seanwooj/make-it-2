class Machine < ActiveRecord::Base
  belongs_to :user

  has_many :locations, through: :user

  validates :category, presence: true, inclusion: { in: ["3d Printer", "Laser Cutter"]}
  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true # need to add validation to ensure that this is a real user

  # I don't do anything with options yet, but plan on adding the ability to pass in category search as well as some
  # other fun stuff
  def self.search(address, category = nil)
    machines = []
    # jesus christ, this is slow. nested loops == bad, though can't figure out how to do this better.
    # also, doesn't find by category yet
    Location.near(address).joins(:machines).each do |location|
      location.machines.each do |machine|
        if category
          machines << machine if machine.category = category
        else
          machines << machine
        end
      end
    end
    machines
  end

end
