# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    get 'dashboard', to: 'pages#dashboard'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  get 'home', to: 'users_layout#home'

  namespace 'users' do
    resources :user_info
  end

  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
