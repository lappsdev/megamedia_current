class User < ApplicationRecord
  belongs_to :group
  validates_presence_of :name

  validates_presence_of :login
  validates_presence_of :role

  validates_uniqueness_of :login
  has_secure_password validations: false
  enum role: {
    admin: 0,
    marketing: 1
  }
end
