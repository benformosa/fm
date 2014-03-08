require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test "should have name" do
    car = Car.new(:start_odo => 0)
    assert !car.save, "Car saved without name"
  end

  test "should have start_odo" do
    car = Car.new(:name => "car")
    assert !car.save, "Car saved without starting odometer"
  end

  test "initial trip created" do
    car = Car.create(:name => "car", :start_odo => 10)
    assert Trip.where(car_id: car.id).count == 1, "Inital trip not created"
  end

  test "initial trip should have start_odo" do
    car = Car.create(:name => "car", :start_odo => 10)
    assert Trip.where(car_id: car.id).last.odo == 10, "Inital trip created incorrectly"
  end
end
