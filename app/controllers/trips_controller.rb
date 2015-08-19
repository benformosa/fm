class TripsController < ApplicationController
  before_action :authenticate_user!

  autocomplete :trip, :location, :full => true, :distinct => true

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
    @trip = Trip.new(trip_params[:trip])
    if(@trip.save)
      redirect_to :action => :index, :car => @trip.car
    else
      render :action => :new
    end
  end

  def update
  end
  
  private
    def trip_params
      params.require(:trip).permit(:odo, :location, :last_trip, :car, :date, :garage, :personal, :user)
    end
end
