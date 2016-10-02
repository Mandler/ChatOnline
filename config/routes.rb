Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :chat_rooms, only: [:index, :new, :create, :show]

  get '/display_chat_rooms', to: 'chat_rooms#display_chat_rooms', defaults: { format: :json }

  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'
end
