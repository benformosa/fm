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
    def car_params
      params.require(:car).permit(:id, :name, :make, :model, :rego, :state, :start_odo)
      #params.permit(:car, :id, :name, :make, :model, :rego, :state, :start_odo)
    end
end
