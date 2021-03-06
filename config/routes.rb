Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'forecast#show'
  resource :forecast, only: :show, controller: :forecast

  namespace :api do
    resources :cities, only: :index
  end
end
