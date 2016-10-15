class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  layout false, only: :show

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  def create
    if ChatRoom.between(params[:sender_id], params[:recipient_id]).present?
      @chat_room = ChatRoom.between(params[:sender_id], params[:recipient_id]).first
    else
      @chat_room = ChatRoom.create!(chat_room_params)
    end

    render json: { ChatRoom_id: @chat_room.id }
  end

  def params_form
  end

  def controll_params_form
    return @regexp_value = special_regexp(params_check[0]) if params_check[0].present?

    if params_check[1].present? && params_check[2].present?
      return @regexp_value = special_regexp(params_check[1], 'number', [6]) && special_regexp(params_check[2], 'number', [4])
    elsif params_check[2].present? && params_check[3].present? && params_check[4].present?
      return @regexp_value = special_regexp(params_check[2], 'number', [4]) && special_regexp(params_check[3], 'number', [1,2]) && special_regexp(params_check[4], 'number', [2])
    elsif params_check[6].present?
      return @regexp_value = special_regexp(params_check[6], 'email')
    end
  end

  private
  def chat_room_params
    params.permit(:sender_id, :recipient_id)
  end

  def params_check
    params[:params_to_check]
  end

  # Types - [number, text, email]
  def special_regexp(value, type = 'text', length = [])
    case type
      when 'number'
        number_scope = ".{#{length.first}}"
        if length.count > 1
          number_scope = ''
          length.each do |length_value, index|
            number_scope = number_scope + ".{#{length_value}}|"
          end
          number_scope.chop
        end
        byebug
        return /^(?=[0-9]*$)(?:#{number_scope})$/ === value
      when 'text'
        return /^[a-zA-Z0-9]{0,40}$/ === value
      when 'email'
        return /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i === value
    end
  end
end
