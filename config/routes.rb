Rails.application.routes.draw do

  resources :properties do
    resource :transactions
  end

  resources :transactions

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root 'home#index'

  get '/railspage', to: 'pages#index'

end  
