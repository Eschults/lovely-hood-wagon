function stickDown() {
  // setVariables for div inbox (left)
  var $preview = $('.conversation-preview').last();
  var previewHeight = 0;
  $('.conversation-preview').each(function() {
    previewHeight += $(this).height() + 11;
  });

  // setVariables for div conversation (right)
  var $target = $('.stick-down-target').first();
  var parentHeight = $target.parent().parent().height();
  var siblingsHeight = 0;
  $('.stick-down-target').each(function() {
    siblingsHeight += $(this).height() + 11;
  });
  if($(window).width() > 991) {

    // margin-bottom on last conversation preview
    if(parentHeight-previewHeight > 0) {
      $preview.css('margin-bottom', parentHeight-previewHeight);
    }

    // margin-top on first message
    if(parentHeight-siblingsHeight > 0) {
      $target.css('margin-top', parentHeight-siblingsHeight);
    }
  } else {
    $preview.css('margin-bottom', 0);
    $target.css('margin-top', 0);
  }
}

function stylizeConversationPreview() {
  var id = window.location.href.slice(42, -14);
  $('#conversation_' + id).css('background-color', 'rgb(180, 180, 180)');
  $('#conversation_' + id).children().each(function() {
    $(this).css('color', '#ffffff');
  });
  $('#conversation_' + id).children().children().each(function() {
    $(this).css('color', '#ffffff');
  });
  $('#conversation_' + id).children().children().children().each(function() {
    $(this).css('color', '#ffffff');
  });
}

function setMarginTop() {
  $('.img-medium-square > .img').each(function() {
    var imgHeight = $(this).height();
    $(this).css('margin-top', ($(this).parent().height()-imgHeight)/2);
  });
}

function colorMessagesBadgeOnHover() {
  $('#messages-nav-link').on('mouseenter', function() {
    $('#messages-nav-link .badge').addClass('hover')
  })
  $('#messages-nav-link').on('mouseleave', function() {
    $('#messages-nav-link .badge').removeClass('hover')
  })
}

function togglePaddingAndBorder() {
  if($(window).width() > 991) {
    $('.col-md-4').addClass('inbox');
    $('.col-md-4 .panel').attr('id', 'panel-inbox');
    $('.col-md-8').addClass('conversation');
    $('.col-md-8 .panel').attr('id', 'panel-conversation');
  } else {
    $('.col-md-4').removeClass('inbox');
    $('.col-md-4 .panel').attr('id', '');
    $('.col-md-8').removeClass('conversation');
    $('.col-md-8 .panel').attr('id', '');
  }
}