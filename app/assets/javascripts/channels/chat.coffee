
jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  $('#messages-block').scrollTop($('#messages-block')[0].scrollHeight)
  $('#messages-block').bind('DOMNodeInserted DOMNodeRemoved', () ->
    $('#messages-block').scrollTop($('#messages-block')[0].scrollHeight)
  )

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
      $('#audio').get(0).play()

    send_message: (message, chat_id) ->
      @perform 'send_message', message: message, chat_id: chat_id

  $("button#btn-chat").on 'click', (event) ->
    target = $('input#btn-input.form-control.input-sm')
    if $(target).val() != ''
      App.global_chat.send_message target.val(), messages.data('chat-id')
      $(target).val('')
    event.preventDefault()

