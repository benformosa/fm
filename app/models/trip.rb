class Trip < ActiveRecord::Base
  belongs_to :last_trip, :class_name => "Trip",
    :foreign_key => "last_trip"
  validate :greater_than_last_trip
    
  belongs_to :car
  validates :car_id, presence: true

  belongs_to :driver
  validates :driver_id, presence: true

  validates :odo, presence: true,
    numericality: true

  #validate that the odometer reading has gone up, except for the initial trip
  def greater_than_last_trip
    unless Trip.where(car_id: car).empty?
      if last_trip.odo >= odo
        errors.add(:base, "Odometer reading must be greater than the reading from the last trip")
      end
    end
  end
end
