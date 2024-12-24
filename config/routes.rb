Rails.application.routes.draw do
  resources :tasks
  resources :lists

  get "up" => "rails/health#show", as: :rails_health_check
end
