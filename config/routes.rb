# frozen_string_literal: true

Rails.application.routes.draw do
  get 'projects/:id/destroy', to: 'projects#destroy_student', as: :deleteproject
  resources :reports do
    collection do
      get :monthly
      get :weekly
      get :daily
      get :show_monthly
      get :show_weekly
      get :show_daily
      post :show_daily
      post :send_daily
    end
  end
  resources :profiles
  resources :home do
    collection do
      get :monthly
      get :weekly
      get :daily

      post :send_daily
    end
  end
  resources :projects do
    collection do
      post :toggle_status
    end
  end

  resources :recipients
  devise_for :users
  resources :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
