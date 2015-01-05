function stickDown() {
  var $preview = $('.conversation-preview').last();
  var previewHeight = 0;
  $('.conversation-preview').each(function() {
    previewHeight += $(this).height() + 21;
  });
  var $target = $('.stick-down-target').first();
  $target.addClass('stick-down');
  var parentHeight = $('.stick-down').parent().parent().height();
  var siblingsHeight = 0;
  $('.stick-down-target').each(function() {
    siblingsHeight += $(this).height() + 11;
  });
  if(parentHeight-siblingsHeight > 0) {
    $target.css('margin-top', parentHeight-siblingsHeight);
  }
  if(parentHeight-previewHeight > 0) {
    $preview.css('margin-bottom', parentHeight-previewHeight);
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
