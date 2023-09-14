Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  get '/users/auth/:provider/callback', to: 'omniauth#generic_callback', as: 'omniauth_callback'
  get '/users/auth/failure', to: 'omniauth#failure'

  resources :home, only: [:index]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :sso do
    resources :clients
  end
  root 'home#index'
end
