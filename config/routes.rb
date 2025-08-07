Rails.application.routes.draw do
  # User authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }


  # Core resources
  resources :health_records
  resources :translations

  # Home page
  root "pages#home"

  # Uptime check
  get "up" => "rails/health#show", as: :rails_health_check
end
