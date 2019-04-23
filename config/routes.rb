Rails.application.routes.draw do
  root "static_pages#home"
  get "/signin", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get '/auth/facebook/callback' => 'sessions#create_from_omniauth'
  #get 'auth/failure', to: redirect('/')
  
  delete "/signout", to: "sessions#destroy"
  resources :donors do
    resources :appointments, only: [:new, :create, :show, :index]
  end 
  resources :appointments
  resources :clinics, except: [:edit, :update,:destroy]

end
