Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :passwords, param: :token
  resources :lists do
    resources :tasks do
      member do
        patch :toggle_complete
      end
    end
  end
  resources :users, only: [:new, :create]
  get "up" => "rails/health#show", as: :rails_health_check
  root to: 'sessions#new'
end
