Fml::Application.routes.draw do
  devise_for :users
  root to: "cars#index"
  resources :cars

  resources :trips do
    get :autocomplete_trip_location, :on => :collection
  end

  resources :trips

  get 'reports/tripspermonth/(:id)', :controller => 'cars', :action => 'tripspermonth'
  get 'reports/kmpermonth/(:id)', :controller => 'cars', :action => 'kmpermonth'
end
