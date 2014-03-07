class CarsController < ApplicationController
  def index
    @cars = Car.all
  end
  
  def new
    @car = Car.new
  end
  
  def create
    @car = Car.new(params[:car])
	if(@car.save)
	  redirect_to :action => :index
	else
	  render :action => :new
	end
  end
  
  def show
    @car = Car.find(params[:id])
  end
end