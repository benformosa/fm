require 'test_helper'

class TripTest < ActiveSupport::TestCase
  car = Car.create(:name => "car", :start_odo => 10)

  test "should have car" do
    trip = Trip.new(:odo => 10)
    assert !trip.save, "Saved the trip without car"
  end

  test "should not have equal odo to last_trip" do
    trip1 = Trip.create(:odo => 10, :car => car)
    trip2 = Trip.new(:odo => 10, :car => 1, :last_trip => 1)
    assert !trip2.save, "Saved the trip with equal odo"
  end

  test "should not have lower odo to last_trip" do
    trip1 = Trip.create(:odo => 10, :car => car)
    trip2 = Trip.new(:odo => 5, :car => 1, :last_trip => 1)
    assert !trip2.save, "Saved the trip with lower odo"
  end
end
