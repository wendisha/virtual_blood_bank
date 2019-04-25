Rails.application.routes.draw do
  root "static_pages#home"
  get "/signin", to: "sessions#new"
  get "/signup", to: "donors#new"
  post "/sessions/create", to: "sessions#create"
  get "/auth/facebook/callback", to: "sessions#create"
  get 'auth/failure', to: redirect('/')
  get '/donors_clinics', to: 'clinics#donors_clinics', :as => 'donors_clinics'
  delete "/signout", to: "sessions#destroy"

  resources :donors, except: [:new, :edit, :update] do
    resources :appointments, only: [:new, :create, :show, :index]
  end 

  resources :clinics, only: [:index, :show] do
    resources :appointments, only: [:new, :create, :show, :index]
  end 
end
