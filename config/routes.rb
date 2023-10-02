# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    get 'dashboard', to: 'pages#dashboard'
  end

  scope module: 'devise' do
    devise_for :users, controllers: {
      sessions: 'devise/users/sessions',
      registrations: 'devise/users/registrations'
    }
  end
  devise_scope :user do
    get 'sign_in', to: 'devise/users/sessions#new'
    post 'sign_in', to: 'devise/users/sessions#create'
    delete 'sign_out', to: 'devise/users/sessions#destroy'
    get 'sign_up', to: 'devise/users/registrations#new'
  end

  get 'home', to: 'users/users_pages#home'
  get 'contact', to: 'users/users_pages#contact'
  get 'about_app', to: 'users/users_pages#about_app'
  get 'term', to: 'users/users_pages#term'
  get 'about_us', to: 'users/users_pages#about_us'
  get 'support', to: 'users/users_pages#support'
  get 'mobile_app', to: 'users/users_pages#mobile_app'

  namespace 'users' do
    resources :user_info
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
