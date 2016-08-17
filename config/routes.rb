Rails.application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  namespace :admin do
    resources :users
  end

<<<<<<< HEAD
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
=======
  resources :users, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
>>>>>>> 91ad1eb187f49d7db53cdce98238607c0ae45d2b
  root to: 'movies#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html'
end
