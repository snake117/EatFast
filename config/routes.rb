Rails.application.routes.draw do
  
  root to: 'pages#index'

  get 'pages/about'
  get 'pages/privacy'
  get 'pages/terms'
  get 'pages/successfulorder', to:"pages#successfulorder"
  get 'pages/index', to:"pages#index"
  get 'pages/submitorder', to:"pages#submitorder"
  get 'pages/email', to:"pages#email"
  #get "../notifications/index" => "NotificationController#index"
  

  devise_for :users,
    controllers: {
      # omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations",
      sessions: "users/sessions"
    }

  resources :restaurants do
    resources :comments, module: :restaurants
    resources :menu_items
    resources :addresses, module: :restaurants
  end

  resources :comments do
    resources :comments, module: :comments
  end

  resources :categories

  resources :addresses

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
