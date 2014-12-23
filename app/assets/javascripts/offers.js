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

