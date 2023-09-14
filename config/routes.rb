Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}

  Sso::Client.all.each do |client|
    next unless client.client_and_secret?

    get "/users/auth/#{client.name}/callback", to: 'omniauth_callbacks#generic_callback', as: "#{client.name}_omniauth_callback"
  end

  get '/users/auth/failure', to: 'omniauth_callbacks#failure'
  
  resources :home, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :sso do
    resources :clients
  end
  root "home#index"
end
