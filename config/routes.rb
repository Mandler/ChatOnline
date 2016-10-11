Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :chat_rooms, only: [:index, :new, :create] #Delete show route

  get '/display_chat_rooms', to: 'chat_rooms#display_chat_rooms', defaults: { format: :json }

  get '/chat_room_show/:id', to: 'chat_rooms#show'

  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'
end
