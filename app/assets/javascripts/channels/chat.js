jQuery(document).on('ready', function() {
  const messages = $('#messages');
  $('#messages-block').scrollTop($('#messages-block')[0].scrollHeight);
  $('#messages-block').bind('DOMNodeInserted DOMNodeRemoved', () => $('#messages-block').scrollTop($('#messages-block')[0].scrollHeight));
  App.global_chat = App.cable.subscriptions.create({
    channel: "ChatChannel",
    chat_id: messages.data('chat-id')
    }, {
    connected() {},
      // Called when the subscription is ready for use on the server

    disconnected() {},
      // Called when the subscription has been terminated by the server

    received(data) {
      $('#messages').append(data['message']);
    },

    send_message(message, chat_id) {
      return this.perform('send_message', {message, chat_id});
    }
  }
  );

  return $("button#btn-chat").on('click', function(event) {
    const target = $('input#btn-input.form-control.input-sm');
    if ($(target).val() !== '') {
      App.global_chat.send_message(target.val(), messages.data('chat-id'));
      $(target).val('');
    }
    return event.preventDefault();
  });
});