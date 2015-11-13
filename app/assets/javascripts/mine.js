function mine() {
  $(document).ready(function() {
    var width = $('.card').css('width')
    $('.card').css('height', width)
    $('.card').popover({
      html: true,
      placement: function(context, source) {
        var position = $(source).offset().top;
        if(position < 300) {
          return "bottom"
        } else {
          return "top"
        }
      }
    })
    $(window).on('resize', function() {
      var width = $('.card').css('width')
      $('.card').css('height', width)
    })
    // $('.card').on('mouseenter', function(){
    //   $(this).click()
    // })
    $('.card').on('dblclick', function() {
      location.href = $(this).children().last().attr('href')
    })
    // $('.card').on('dbltap', function() {
    //   location.href = $(this).children().last().attr('href')
    // })
    // var popover
    // $('.card').on('click', function(e) {
    //   e.preventDefault()
    //   popover = $(this).next()
    //   setTimeout(function() {
    //     $.each($('.popover'), function(index, item) {
    //       if(item == popover[0]) {
    //       } else {
    //         item.remove()
    //       }
    //     })
    //   }, 100)
    //   $('.offer_published').on('change', function() {
    //     var id = parseInt($(this).first().parent().parent().parent().parent().attr('id').slice($(this).first().parent().parent().parent().parent().attr('id').lastIndexOf("_") + 1))
    //     var published = $(this).val()
    //     if(published == "true") {
    //       $.ajax({
    //         type: "PUT",
    //         url: "/offers/" + id + "/publish",
    //         dataType: "script"
    //       })
    //     } else {
    //       $.ajax({
    //         type: "PUT",
    //         url: "/offers/" + id + "/hide",
    //         dataType: "script"
    //       })
    //     }
    //     notices()
    //   })
    // })
  })
}