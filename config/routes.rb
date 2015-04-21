Rails.application.routes.draw do
  resources :banks

  resources :movements

  resources :accounts

  resources :result_centers

  get 'payment_documents/generate'
  get 'payment_documents/new'
  post 'payment_documents/create'
  post 'payment_documents/insert'
  get 'payment_documents/payment'

  resources :subscriptions

  resources :salesmen

  resources :participants

  resources :companies

  resources :course_classes do
    member do
      get 'subscriptions'
      get 'prices'
    end
  end

  resources :trainers

  resources :courses

  devise_for :users
  resources :users
  devise_scope :user do
    authenticated :user do
      root 'visitors#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  root to: 'visitors#index'
end
