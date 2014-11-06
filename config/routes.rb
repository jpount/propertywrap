Rails.application.routes.draw do

  resources :properties do
    resources :transactions
  end

  #resources :transactions
  resources :property_data
  resources :image


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root 'home#index'

  get '/railspage', to: 'pages#index'

end  
