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
    end
  end
  resources :home do
    collection do
      get :monthly
      get :weekly
      get :daily
      
      post :send_daily
      end
  end
  resources :projects
  resources :recipients
  devise_for :users
  resources :users
  get 'settings/profile', to: 'settings#profile', as: :settings_profile
  post 'settings/profile', to: 'settings#update', as: :update_settings_profile
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
