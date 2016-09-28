class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.find_by_title_or_author(params[:search]) || ChatRoom.all
    respond_to do |format|
      format.html
      format.json {
        render json: @chat_rooms
      }
    end
  end

  def display_chat_rooms
    @own_chat_rooms = ChatRoom.find_by_current_user(current_user.id)
    render json: @own_chat_rooms
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
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
