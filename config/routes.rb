# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home', to: 'users/pages#home'
  get 'contact', to: 'users/pages#contact'
  get 'about_app', to: 'users/pages#about_app'
  get 'term', to: 'users/pages#term'
  get 'about_us', to: 'users/pages#about_us'
  get 'support', to: 'users/pages#support'
  get 'mobile_app', to: 'users/pages#mobile_app'

  root 'users/pages#home'

  scope module: 'devise' do
    devise_for :admins, controllers: {
      sessions: 'devise/admins/sessions'
    }
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

  namespace :admins do
    get 'dashboard', to: 'pages#dashboard'
  end

  namespace 'users' do
    resource :user_infos
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
