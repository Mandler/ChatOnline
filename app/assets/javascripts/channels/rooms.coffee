jQuery(document).on 'turbolinks:load', ->
  messages_to_bottom = -> $(document).find('.messages-block').scrollTop($('.messages-block').prop("scrollHeight"))

  $(document).on 'submit', '.new_message', (e) ->
    $this = $(this)
    textarea = $this.find('#message_body')
    if $.trim(textarea.val()).length > 0
      App.global_chat.send_message textarea.val(), $this.closest('.text-block').data('chat-room-id')
      textarea.val('')
    e.preventDefault()
    return false

  $('.new-conversation').click ->
    sender_id = $(this).data('sid')
    recipient_id = $(this).data('rip')
    $.post '/chat_rooms', { sender_id: sender_id, recipient_id: recipient_id }, (data) ->
      chat_id = data.ChatRoom_id
      if $("#chat_room_#{chat_id}").length == 0
        $.get "/chat_room_show/#{chat_id}", (data) ->
          $('#messages').append data
          messages_to_bottom()
          App.global_chat = App.cable.subscriptions.create {
            channel: "ChatRoomsChannel",
            chat_room_id: chat_id
          },
          connected: ->
            # Called when the subscription is ready for use on the server

          disconnected: ->
            # Called when the subscription has been terminated by the server

          userIsCurrentUser: (user_id) ->
            parseInt(user_id) == parseInt($('meta[name=current-user]').attr('id'))

          received: (data) ->
            message = $(data['message'])
            send_to_user = data['user_id']
            chat_id = data['chat_room_id']
            if @userIsCurrentUser(send_to_user)
              message = message.removeClass('card').addClass('right-card')
            else
              message = message.removeClass('card').addClass('left-card')
            $(document).find("#chat_room_#{chat_id} .messages-block").append message
            messages_to_bottom()

          send_message: (message, chat_room_id) ->
            @perform 'send_message', message: message, chat_room_id: chat_room_id
    return false
