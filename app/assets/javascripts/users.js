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