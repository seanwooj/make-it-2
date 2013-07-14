class User < ActiveRecord::Base
  validates :full_name, :email, presence: true
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, on: :create

  has_many :locations
  accepts_nested_attributes_for :locations, allow_destroy: true
  validates_presence_of :locations

end

