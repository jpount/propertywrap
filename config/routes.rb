Rails.application.routes.draw do
  resources :transactions

  resources :properties

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root 'home#index'

  get '/railspage', to: 'pages#index'

end  
