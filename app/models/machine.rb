class Machine < ActiveRecord::Base
  belongs_to :user

  has_many :locations, through: :user

  validates :category, presence: true, inclusion: { in: ["3d Printer", "Laser Cutter"]}
  validates :name, presence: true
  validates :description, presence: true
  validates :user_id, presence: true # need to add validation to ensure that this is a real user

end
