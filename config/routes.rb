Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :tasks
  resources :lists

  get "up" => "rails/health#show", as: :rails_health_check
end
