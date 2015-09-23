$(document).ready(function() {
  $('.user_picture').on('change', function(event) {
    var files = event.target.files
    var image = files[0]
    var reader = new FileReader()
    reader.onload = function(file) {
      $('.target').attr('src', file.target.result)
    }
    reader.readAsDataURL(image)
  })
})

function showInfo() {
  $('#user-info').removeClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-bank').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-notifs').addClass("hidden");
  $('#my-info').addClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-bank').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-notifs').removeClass("strong");
}

function showPic() {
  $('#user-info').addClass("hidden");
  $('#user-picture').removeClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-bank').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-notifs').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').addClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-bank').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-notifs').removeClass("strong");
}

function showTrust() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').removeClass("hidden");
  $('#user-bank').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-notifs').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').addClass("strong");
  $('#my-bank').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-notifs').removeClass("strong");
}

function showComments() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-bank').addClass("hidden");
  $('#user-comments').removeClass("hidden");
  $('#user-notifs').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-bank').removeClass("strong");
  $('#my-comments').addClass("strong");
  $('#my-notifs').removeClass("strong");
}

function showNotifs() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-bank').addClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-notifs').removeClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-bank').removeClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-notifs').addClass("strong");
}

function showBank() {
  $('#user-info').addClass("hidden");
  $('#user-picture').addClass("hidden");
  $('#user-trust').addClass("hidden");
  $('#user-bank').removeClass("hidden");
  $('#user-comments').addClass("hidden");
  $('#user-notifs').addClass("hidden");
  $('#my-info').removeClass("strong");
  $('#my-pic').removeClass("strong");
  $('#my-trust').removeClass("strong");
  $('#my-bank').addClass("strong");
  $('#my-comments').removeClass("strong");
  $('#my-notifs').removeClass("strong");
}

function filled(field) {
  var value = field.val();
  if (value == "") {
    $(field).parent().addClass("has-error").removeClass("success");
  }
  else {
    $(field).parent().addClass("success").removeClass("has-error");
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

function showTheRightDiv() {
  if(window.location.hash == "#my-trust") {
  showTrust();
  }

  if(window.location.hash == "#my-pic") {
  showPic();
  }

  if(window.location.hash == "#my-bank") {
    showBank();
  }

  $('.edit-link').on('focus', function(e) {
    window.scrollTo(0, 0);
  })
  $('.edit-link').on('click', function(e) {
    id = $(this).attr('id');
    if(id == "my-info") {
      showInfo();
    }
    if(id == "my-pic") {
      showPic();
    }
    if(id == "my-trust") {
      showTrust();
    }
    if(id == "my-bank") {
      showBank();
    }
    if(id == "my-comments") {
      showComments();
    }
    if(id == "my-notifs") {
      showNotifs();
    }
  });
}

function formValidation() {
  var id;
  var name;
  var first_name;
  var last_name;
  var street;
  var zip_code;
  var city;

  firstName = $("#first_name");
  filled(firstName);
  test_field_at_focusout(firstName);

  lastName = $("#last_name");
  filled(lastName);
  test_field_at_focusout(lastName);

  street = $("#street");
  filled(street);
  test_field_at_focusout(street);

  zipCode = $("#zip_code");

  city = $("#city");
  filled(city);
  test_field_at_focusout(city);

  mobile = $("#mobile_phone");
  test_field_at_focusout(mobile);

  address = $("#address");
  test_field_at_focusout(address);

  $("#zip_code").on("focusout", function(event) {
    var zipCode = $("#zip_code").val();
    var invalid_zip_code = function() {
      if (zipCode.match(/^\d{5}$/) == null) {
        return true;
      }
      else {
        return false;
      };
    }
    var result = invalid_zip_code();
    if(result) {
      $(this).parent().addClass("has-error").removeClass("success");
    }
    else {
      $(this).parent().addClass("success").removeClass("has-error");
    };
  });

  $("#phone").on("change", function(event) {
    var mobile = $("#phone").val();
    var invalid_mobile = function() {
      if (mobile == "") {
        return "empty";
      } else if (mobile.match(/^(0|\+33)[67]( ?\d{2}){4}$/) == null) {
        return true;
      } else if (mobile == "") {
        return true;
      } else {
        return false;
      };
    }
    var result = invalid_mobile();
    if (result == "empty") {
      $(this).parent().removeClass("has-error").removeClass("success");
    } else if (result) {
      $(this).parent().addClass("has-error").removeClass("success");
    } else {
      $(this).parent().addClass("success").removeClass("has-error");
    };
  });
}

function togglePaddingLeft() {
  if($(window).width() < 400) {
    $('.padding-left-30').removeClass('padding-left-30').addClass('padding-left-50')
  } else {
    $('.padding-left-50').removeClass('padding-left-50').addClass('padding-left-30')
  }
}