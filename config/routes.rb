Rails.application.routes.draw do
  devise_for :users
  
  resources :users do 
    resources :registered_applications, only: [:show, :create, :new, :edit, :update, :destroy], as: :applications
  end
  
  resources :registered_applications, only: [] do
    resources :events, only: [:create, :destroy]
  end
  
  namespace :api, defaults: { format: :json } do
    match '/events', to: 'events#preflight', via: [:options]
    resources :events, only: [:create]
  end
  
  root 'registered_applications#index'

end
