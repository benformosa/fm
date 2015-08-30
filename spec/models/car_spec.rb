# encoding: UTF-8
require 'rails_helper'

describe Car do
  it "has a valid factory" do
    expect(FactoryGirl.create(:car)).to be_valid
  end

  it "is invalid without a name" do
    expect(subject).to validate_presence_of :name
  end

  it "has a a unique name" do
    expect(subject).to validate_uniqueness_of :name
  end

  it "is invalid without a make" do
    expect(subject).to validate_presence_of :make
  end

  it "is invalid without a model" do
    expect(subject).to validate_presence_of :model
  end

  it "is invalid without a rego" do
    expect(subject).to validate_presence_of :rego
  end

  it "converts spaces in rego to interpuncts" do
    expect(FactoryGirl.build(:car, rego: 'ABC 123').rego).to eql('ABC·123')
  end

  it "uppercases letters in rego" do
    expect(FactoryGirl.build(:car, rego: 'abc').rego).to eql('ABC')
  end

  it "is invalid without a state" do
    expect(subject).to validate_presence_of :state
  end

  it "is invalid without a start_odo" do
    expect(subject).to validate_presence_of :start_odo
  end

  it "has a numerical start_odo" do
    expect(subject).to validate_numericality_of :start_odo
  end

  it "is invalid without a initial_location" do
    expect(subject).to validate_presence_of :initial_location
  end

  it "has an initial trip" do
    car = FactoryGirl.create(:car)
    expect(Trip.last.car_id).to eql(car.id)
  end
end
