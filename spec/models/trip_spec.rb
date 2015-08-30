# encoding: UTF-8
require 'rails_helper'

describe Trip do
  it "has a valid factory" do
    user = FactoryGirl.create(:user)
    car = FactoryGirl.create(:car)
    expect(trip1 = FactoryGirl.create(:trip, car: car, user: user)).to be_valid
  end

  it "is invalid without a location" do
    expect(subject).to validate_presence_of :location
  end

  it "is invalid without a odo" do
    expect(subject).to validate_presence_of :odo
  end

  it "returns if it is the first trip for a car" do
    car = FactoryGirl.create(:car)
    expect(Trip.where(car_id: car.id).first.initial_trip?).to be true
  end

  it "has a previous trip unless it is an initial trip"

  it "has an odo greater than that of the previous trip" do
    user = FactoryGirl.create(:user)
    car = FactoryGirl.create(:car)
    trip1 = FactoryGirl.create(:trip, odo: 100, car: car, user: user)
    expect(FactoryGirl.build(:trip, odo: 99, car: car, user: user)).not_to be_valid
  end
end
