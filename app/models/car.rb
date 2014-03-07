class Car < ActiveRecord::Base
  has_many :trips
  
  validates :name, presence: true
  validates :start_odo, presence: true,
    numericality: true
    
  after_create :initial_trip
	
  # create a trip representing the odometer reading of the car when it was added to the system
  def initial_trip
    Trip.create({:car => self, :odo => self.start_odo})
  end
end
