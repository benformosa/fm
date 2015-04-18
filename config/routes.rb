Fml::Application.routes.draw do
  devise_for :users
  root to: "cars#index"
  resources :cars

  resources :trips do
    get :autocomplete_trip_location, :on => :collection
  end

  resources :trips

  get 'reports/', :controller => 'reports', :action => 'index'
  get 'reports/distanceperdriver', :controller => 'reports', :action => 'distanceperdriver'
  get 'reports/personalcostperdriver', :controller => 'reports', :action => 'personalcostperdriver'
  get 'reports/distancepercar', :controller => 'reports', :action => 'distancepercar'
end
