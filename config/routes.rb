Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'orders/create'
      get 'orders/get'
      # get 'orders/create'
      # get 'addresses/create'
      resources :contacts
      resources :addresses, only: [:create, :index]
      resources :products, only: [:create]
      resources :orders, only: [:create, :index]
      
 
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
