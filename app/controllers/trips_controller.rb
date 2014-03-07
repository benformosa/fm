class TripsController < ApplicationController
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
    last_trip = Trip.find(trip_params[:last_trip])
    car = trip_params[:car]
    @trip = Trip.new(:odo => odo, :last_trip => last_trip, :car => car)
    if(@trip.save)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  private
    def trip_params
      params.require(:trip).permit(:odo, :last_trip, :car)
    end
end
