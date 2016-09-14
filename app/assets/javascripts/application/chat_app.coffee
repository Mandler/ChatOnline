placeholder_value = ""

ready = ->
  # On focusin input event get placeholder param
  $('input').focusin ->
    placeholder_value = $(this).attr('placeholder')
    $(this).attr('placeholder', '')

  # On focusout input event return earlier placeholder value
  $('input').focusout ->
    $(this).attr('placeholder', placeholder_value)

# Use script after page loaded event (AJAX or standard)
$(document).on 'turbolinks:load', ready
