
Rails.application.routes.draw do
  # User authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Core resources with translation member routes
  resources :health_records do
    member do
      post :translate      # POST /health_records/:id/translate
      get :toggle_view     # GET /health_records/:id/toggle_view
    end
  end

  # config/routes.rb
resources :translations, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  member do
    get :download
  end
end

  
  resources :translations

  # Home page
  root "pages#home"

  # Uptime check
  get "up" => "rails/health#show", as: :rails_health_check
end
