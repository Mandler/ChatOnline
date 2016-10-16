readCookie = (name) ->
    field_to_search = name + "="
    ca = document.cookie.split(';')
    for i in [0..ca.length] by 1
      c = ca[i]
      while (c.charAt(0)==' ')
        c = c.substring(1,c.length)
      if c.indexOf(field_to_search) == 0
        return c.substring(field_to_search.length,c.length)
    return null

messages_to_bottom = (id) -> $(document).find("#chat_room_#{id} .messages-block").scrollTop($("#chat_room_#{id} .messages-block").prop("scrollHeight"))

window.CheckActionCable = []

jQuery(document).on 'turbolinks:load', ->

  if readCookie('user.id')
    current_user_id = $('meta[name=current-user]').attr('id')
    App.global_notification = App.cable.subscriptions.create {
      channel: "NotificationChannel",
      current_user_id: current_user_id
    },

    received: (data) ->
      $.post '/chat_rooms', { sender_id: data.send_to, recipient_id: data.sender_id }, (data) ->
        chat_id = data.ChatRoom_id
        if $("#chat_room_#{chat_id}").length == 0
          $.get "/chat_room_show/#{chat_id}", (data) ->
            $('#messages').append data
            messages_to_bottom(chat_id)
            unless window.CheckActionCable["action_cable_#{chat_id}"]
              window.CheckActionCable["action_cable_#{chat_id}"] = "Exist"
              App.global_chat = App.cable.subscriptions.create {
                channel: "ChatRoomsChannel",
                chat_room_id: chat_id
              },
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
                messages_to_bottom(chat_id)

              send_message: (message, chat_room_id) ->
                @perform 'send_message', message: message, chat_room_id: chat_room_id
