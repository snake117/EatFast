Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  get 'pages/about'
  get 'pages/privacy'
  get 'pages/terms'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
