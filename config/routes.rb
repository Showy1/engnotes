Rails.application.routes.draw do
  root 'cards#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      # get 'cards/index'
      # get 'cards/show'
      resources :cards
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
