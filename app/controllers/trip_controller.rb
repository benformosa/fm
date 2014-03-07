class TripsController < ApplicationController
  def index
    if params[:car]
	  @trips = Trip.where(car: params[:car])
    else
	  @trips = Trip.all
	end
  end
  
  def new
    @trip = Trip.new
  end
  
  def create
    @trip = Trip.new(params[:trip])
	if(@trip.save)
	  redirect_to :action => :index
	else
	  render :action => :new
	end
  end
  
  def show
    @trip = Trip.find(params[:id])
  end
end
