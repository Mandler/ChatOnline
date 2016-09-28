placeholder_value = ""

ready = ->
  # On focusin input event get placeholder param
  $('input').focusin ->
    placeholder_value = $(this).attr('placeholder')
    $(this).attr('placeholder', '')

  # On focusout input event return earlier placeholder value
  $('input').focusout ->
    $(this).attr('placeholder', placeholder_value)

  # After button click load objects(ChatRooms) in json
  $('#all_chat_rooms_button:not(.active)').on 'click', ->
    $.get '/chat_rooms.json', (data) ->
      $('#chat_rooms_list').html('')
      for chat_room in data
        $('#chat_rooms_list').append('<li><a href="/chat_rooms/' + chat_room.id + '">' + chat_room.title + '</li>')

  $('#my_chat_rooms_button:not(.active)').on 'click', ->
    $.get '/display_chat_rooms', (data) ->
      $('#chat_rooms_list').html('')
      for chat_room in data
        $('#chat_rooms_list').append('<li><a href="/chat_rooms/' + chat_room.id + '">' + chat_room.title + '</li>')

# Use script after page loaded event (AJAX or standard)
$(document).on 'turbolinks:load', ready
