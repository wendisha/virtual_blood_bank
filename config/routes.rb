Rails.application.routes.draw do
  root "static_pages#home"
  get "/signin", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get "/auth/facebook/callback", to: "sessions#create"
  get 'auth/failure', to: redirect('/')
  #github
  get '/auth/github/callback', to: 'sessions#create'
  
  delete "/signout", to: "sessions#destroy"
  resources :donors do
    resources :appointments, only: [:new, :create, :show, :index]
  end 
  resources :appointments
  resources :clinics, except: [:edit, :update,:destroy]

end
