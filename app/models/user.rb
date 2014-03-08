class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable

  has_many :trips
  has_many :cars, through: :trips
  
  validates :login, presence: true,
    uniqueness: true
  validates :name, presence: true
  validates :email, presence: true
end
