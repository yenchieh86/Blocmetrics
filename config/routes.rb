Rails.application.routes.draw do
  devise_for :users
  
  resources :users do 
     resources :registered_applications, only: [:show, :create, :new, :edit, :update, :destroy], as: :applications
  end
  
  
  
  root 'registered_applications#index'

end
