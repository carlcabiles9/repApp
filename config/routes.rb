# frozen_string_literal: true

Rails.application.routes.draw do
  get "reports/download_pdf" => "reports#download_pdf", :as => 'download_pdf'
  get "reports/user_pdf" => "reports#user_pdf", :as => 'user_pdf'

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
    
      get  '/show_report/:id', :to => 'home#show_report'
      post  '/send_request/:id', :to => 'home#send_request'


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
  resources :users do
    collection do

    end
  end

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
