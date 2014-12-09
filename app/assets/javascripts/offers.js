var type;
$(document).ready(function() {
  $('#type-select').on('change', function(e) {
    type = $('#type-select').val();
    if(type == "service") {
      $('.show-service').removeClass("hidden");
      $('.show-rent').addClass("hidden");
      $('.show-sell').addClass("hidden");
    }
    if(type == "sell") {
      $('.show-sell').removeClass("hidden");
      $('.show-rent').addClass("hidden");
      $('.show-service').addClass("hidden");
    }
    if(type =="rent") {
      $('.show-rent').removeClass("hidden");
      $('.show-service').addClass("hidden");
      $('.show-sell').addClass("hidden");
    }
  });
});