function notices() {
  if($('.alert').length > 0 ) {
    $('body').addClass('margin-top-56')
    setTimeout(function(){
      $('.alert').addClass('is-hidden')
      $('body').removeClass('margin-top-56')
    }, 10000)
  }
}

function noticesHome() {
  if($('.alert').length > 0 ) {
    setTimeout(function(){
      $('.alert').addClass('is-hidden')
    }, 10000)
  }
}