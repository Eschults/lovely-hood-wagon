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

function showOrHidePicture(item) {
  var id = item.attr('id');
  var lettersBeforeId = id.indexOf("_") + 1;
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

function toggleFacets() {
  if($(window).width() < 1291) {
    $('.facet').addClass('hidden');
  } else {
    $('.facet').removeClass('hidden');
  }
}

function togglePaddingRightOnSm4() {
  if($(window).width() < 768) {
    $('.col-sm-4').removeClass('padding-left-none').addClass('padding-none').css('margin-left', 15);
  } else {
    $('.col-sm-4').addClass('padding-left-none').removeClass('padding-none').css('margin-left', 0);
  }
}

function adjustNatureIconsSize() {
  if($(window).width() < 720) {
    $('.img-nature-box img').css('width', 40)
  } else if($(window).width() > 976 && $(window).width() < 1300) {
    $('.img-nature-box img').css('width', 40)
  } else {
    $('.img-nature-box img').css('width', 60)
  }
}

function adjustIconsSizeSimple(width) {
  if($(window).width() < width) {
    $('.img-nature-box img').css('width', 40)
  } else {
    $('.img-nature-box img').css('width', 60)
  }
}

function togglePaddingRight() {
  if($(window).width() > 991) {
    $('.col-md-6').first().removeClass('padding-right-none');
  } else {
    $('.col-md-6').first().addClass('padding-right-none');
  }
}