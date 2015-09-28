class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
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
    @trip = Trip.new(trip_params)
    @trip[:user_id] = current_user.id
    if(@trip.save)
      redirect_to :action => :index, :car => @trip.car
    else
      render :action => :new
    end
  end

  # def edit
  # end

  # def update
    # if @trip.update_attributes(trip_params)
      # redirect_to :action => :index
    # else
      # render :action => edit
    # end
  # end

  private
  # # Use callbacks to share common setup or constraints between actions.
  # def set_trip
    # @trip = Trip.find(params[:id])
  # end

  def trip_params
    params.require(:trip).permit(:odo, :location, :last_trip, :car_id, :date, :garage, :personal)
  end
end
