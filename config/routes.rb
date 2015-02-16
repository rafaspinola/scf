Rails.application.routes.draw do
  resources :subscriptions

  resources :salesmen

  resources :participants

  resources :companies

  resources :course_classes

  resources :trainers

  resources :courses

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
