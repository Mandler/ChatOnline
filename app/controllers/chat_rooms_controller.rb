class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.find_by_title_or_author(params[:search]) || ChatRoom.all
  end

  def display_chat_rooms
    @own_chat_rooms = ChatRoom.find_by_current_user(current_user.id)
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).friendly.find(params[:id])
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
