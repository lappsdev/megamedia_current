class User < ApplicationRecord
  has_secure_password
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
  has_many :sessions, dependent: :destroy

  validates :password, allow_nil: true, length: { minimum: 4 }
end
