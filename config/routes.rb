Rails.application.routes.draw do
  resources :lists

  get "up" => "rails/health#show", as: :rails_health_check
end
