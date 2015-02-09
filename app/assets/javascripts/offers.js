function showService() {
  $('.show-service').removeClass("hidden");
  $('.show-rent').addClass("hidden");
  $('.show-sell').addClass("hidden");
  $('#sell').attr('name', '');
  $('#rent').attr('name', '');
  $('#service').attr('name', 'offer[nature]');
}

function showSell() {
  $('.show-sell').removeClass("hidden");
  $('.show-rent').addClass("hidden");
  $('.show-service').addClass("hidden");
  $('#service').attr('name', '');
  $('#rent').attr('name', '');
  $('#sell').attr('name', 'offer[nature]');
}

function showRent() {
  $('.show-rent').removeClass("hidden");
  $('.show-service').addClass("hidden");
  $('.show-sell').addClass("hidden");
  $('#service').attr('name', '');
  $('#sell').attr('name', '');
  $('#rent').attr('name', 'offer[nature]');
}

function showOrHidePicture(lettersBeforeId, item) {
  var id = item.attr('id');
  id = id.slice(lettersBeforeId, id.size);
  if($('#picture_' + id).attr('class').indexOf('hidden') > -1) {
    $('#picture_' + id).removeClass("hidden");
    $('#hide_picture_' + id).removeClass("hidden");
    $('#show_picture_' + id).addClass("hidden");
  } else {
    $('#picture_' + id).addClass("hidden");
    $('#hide_picture_' + id).addClass("hidden");
    $('#show_picture_' + id).removeClass("hidden");
  }
}

function adjustDivsHeights() {
  var windowHeight = $(window).height();
  var navHeight = $('nav').height();
  var panelHeadHeight = $('.panel-heading').height();
  var panelFootHeight = $('.panel-footer').height();
  var facetHeight = $('.facet').height();
  var searchHeight = $('.search-bar').height();

  var map = $('#map');
  var hits = $('#hits');
  map.css('height', windowHeight - navHeight - panelHeadHeight - 50);
  var mapHeight = map.height();
  $('#panel-body-map').css('height', windowHeight - navHeight - panelHeadHeight - 50);
  hits.css('max-height', mapHeight - facetHeight - searchHeight - panelFootHeight - 67);
  $('.offer-stream-box').last().css('border-bottom', 'none');
}