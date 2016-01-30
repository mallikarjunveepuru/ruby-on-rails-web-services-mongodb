Rails.application.routes.draw do
  root to: 'racers#index'

  resources :racers
end
