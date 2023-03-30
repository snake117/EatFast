Rails.application.routes.draw do
  root to: 'pages#index'

  get 'pages/about'
  get 'pages/privacy'
  get 'pages/terms'
  
  devise_for :users,
    controllers: {
      # omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
      sessions: "users/sessions"
    }

  resources :restaurants do
    resources :comments, module: :restaurants
  end

  resources :comments do
    resources :comments, module: :comments
  end

  resources :categories

  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
