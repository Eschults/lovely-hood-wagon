function highlightStars(star) {
  var id = star.attr('id');
  var index = parseInt(id[id.length - 1]);
  id = id.slice(0, -1);
  for(i = 1; i <= index; i++) {
    $('#' + id + i).removeClass('rating-star').addClass('rating-star-highlight');
  }
  for(i = index + 1; i <= 5; i++) {
    $('#' + id + i).addClass('rating-star').removeClass('rating-star-highlight');
  }
}