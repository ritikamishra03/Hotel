# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resource :otp, only: %i[new create]

  resources :users, only: %i[index edit update show destroy]
  resources :bookings do
    collection do
      get :check_availability
    end
    member do
      patch :check_in
      patch :check_out
      get :bill
    end
  end
  resources :rooms
  resources :room_types
  resources :invoices
  # resource :verification, only: [:new, :create/]
  get 'admin', to: 'home#admin'
  get 'staff', to: 'home#staff'
  get 'customer', to: 'home#customer'
  get 'logout', to: 'home#destroy'
  root 'home#index'
end
