
jQuery(document).on 'ready', ->
  messages = $('#messages')

  App.global_chat = App.cable.subscriptions.create {
    channel: "ChatChannel"
    chat_id: messages.data('chat-id')
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#messages').append data['message']

    send_message: (message, chat_id) ->
      @perform 'send_message', message: message, chat_id: chat_id

  $(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
    if event.keyCode is 13
      App.global_chat.send_message event.target.value, messages.data('chat-id')
      event.target.value = ''
      event.preventDefault()
  $(document).on 'ready', (event) ->
    $("#messages").scrollTop($("#messages")[0].scrollHeight)
    $('#messages').bind('DOMNodeInserted DOMNodeRemoved', () ->
      $("#messages").scrollTop($("#messages")[0].scrollHeight)
    )
