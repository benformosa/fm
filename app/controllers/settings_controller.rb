class SettingsController < ApplicationController
  def index
    @settings = Settings.unscoped
  end

  def edit
    @setting = Settings.unscoped.find(params[:id])
  end

  def update
    @setting = Settings.unscoped.find(params[:id])
    if params[:number]
      @setting.convert_to_number
    end
    if @setting.update_attributes(setting_params)
      redirect_to :action => :index
    else
      render :action => edit
    end
  end

  def setting_params
    params.require(:settings).permit(:value, :number)
  end
end
