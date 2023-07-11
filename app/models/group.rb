class Group < ApplicationRecord
  validates_presence_of :name
  has_many :users
  has_many :units
  has_many :devices, through: :units
  has_many :screens
end
