class ChatRoomsController < ApplicationController
  before_filter :authenticate_user!

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

  # def index
  #   # @chat_rooms = ChatRoom.find_by_title_or_author(params[:search]) || ChatRoom.all
  # end

  # def new
  #   @chat_room = ChatRoom.new
  # end

  # def create
  #   @chat_room = current_user.chat_rooms.build(chat_room_params)
  #   if @chat_room.save
  #     redirect_to chat_rooms_path
  #   else
  #     render 'new'
  #   end
  # end

  # def show
  #   @chat_room = ChatRoom.includes(:messages).find(params[:id])
  #   @message = Message.new
  # end

  # private

  # def chat_room_params
  #   params.require(:chat_room).permit(:title)
  # end
end
