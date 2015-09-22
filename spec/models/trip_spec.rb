# encoding: UTF-8
require 'rails_helper'

describe Trip do
  it "has a valid factory" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    expect(FactoryGirl.create(:trip, car: car, user: user)).to be_valid
  end

  it "is invalid without a location" do
    expect(subject).to validate_presence_of :location
  end

  it "is invalid without a odo" do
    expect(subject).to validate_presence_of :odo
  end

  it "returns its sequence number - one trip" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip = FactoryGirl.create(:trip, car: car, user: user)
    expect(trip.get_sequence_number).to eql(0)
  end

  it "returns its sequence number - two trips" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip1 = FactoryGirl.create(:trip, odo: 10, car: car, user: user)
    trip2 = FactoryGirl.create(:trip, odo: 20, car: car, user: user)
    expect(trip1.get_sequence_number).to eql(0)
    expect(trip2.get_sequence_number).to eql(1)
  end

   it "returns true if it is the first trip for a car" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip = FactoryGirl.build(:trip, car: car, user: user)
    expect(trip.no_trips_for_this_car?).to be true
  end
   
   it "returns false if it is the first trip for a car" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip1 = FactoryGirl.create(:trip, odo: 10, car: car, user: user)
    trip2 = FactoryGirl.build(:trip, odo: 20, car: car, user: user)
    expect(trip1.no_trips_for_this_car?).to be false
    expect(trip2.no_trips_for_this_car?).to be false
  end

  it "has a previous trip" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip1 = FactoryGirl.create(:trip, odo: 10, car: car, user: user)
    trip2 = FactoryGirl.create(:trip, odo: 20, car: car, user: user)
    expect(trip2.last_trip).to eq(trip1)
  end

  it "does not have a previous trip if it is the first trip" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip = FactoryGirl.create(:trip, car: car, user: user)
    expect(trip.last_trip).to eq(nil)
  end

  it "has an odo greater than that of the previous trip" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car)
    trip = FactoryGirl.create(:trip, odo: 100, car: car, user: user)
    expect(FactoryGirl.build(:trip, odo: 100, car: car, user: user)).not_to be_valid
    expect(FactoryGirl.build(:trip, odo: 99, car: car, user: user)).not_to be_valid
  end

  it "has a date not earlier than that of the previous trip" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car, start_odo: 0)
    trip = FactoryGirl.create(:trip, odo: 10, date: Date.today, car: car, user: user)
    expect(FactoryGirl.build(:trip, odo: 20, date: Date.today, car: car, user: user)).to be_valid
    expect(FactoryGirl.build(:trip, odo: 30, date: 2.days.ago, car: car, user: user)).not_to be_valid
  end

  it "calculates distance for first trip" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car, start_odo: 0)
    trip = FactoryGirl.create(:trip, odo: 10, car: car, user: user)
    expect(trip.get_distance).to eq(10)
  end

  it "calculates distance" do
    user = User.where(login: 'user1').last
    car = FactoryGirl.create(:car, start_odo: 0)
    trip1 = FactoryGirl.create(:trip, odo: 10, car: car, user: user)
    trip2 = FactoryGirl.create(:trip, odo: 15, car: car, user: user)
    expect(trip2.get_distance).to eq(5)
  end
end
