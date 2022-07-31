Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root "home#index"
  resources :home, only: %i[index]
  resources :posts, except: %i[index]
  resources :dashboard, only: %i[index]
  resources :creator, only: %i[index]
end
