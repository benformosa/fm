class TripPolicy < ApplicationPolicy
  attr_reader :user, :trip

  def initialize(user, trip)
    @user = user
    @car = car
  end

  # A user may update a trip if it is the most recent trip for that car and if they logged that trip.
  def update?
    Trip.where(car: @trip.car).last == @trip and @trip.user == @user 
  end
end
