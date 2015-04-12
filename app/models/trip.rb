class Trip < ActiveRecord::Base
  belongs_to :last_trip, :class_name => "Trip",
    :foreign_key => "last_trip"

  validate :greater_than_last_trip
    
  belongs_to :car
  validates :car_id, presence: true

  belongs_to :user
  validates :user_id, presence: true

  validates :odo, presence: true, numericality: true
  validates :location, presence: true
  validates :date, presence: true

  before_save :set_distance

  define_statistic :trip_count, :count => :all
  define_statistic :total_distance, :sum => :all, :column_name => 'distance'
  define_statistic :personal_distance, :sum => :all, :column_name => 'distance', :conditions => "personal = 't'"
  define_calculated_statistic :business_distance do
    defined_stats(:total_distance) - defined_stats(:personal_distance)
  end

  filter_all_stats_on(:car_id, 'car_id = ?')
  filter_all_stats_on(:user_id, 'user_id = ?')

  # Calculate the trip's distance. If this is the first trip for this car, return 0
  def get_distance
    if last_trip.nil?
      return 0
    else
      odo - last_trip.odo
    end
  end

  def set_distance
   self.distance = get_distance 
  end

  # Validate that the odometer reading has gone up and that the date is not earlier, except for the initial trip
  def greater_than_last_trip
    unless Trip.where(car_id: car).empty? or odo.nil? or last_trip.nil?
      if last_trip.odo >= odo
        errors.add(:base, "Odometer reading must be greater than the reading from the last trip")
      end

      if last_trip.date > date
        errors.add(:base, "Date cannot be earlier than date of previous trip")
      end
    end
  end
end
