class Trip < ActiveRecord::Base
  belongs_to :last_trip, :class_name => "Trip",
    :foreign_key => "last_trip"

  validates :odo, presence: true,
    numericality: true
  validates :last_trip, presence: true
end
