Rails.application.routes.draw do
  
  root "sessions#home"
  
  #Sessions routes
  get "/login", to: "sessions#login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  #Signup Routes
  resources :sign_ups, only:[:new, :create]
  
  #User Routes with Nested User Plans Routes
  resources :users, only:[:show] do
  resources :plans
  
  #Full RESTful Activity Routes
  resources :activities
end
end