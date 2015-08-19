Fm::Application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'cars#index', :as => :authenticated_root
  end
  root :to => redirect('/users/sign_in')
  
  resources :cars

  resources :trips do
    get :autocomplete_trip_location, :on => :collection
  end

  resources :trips

  get 'reports/', :controller => 'reports', :action => 'index'
end
