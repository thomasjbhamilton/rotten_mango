Rails.application.routes.draw do

  root to: 'movies#index'


  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  namespace :admin do
    resources :users
  end

  resources :users, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html'
end
