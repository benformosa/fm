class TripsController < ApplicationController
  before_action :authenticate_user!

  autocomplete :trip, :location, :full => true

  def index
    if params[:car]
      @trips = Trip.where(car_id: params[:car])
    else
      @trips = Trip.all
    end
  end
  
  def new
    @trip = Trip.new
  end
  
  def create
    odo = trip_params[:odo]
    location = trip_params[:location]
    last_trip = Trip.find(trip_params[:last_trip])
    car = Car.find(trip_params[:car])
    @trip = Trip.new(:odo => odo, :location => location, :last_trip => last_trip, :car => car, :user => current_user, :date => trip_params[:date])
    if(@trip.save)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def update
  end
  
  private
    def trip_params
      params.require(:trip).permit(:odo, :location, :last_trip, :car, :date, :garage, :personal)
    end
end
