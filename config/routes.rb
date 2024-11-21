Rails.application.routes.draw do
  resource :example, constraints: -> { Rails.env.development? }
  mount ActionCable.server => '/cable'
  get "about/index"
  get "home/index"

  resources :notes, only: [:index, :new, :create, :update, :show]
  resources :study_session, only: [:index, :new, :create, :update, :show]
  resources :session_message, only: [:create]
  resources :queries, only: [:index, :create]

  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations"}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
