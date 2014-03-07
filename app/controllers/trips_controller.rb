class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end
  
  def new
    @last_trip = Trip.last.id
    @trip = Trip.new
  end
  
  def create
	if not Trip.find(:all).empty?
	  last_trip = Trip.find(trip_params[:last_trip])
	end	
	
    odo = trip_params[:odo]
	@trip = Trip.new(:odo => odo, :last_trip => last_trip)
	if(@trip.save)
	  redirect_to :action => :index
	else
	  render :action => :new
	end
  end
  
  def show
    @trip = Trip.find(trip_params)
  end
  
  private
    def trip_params
      params.require(:trip).permit(:odo, :last_trip)
    end
end
