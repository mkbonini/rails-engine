Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchant_search#show'
      get '/merchants/find_all', to: 'merchant_search#index'
      get '/items/find', to: 'items_search#show'
      get '/items/find_all', to: 'items_search#index'
      
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], :controller => 'merchant_items'
      end
      resources :items do
        resources :merchant, only: [:index], :controller => 'item_merchant'
      end
    end
  end
end
