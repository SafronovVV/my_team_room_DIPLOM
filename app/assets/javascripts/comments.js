function postNewComment (element) {
  let parsedAvatarUrl = $(element).attr('data-user-avatar');
  let photoUrl = parsedAvatarUrl.includes('default') ? '/assets/' + parsedAvatarUrl : parsedAvatarUrl;
  let userPath = "/users/" + $(element).attr('data-user-id');
  let username = $(element).attr('data-user-name');
  let taskId = $(element).attr('data-task-id');
  let commentContent = $('input#comment_body').val();
  let parameters = {
    task_id: taskId,
    comment: {
      body: commentContent
    }
  };
  let requestService = new RequestService ('/comments', parameters);
  let commentBlockTemplate =
    "<div class='row comment'>" +
      "<div class='col-md-1 col-xs-3'>" +
        "<div class='comment-image'>" +
          `<img class='img-responsive.user-photo' src='${photoUrl}' alt='Default user logo'>` +
        "</div>" +
      "</div>" +
      "<div class='col-md-6 col-xs-9'>" +
        "<div class='comment-panel panel panel-default'>"+
          "<div class='panel-heading'>" +
            `<strong><a href='${userPath}'>@${username}</a></strong>` +
            "<span class='text-muted hidden-xs'></span> прокомментировал только что" +
          "</div>" +
          `<div class='panel-comment-body'>${commentContent}</div>`+
        "</div>" +
      "</div>" +
    "</div>"
  if (commentContent == "") return;
  requestService.post(() => {
    $('input#comment_body').val("");
    let commentsNumber = parseInt($('h3#comments-number').text().split(' ')[0]) + 1;
    $('h3#comments-number').text(commentsNumber + " комментариев");
    $('button.btn.tr_submit_button').after(commentBlockTemplate);
  });
}
