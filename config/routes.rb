Rails.application.routes.draw do
  root "chatrooms#index"
  devise_for :users

  resources :users, only: [:index, :show] do
    member do
      get 'chat', to: 'private_messages#chat'
      post 'send_message', to: 'private_messages#create'
    end
  end

  resources :chatrooms do
    resources :messages, only: :create
  end

  resources :friendships, only: [:create, :destroy]
end
