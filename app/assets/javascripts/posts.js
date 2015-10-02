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

function imageUpload() {
  $('#camera').on('click', function() {
    $('#post_picture').click();
  })
  $('#post_picture').on('change', function() {
    var path = $('#post_picture').val().slice($('#post_picture').val().lastIndexOf("\\") + 1, $('#post_picture').val().length)
    if(path.length > 12) {
      path = path.slice(0, 11) + "..."
    }
    $('#placeholder').text(path)
    $('#check').removeClass('hidden')
  })
}

function likePopover() {
  $('.link-popover').popover({
    html: true,
    trigger: "hover",
    placement: "top"
  })
}

function resizeStuff() {
  if($(window).width() < 530) {
    $('.js-target').removeClass('width-92')
  } else {
    $('.js-target').addClass('width-92')
  }
  $(window).on('resize', function() {
    if($(window).width() < 530) {
      $('.js-target').removeClass('width-92')
    } else {
      $('.js-target').addClass('width-92')
    }
  })
  if($(window).width() < 376) {
    $('.js-other-target').removeClass('col-xs-10').addClass('col-xs-9')
  } else {
    $('.js-other-target').addClass('col-xs-10').removeClass('col-xs-9')
  }
  $(window).on('resize', function() {
    adjustIconsSizeSimple(420);
    if($(window).width() < 376) {
      $('.js-other-target').removeClass('col-xs-10').addClass('col-xs-9')
    } else {
      $('.js-other-target').addClass('col-xs-10').removeClass('col-xs-9')
    }
  })
}

function postsPicMaxSize() {
  $.each($('.img-meta'), function(index, item) {
    if(parseInt($(item).height()) < 394) {
      $(item).css('width', '100%')
    } else {
      $(item).css('width', 'auto')
    }
  })
  // $('.img-post').each(function() {
  //   if($(this).height() < 394) {
  //     $(this).css('padding-left', 0).css('padding-right', 0).css('padding-bottom', 0)
  //   } else {
  //     $(this).css('padding-left', '15px').css('padding-right', '15px').css('padding-bottom', '15px')
  //   }
  // })
}

function postsIndex() {
  imageUpload()
  $('#wall-nav-link').addClass('hover');
  comment();
  adjustIconsSizeSimple(420);
  likePopover()
  resizeStuff()
  postsPicMaxSize()
}