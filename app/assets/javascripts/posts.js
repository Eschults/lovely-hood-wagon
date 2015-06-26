function comment() {
  $('.comment-link').on('click', function() {
    var id = $(this).attr('id');
    var lettersBeforeId = id.lastIndexOf('_') + 1;
    var postId = id.slice(lettersBeforeId, id.size);
    $('#comment_content_post_' + postId).focus();
    $('body').animate({
      scrollTop: $('#post_' + postId).offset().top - 70
    }, 1000);
  })
  $('.comment-activity-link').on('click', function() {
    var id = $(this).attr('id');
    var lettersBeforeId = id.lastIndexOf('_') + 1;
    var activityId = id.slice(lettersBeforeId, id.size);
    $('#comment_content_post_activity_' + activityId).focus();
    $('body').animate({
      scrollTop: $('#activity_' + activityId).offset().top - 85
    }, 1000);
  })
}
