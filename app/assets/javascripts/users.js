function showInfo() {
  $('#user-info').removeClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-recommendations').addClass("hidden");
  $('#my-info').addClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-recos').removeClass("strong");
}

function showPic() {
  $('#user-info').addClass("hidden");
  $('#user-picture').removeClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-recommendations').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').addClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-recos').removeClass("strong");
}

function showTrust() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').removeClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-recommendations').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').addClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-recos').removeClass("strong");
}

function showComments() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-comments').removeClass("hidden");
  $('#user-recommendations').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-comments').addClass("strong");
  $('#my-recos').removeClass("strong");
}

function showRecos() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-recommendations').removeClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-recos').addClass("strong");
}

function filled(field) {
  var value = field.val();
  if (value == "") {
    $(field).parent().addClass("has-error").removeClass("has-success");
  }
  else {
    $(field).parent().addClass("has-success").removeClass("has-error");
  }
}

function test_field_at_focusout(field) {
  field.on("focusout", function(event) {
    field = field;
    filled(field);
  });
}

function test_all_fields() {
  if ($(".has-error").length >= 1) {
    return false;
  } else {
    return true;
  }
}

function adjustImgMedium() {
  $('.img-medium > img').each(function(i) {
    height = $(this).height();
    width = $(this).width();
    ratio = width / height;
    if(height < width) {
      $(this).css('margin-left', (60 - 60 * ratio) / 2);
      $(this).css('margin-right', (60 - 60 * ratio) / 2);
      $(this).addClass("total-height").removeClass('img');
    } else {
      $(this).css('margin-top', (60 - 60 / ratio) / 2);
      $(this).css('margin-bottom', (60 - 60 / ratio) / 2);
      $(this).addClass("total-width");
    }
  });
}

function adjustImgSmall() {
  $('.img-small > img').each(function(i) {
    height = $(this).height();
    width = $(this).width();
    ratio = width / height;
    if(height < width) {
      $(this).addClass("total-height").removeClass('img');
      $(this).css("margin-left", (38 - 38 * ratio) / 2);
      $(this).css("margin-right", (38 - 38 * ratio) / 2);
    } else if(height > width) {
      $(this).addClass("total-width");
      $(this).css('margin-top', (38 - 38 / ratio) / 2);
      $(this).css('margin-bottom', (38 - 38 / ratio) / 2);
    }
  });
}

function adjustImgSmallSquare() {
  $('.img-small-square > img').each(function(i) {
    height = $(this).height();
    width = $(this).width();
    ratio = width / height;
    if(height < width) {
      $(this).addClass("total-height").removeClass('img');
      $(this).css("margin-left", (38 - 38 * ratio) / 2);
      $(this).css("margin-right", (38 - 38 * ratio) / 2);
    } else if(height > width) {
      $(this).addClass("total-width");
      $(this).css('margin-top', (38 - 38 / ratio) / 2);
      $(this).css('margin-bottom', (38 - 38 / ratio) / 2);
    }
  });
}

function adjustImgNavbar() {
  $('.img-navbar > img').each(function(i) {
    height = $(this).height();
    width = $(this).width();
    ratio = width / height;
    if(height < width) {
      $(this).addClass("total-height").removeClass('img');
      $(this).css("margin-left", (42 - 42 * ratio) / 2);
      $(this).css("margin-right", (42 - 42 * ratio) / 2);
    } else if(height > width) {
      $(this).css('margin-top', (42 - 42 / ratio) / 2);
      $(this).css('margin-bottom', (42 - 42 / ratio) / 2);
      $(this).addClass("total-width");
    }
  });
}

function adjustImgMediumSquare() {
  $('.img-medium-square > img').each(function(i) {
    height = $(this).height();
    width = $(this).width();
    ratio = width / height;
    if(height < width) {
      $(this).addClass("total-height").removeClass('img');
      $(this).css("margin-left", (64 - 64 * ratio) / 2);
      $(this).css("margin-right", (64 - 64 * ratio) / 2);
    } else if(height > width) {
      $(this).css('margin-top', (64 - 64 / ratio) / 2);
      $(this).css('margin-bottom', (64 - 64 / ratio) / 2);
      $(this).addClass("total-width");
    }
  });
}

function adjustImgMini() {
  $('.img-mini > img').each(function(i) {
    height = $(this).height();
    width = $(this).width();
    ratio = width / height;
    if(height < width) {
      $(this).addClass("total-height").removeClass('img');
      $(this).css("margin-left", (20 - 20 * ratio) / 2);
      $(this).css("margin-right", (20 - 20 * ratio) / 2);
      $(this).css("margin-top", -3);
    } else if(height > width) {
      $(this).addClass("total-width").removeClass('img');
      $(this).css('margin-top', (20 - 20 / ratio) / 2);
      $(this).css('margin-bottom', (20 - 20 / ratio) / 2);
    } else {
      $(this).css("margin-top", -3);
    }
  });
}

function updatePic() {
  $('#profile-picture').hover(function() {
    $('.update-profile-pic').addClass('profile-pic-hover');
    var width = $(this).width();
    $('.update-profile-pic').css('width', width);
    $('.update-pic-text').html('<i class="fa fa-camera"></i>&nbsp;&nbsp;Modifier photo').css('font-size', 18);
  })
  $('#profile-picture').on('mouseout', function() {
    $('.update-profile-pic').removeClass('profile-pic-hover');
    $('.update-pic-text').html('<i class="fa fa-camera"></i>');
  })
}