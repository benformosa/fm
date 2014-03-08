class Driver < ActiveRecord::Base
  has_many :trips
  has_many :cars, through: :trips

  validates :name, presence: true
  validates :login, presence: true,
    uniqueness: true
end
