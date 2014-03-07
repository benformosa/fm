class Trip < ActiveRecord::Base
  belongs_to :last_trip, :class_name => "Trip",
    :foreign_key => "last_trip"

  validates :odo, presence: true,
    numericality: true
  
  validate :greater_than_last_trip
	
  def greater_than_last_trip
    if odo < last_trip.odo
	  self.errors.add(:base, "Odometer reading must be greater than the reading from the last trip")
	end
  end
end
