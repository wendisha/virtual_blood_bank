Rails.application.routes.draw do
  root "static_pages#home"
  get "/signin", to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get '/auth/facebook/callback' => 'sessions#create_from_omniauth'
  delete "/signout", to: "sessions#destroy"
  resources :donors
end
