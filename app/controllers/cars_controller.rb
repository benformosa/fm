class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    if params[:enable]
      @cars = Car.where(enable: false)
    else
      @cars = Car.where(enable: true)
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car[:user_id] = current_user.id
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
    params.require(:car).permit(:name, :make, :model, :rego, :state, :start_odo, :user_id, :fleet, :enable)
  end
end
