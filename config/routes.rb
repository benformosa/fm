Fml::Application.routes.draw do
  devise_for :users
  root to: "cars#index"
  resources :cars
  resources :trips
end
