function mine() {
  $(document).ready(function() {
    $('.loader').remove()
    var width = $('.card').css('width')
    $('.card').css('height', width)
    $(window).on('resize', function() {
      var width = $('.card').css('width')
      $('.card').css('height', width)
    })
    $('.card').on('dblclick', function() {
      location.href = $(this).children().last().data('href')
    })
    $('.card').on('click', function() {
      setTimeout(function() {
        $('body').animate({scrollTop: $('#' + $('.popover').attr("id")).offset().top - 80}, "slow")
        return false
      }, 500)
    })
  })
}