Rails.application.routes.draw do
  devise_for :users

  root to: "records#index"

  resources :records
  resources :categories
  resources :tags

  get "up" => "rails/health#show", as: :rails_health_check
end
