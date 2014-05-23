class CarsController < ApplicationController
  before_action :authenticate_user!

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
    @car = Car.find(car_params[:id])
  end

  def edit
    @car = Car.find(car_params[:id])
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

  
  private
    def car_params
      params.require(:car).permit(:id, :name, :make, :model, :rego, :state, :start_odo)
    end
end
