Rails.application.routes.draw do

  root "chatrooms#index"
  devise_for :users

  resources :chatrooms do
    resources :messages, only: :create
  end
end
