class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  layout false, only: :show

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  def create
    if ChatRoom.between(params[:sender_id],params[:recipient_id]).present?
      @chat_room = ChatRoom.between(params[:sender_id],params[:recipient_id]).first
    else
      @chat_room = ChatRoom.create!(chat_room_params)
    end

    render json: { ChatRoom_id: @chat_room.id }
  end

  private
  def chat_room_params
    params.permit(:sender_id, :recipient_id)
  end
end
