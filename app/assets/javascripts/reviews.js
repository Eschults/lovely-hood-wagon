function highlightStars(star) {
  var id = star.attr('id');
  var stars = parseInt(id[id.length - 1]);
  id = id.slice(0, -2);

  for(i = 1; i <= stars; i++) {
    $('#' + id + '_' + i).removeClass('rating-star').addClass('rating-star-highlight');
  }
  for(i = stars + 1; i <= 5; i++) {
    $('#' + id + '_' + i).addClass('rating-star').removeClass('rating-star-highlight');
  }

  setStarValue(id, stars);

  $.ajax({
    type: "PUT",
    url: $('#edit-review').attr('action'),
    data: $('#edit-review').serialize()
  });
}

function highlightThumbs(thumbs) {
  var id = thumbs.attr('id');
  if(id == "thumbs-up") {
    $('#thumbs-up').removeClass('recommendation-thumbs').addClass('recommendation-thumbs-highlight');
    $('#thumbs-down').addClass('recommendation-thumbs').removeClass('recommendation-thumbs-highlight');
  } else {
    $('#thumbs-up').addClass('recommendation-thumbs').removeClass('recommendation-thumbs-highlight');
    $('#thumbs-down').removeClass('recommendation-thumbs').addClass('recommendation-thumbs-highlight');
  }

  setThumbsValue(id);

  $.ajax({
    type: "PUT",
    url: $('#edit-review').attr('action'),
    data: $('#edit-review').serialize()
  });
}

function setStarValue(id, stars) {
  $('#' + id).val(stars);
}

function setThumbsValue(id) {
  if(id == 'thumbs-up') {
    $('#recommendation').val(true);
  } else if(id == 'thumbs-down') {
    $('#recommendation').val(false);
  }
}

function highlightAll() {
  var ids = ['communication', 'punctuality', 'quality_price', 'respect']
  for(i in ids) {
    var score = parseInt($('#' + ids[i]).val());
    for(j = 1; j <= score; j++) {
      $('#' + ids[i] + '_' + j).removeClass('rating-star').addClass('rating-star-highlight');
    }
  }
  var bool = $('#recommendation').val();
  if(bool == "t") {
    $('#thumbs-up').removeClass('recommendation-thumbs').addClass('recommendation-thumbs-highlight');
  } else {
    $('#thumbs-down').addClass('recommendation-thumbs').removeClass('recommendation-thumbs-highlight');
  }
}