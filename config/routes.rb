Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}, path_prefix: "devise"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root "home#index"
  resources :like, only: %i[create destroy]
  resources :users, only: %i[index]
  resources :home, only: %i[index]
  
  namespace :dashboard do
    resources :sketches, only: %i[index show]
    resources :tutorials, only: %i[index show]
  end
  
  resources :dashboard, only: %i[index show]

  resources :posts do
    resources :comments, only: %i[create destroy]
  end

  resources :subscribers, only: %i[index]

  resources :plans, only: %i[index]

  namespace :plans do
    get "patron"
    get "benefactor"
  end

  namespace :payments do
    post "card"
  end
end
