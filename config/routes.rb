Rails.application.routes.draw do
  root "static_pages#home"
  get "/signin", to: "sessions#new"
  resources :donors
end
