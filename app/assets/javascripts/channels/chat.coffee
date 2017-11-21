App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append data['message']

  send_message: (message) ->
    @perform 'send_message', message: message

$(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
  if event.keyCode is 13
    App.chat.send_message event.target.value
    event.target.value = ''
    event.preventDefault()
$(document).on 'ready', (event) ->
  $("#messages").scrollTop($("#messages")[0].scrollHeight)
  $('#messages').bind('DOMNodeInserted DOMNodeRemoved', () ->
    $("#messages").scrollTop($("#messages")[0].scrollHeight)
  )
