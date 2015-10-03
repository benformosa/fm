class Trip < ActiveRecord::Base
  belongs_to :last_trip, :class_name => "Trip",
    :foreign_key => "last_trip"

  before_validation :set_last_trip
  validates :last_trip, presence: true, allow_nil: true

  belongs_to :car
  validates :car_id, presence: true

  belongs_to :user
  validates :user_id, presence: true

  validates :odo, presence: true, numericality: true
  validates :location, presence: true
  validates :date, presence: true

  validate :greater_than_last_trip
  validate :later_than_last_trip

  before_save :set_distance

  # return which number trip this is. Will return 0 for a car's first trip.
  def get_sequence_number
    if Car.find(self.car_id).no_trips_for_this_car?
      0
    else
      Trip.where(car_id: self.car_id).index(self)
    end
  end
  
  # return if this is the first trip
  def first_trip?
    self.get_sequence_number == 0
  end

  # Set last_trip to the id of the previous trip
  def set_last_trip
    if self.first_trip?
      self.last_trip = nil
    else
      self.last_trip = Trip.where(car_id: self.car).last
    end
  end

  # Calculate the trip's distance
  def get_distance
    if self.first_trip?
      self.odo - Car.find(car_id).start_odo
    else
      self.odo - last_trip.odo
    end
  end

  def set_distance
    self.distance = self.get_distance
  end

  # Validate that the odometer reading has gone up since the previous trip
  def greater_than_last_trip
      # don't run this validation if other validations have failed
      return unless errors.blank?
    if self.first_trip?
      if Car.find(self.car_id).start_odo >= odo
        errors.add(:odo, "Odometer reading must be greater than the car's Initial Odometer reading.")
      end
    else
      if last_trip.odo >= odo
        errors.add(:odo, "Odometer reading must be greater than the reading from the last trip")
      end
    end
  end

  # Validate that the date is not earlier than the previous trip
  def later_than_last_trip
    # don't run this validation if other validations have failed
    return unless errors.blank?
    unless self.first_trip?
      if last_trip.date > date
        errors.add(:date, "Date cannot be earlier than date of previous trip")
      end
    end
  end
end
