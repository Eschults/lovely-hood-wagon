var type;
var name;
$(document).ready(function() {
  type = $('#type-select').val();
  if(type == "service") {
    $('.show-service').removeClass("hidden");
    $('.show-rent').addClass("hidden");
    $('.show-sell').addClass("hidden");
    $('#sell').attr('name', '');
    $('#rent').attr('name', '');
    $('#service').attr('name', 'offer[nature]');
  }
  if(type == "sell") {
    $('.show-sell').removeClass("hidden");
    $('.show-rent').addClass("hidden");
    $('.show-service').addClass("hidden");
    $('#service').attr('name', '');
    $('#rent').attr('name', '');
    $('#sell').attr('name', 'offer[nature]');
  }
  if(type =="rent") {
    $('.show-rent').removeClass("hidden");
    $('.show-service').addClass("hidden");
    $('.show-sell').addClass("hidden");
    $('#service').attr('name', '');
    $('#sell').attr('name', '');
    $('#rent').attr('name', 'offer[nature]');
  }

  $('#type-select').on('change', function(e) {
    type = $('#type-select').val();
    if(type == "service") {
      $('.show-service').removeClass("hidden");
      $('.show-rent').addClass("hidden");
      $('.show-sell').addClass("hidden");
      $('#sell').attr('name', '');
      $('#rent').attr('name', '');
      $('#service').attr('name', 'offer[nature]');
    }
    if(type == "sell") {
      $('.show-sell').removeClass("hidden");
      $('.show-rent').addClass("hidden");
      $('.show-service').addClass("hidden");
      $('#service').attr('name', '');
      $('#rent').attr('name', '');
      $('#sell').attr('name', 'offer[nature]');
    }
    if(type =="rent") {
      $('.show-rent').removeClass("hidden");
      $('.show-service').addClass("hidden");
      $('.show-sell').addClass("hidden");
      $('#service').attr('name', '');
      $('#sell').attr('name', '');
      $('#rent').attr('name', 'offer[nature]');
    }
  })


});