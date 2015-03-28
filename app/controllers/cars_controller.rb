class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
    authorize @car, :modify?
  end

  def create
    @car = Car.new(car_params)
    authorize @car, :modify?
    if(@car.save)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def show
  end

  def edit
    authorize @car, :modify?
  end

  def update
    @car = Car.find(car_params[:id])
    authorize @car, :modify?
    if @car.update_attributes(car_params)
      redirect_to :action => :index
    else
      render :action => edit
    end
  end

  def tripspermonth
    # if param id is set
    if(params.has_key?(:id))
      @car = Car.where(id: (car_params[:id]))
    else
      @car = Car.all
    end
  end

  def kmpermonth
    # if param id is set
    if(params.has_key?(:id))
      @car = Car.where(id: (car_params[:id]))
    else
      @car = Car.all
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :make, :model, :rego, :state, :start_odo, :user_id)
    #params.permit(:car, :id, :name, :make, :model, :rego, :state, :start_odo)
  end
end
