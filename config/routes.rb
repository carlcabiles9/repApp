Rails.application.routes.draw do
  
  get 'projects/:id/destroy', to: 'projects#destroy_student', as: :deleteproject
  resources :reports
  # devise_for :users 
  # root :to => 'projects#index'
  root to: "home#index"
  resources :projects
  resources :recipients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
end