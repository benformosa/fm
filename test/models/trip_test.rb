require 'test_helper'

class TripTest < ActiveSupport::TestCase
  test "should have car" do
    puts '?????????????'
    puts Driver.where(login: "jdoe").first.id
    puts '?????????????'
    trip = Trip.new(:odo => 20, :driver => Driver.where(login: "jdoe").first)
    assert !trip.save, "Saved the trip without car"
  end

  test "should have driver" do
    trip = Trip.new(:odo => 20, :car => car)
    assert !trip.save, "Saved the trip without driver"
  end

  test "should set initial trip as last_trip" do
    trip = Trip.new(:odo => 20, :car => car, :driver => Driver.where(login: "jdoe").first)
    trip.save
    puts '?????????????'
    puts Driver.where(login: "jdoe").first.id
    puts '?????????????'
    Trip.where(car: car).each do |t|
      puts t.odo
    end
    puts '?????????????'
    assert trip.last_trip == Trip.where(car: car).first, "Did not find set last_trip to the initial trip"
  end

  test "should not have equal odo to last_trip" do
    trip1 = Trip.create(:odo => 20, :car => car, :driver => Driver.where(login: "jdoe").first)
    trip2 = Trip.new(:odo => 20, :car => car, :last_trip => trip1)
    assert !trip2.save, "Saved the trip with equal odo"
  end

  test "should not have lower odo to last_trip" do
    trip1 = Trip.create(:odo => 20, :car => car, :driver => Driver.where(login: "jdoe").first)
    trip2 = Trip.new(:odo => 5, :car => car, :last_trip => trip1, :driver => Driver.where(login: "jdoe").first)
    assert !trip2.save, "Saved the trip with lower odo"
  end
end
