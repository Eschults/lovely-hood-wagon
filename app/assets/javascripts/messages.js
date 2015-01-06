function stickDown() {
  // setVariables for div inbox (left)
  var $preview = $('.conversation-preview').last();
  var previewHeight = 0;
  $('.conversation-preview').each(function() {
    previewHeight += $(this).height() + 21;
  });

  // setVariables for div conversation (right)
  var $target = $('.stick-down-target').first();
  var parentHeight = $target.parent().parent().height();
  var siblingsHeight = 0;
  $('.stick-down-target').each(function() {
    siblingsHeight += $(this).height() + 11;
  });

  // margin-bottom on last conversation preview
  if(parentHeight-previewHeight > 0) {
    $preview.css('margin-bottom', parentHeight-previewHeight);
  }

  // margin-top on first message
  if(parentHeight-siblingsHeight > 0) {
    $target.css('margin-top', parentHeight-siblingsHeight);
  }
}


function stylizeConversationPreview() {
  var id = window.location.href.slice(36, -14);
  $('#conversation_' + id).css('background-color', 'rgb(180, 180, 180)');
  $('#conversation_' + id).children().children().children().children().each(function() {
    $(this).css('color', '#ffffff');
  });
  $('#conversation_' + id).children().children().children().each(function() {
    $(this).css('color', '#ffffff');
  });
}
