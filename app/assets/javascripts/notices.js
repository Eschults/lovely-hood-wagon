function notices() {
  if($('.alert').length > 0 ) {
    $('body').addClass('margin-top-56')
    if($('#share').length == 0) {
      setTimeout(function(){
        $('.alert').addClass('is-hidden')
        setTimeout(function() {
          $('.alert').remove()
        }, 1000)
        $('body').removeClass('margin-top-56')
      }, 10000)
    }
  }
}

function noticesHome() {
  if($('.alert').length > 0 ) {
    setTimeout(function(){
      $('.alert').addClass('is-hidden')
    }, 10000)
  }
}