Rails.application.routes.draw do
  
  get 'projects/:id/destroy', to: 'projects#destroy_student', as: :deleteproject
  resources :reports do
  collection do
    get :monthly
    get :weekly
    get :daily
    
  end
  end
  resources :home do
    collection do
      get :monthly
      get :weekly
      get :daily
      
    end
  end
  resources :projects
  resources :recipients
  devise_for :users 
    resources :users
   
end