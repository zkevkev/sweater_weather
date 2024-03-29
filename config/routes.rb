Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/api/v0/forecast', to: 'api/v0/forecast#show'
  post '/api/v0/users', to: 'api/v0/users#create'
  post '/api/v0/sessions', to: 'api/v0/sessions#create'
  post '/api/v0/road_trip', to: 'api/v0/roadtrips#create'
end
