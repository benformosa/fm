class TripsController < ApplicationController
  def index
	  @trips = Trip.all
  end
  
  def new
    @trip = Trip.new
  end
  
  def create
    @trip = Trip.new(trip_params)
	if(@trip.save)
	  redirect_to :action => :index
	else
	  render :action => :new
	end
  end
  
  def show
    @trip = Trip.find(trip_params)
  end
  
  def trip_params
    params.require(:trip).permit(:odo, :last_trip)
  end
end
