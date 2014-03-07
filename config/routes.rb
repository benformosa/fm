Fml::Application.routes.draw do
  root to: "cars#index"
  resources :cars
  resources :trips
end
