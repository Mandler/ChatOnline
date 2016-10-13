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

jQuery(document).on 'turbolinks:load', ->

  # if readCookie('user.id')
  App.global_notification = App.cable.subscriptions.create {
    channel: "NotificationChannel"
  },

  received: (data) ->
    console.log 'Test'
