class CarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cars = Car.all
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(car_params)
	if(@car.save)
	  redirect_to :action => :index
	else
	  render :action => :new
	end
  end
  
  def show
    @car = Car.find(car_params[:id])
  end
  
  private
    def car_params
      params.require(:car).permit(:name, :start_odo)
    end
end
