class Car < ActiveRecord::Base
  has_many :trips
  has_many :drivers, through: :trips
  
  validates :name, presence: true
  validates :start_odo, presence: true,
    numericality: true
    
  after_create :initial_trip
	
  # create a trip representing the odometer reading of the car when it was added to the system
  def initial_trip
    Trip.create({:car => self, :odo => self.start_odo, :driver => Driver.where(login: "unregistered").first})
  end
end
