Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :lists do
    resources :tasks do
      member do
        patch :toggle_complete
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
