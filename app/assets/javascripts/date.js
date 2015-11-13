function month(date) {
  // Tue Feb 24 2015 01:00:00 GMT+0100 (CET)
  if(date.slice(4, 7) == "Jan") {
    return "01";
  } else if(date.slice(4, 7) == "Feb") {
    return "02";
  } else if(date.slice(4, 7) == "Mar") {
    return "03";
  } else if(date.slice(4, 7) == "Apr") {
    return "04";
  } else if(date.slice(4, 7) == "May") {
    return "05";
  } else if(date.slice(4, 7) == "Jun") {
    return "06";
  } else if(date.slice(4, 7) == "Jul") {
    return "07";
  } else if(date.slice(4, 7) == "Aug") {
    return "08";
  } else if(date.slice(4, 7) == "Sep") {
    return "09";
  } else if(date.slice(4, 7) == "Oct") {
    return "10";
  } else if(date.slice(4, 7) == "Nov") {
    return "11";
  } else if(date.slice(4, 7) == "Dec") {
    return "12";
  }
}

function year(date) {
  // Tue Feb 24 2015 01:00:00 GMT+0100 (CET)
  return date.slice(11, 15);
}

function day(date) {
  // Tue Feb 24 2015 01:00:00 GMT+0100 (CET)
  return date.slice(8, 10);
}

function hour(date) {
  // Tue Feb 24 2015 01:00:00 GMT+0100 (CET)
  return date.slice(16, 18);
}

function setEndDate(type) {
  $('#start-date').on('change', function() {
    var startDate = Date.parse($(this).val().slice(6, 10) + '-' + $(this).val().slice(3, 5) + '-' + $(this).val().slice(0, 2));
    if(type == "rent") {
      var endDate = startDate + 1 * 86400000;
    } else if(type == "sell") {
      var endDate = startDate;
    }
    endDate = new Date(endDate).toString();
    endYear = year(endDate);
    endMonth = month(endDate);
    endDay = day(endDate);
    endDate = endDay + "/" + endMonth + "/" +endYear;
    endDateJs = endYear + "-" + endMonth + "-" +endDay;
    if(type == "rent" || type == "sell") {
      $('#end-date').val(endDate);
    }
  })
}

function setDays() {
  $('#start-date').on('change', function() {
    var startDate = Date.parse($(this).val().slice(6, 10) + '-' + $(this).val().slice(3, 5) + '-' + $(this).val().slice(0, 2));
    var endDate = Date.parse($('#end-date').val().slice(6, 10) + '-' + $('#end-date').val().slice(3, 5) + '-' + $('#end-date').val().slice(0, 2));
    var nbDays = (endDate - startDate) / 86400000;
    var total
    $('#renting-days').text(nbDays);
    if(nbDays > 6) {
      $('#renting-days-equation').text(nbDays + " / 7");
      $('#renting-days-sentence').text(nbDays);
      $('#daily-price').removeClass('strong');
      $('#weekly-price').addClass('strong');
      $('#renting-price').text($('#weekly-price').text().split("€")[0])
      if(parseInt($('#weekly-price').text().split("€")[0])) {
        total = parseInt(nbDays) / 7 * parseInt($('#weekly-price').text().split("€")[0]) * 1.08;
      } else {
        total = parseInt(nbDays) * parseInt($('#daily-price').text().split("€")[0]) * 1.08;
      }
      $('#renting-total').text(Math.floor(total))
    } else {
      $('#renting-days-equation').text(nbDays);
      $('#renting-days-sentence').text(nbDays);
      $('#daily-price').addClass('strong');
      $('#weekly-price').removeClass('strong');
      $('#renting-price').text($('#daily-price').text().split("€")[0])
      total = parseInt(nbDays) * parseInt($('#daily-price').text().split("€")[0]) * 1.08;
      $('#renting-total').text(Math.floor(total))
    }
  })
  $('#end-date').on('change', function() {
    var endDate = Date.parse($(this).val().slice(6, 10) + '-' + $(this).val().slice(3, 5) + '-' + $(this).val().slice(0, 2));
    var startDate = Date.parse($('#start-date').val().slice(6, 10) + '-' + $('#start-date').val().slice(3, 5) + '-' + $('#start-date').val().slice(0, 2));
    var nbDays = (endDate - startDate) / 86400000;
    $('#renting-days').text(nbDays);
    if(nbDays > 6) {
      $('#renting-days-equation').text(nbDays + " / 7");
      $('#renting-days-sentence').text(nbDays);
      $('#daily-price').removeClass('strong');
      $('#weekly-price').addClass('strong');
      $('#renting-price').text($('#weekly-price').text().split("€")[0])
      total = parseInt(nbDays) / 7 * parseInt($('#weekly-price').text().split("€")[0]) * 1.08;
      $('#renting-total').text(Math.floor(total))
    } else {
      $('#renting-days-equation').text(nbDays);
      $('#renting-days-sentence').text(nbDays);
      $('#daily-price').addClass('strong');
      $('#weekly-price').removeClass('strong');
      $('#renting-price').text($('#daily-price').text().split("€")[0])
      total = parseInt(nbDays) * parseInt($('#daily-price').text().split("€")[0]) * 1.08;
      $('#renting-total').text(Math.floor(total))
    }
  })
}

function setHours() {
  var startHour = $('#booking_start_hour_4i').val();
  var startMin = $('#booking_start_hour_5i').val();
  var startDateTime = Date.parse($('#start-date').val().slice(6, 10) + '-' + $('#start-date').val().slice(3, 5) + '-' + $('#start-date').val().slice(0, 2));
  startDateTime = new Date(startDateTime)
  startDateTime.setHours(parseInt(startHour));
  startDateTime.setMinutes(parseInt(startMin));

  var endHour = $('#booking_end_hour_4i').val();
  var endMin = $('#booking_end_hour_5i').val();
  var endDateTime = Date.parse($('#end-date').val().slice(6, 10) + '-' + $('#end-date').val().slice(3, 5) + '-' + $('#end-date').val().slice(0, 2));
  endDateTime = new Date(endDateTime)
  endDateTime.setHours(parseInt(endHour));
  endDateTime.setMinutes(parseInt(endMin));

  var serviceHours = (endDateTime - startDateTime) / 3600000
  serviceResult();

  function serviceResult() {
    serviceHours = (endDateTime - startDateTime) / 3600000
    $('#service-hours').text(serviceHours);
    $('#service-hours-sentence').text(serviceHours);
    var total = serviceHours * parseInt($('#service-price').text()) * 1.08
    $('#service-total').text(Math.floor(total))
    var today = new Date()
    var totalHours = parseInt($('#service-hours').text())
    if(serviceHours <= 0 || startDateTime < today || totalHours <= 0) {
      $('.btn').addClass('disabled')
    } else {
      $('.btn').removeClass('disabled')
    }
  }

  $('#booking_start_hour_4i').on('change', function() {
    startHour = $('#booking_start_hour_4i').val();
    startDateTime.setHours(parseInt(startHour));
    serviceResult()
  })

  $('#booking_start_hour_5i').on('change', function() {
    startMin = $('#booking_start_hour_5i').val();
    startDateTime.setMinutes(parseInt(startMin));
    serviceResult()
  })

  $('#booking_end_hour_4i').on('change', function() {
    endHour = $('#booking_end_hour_4i').val();
    endDateTime.setHours(parseInt(endHour));
    serviceResult()
  })

  $('#booking_end_hour_5i').on('change', function() {
    endMin = $('#booking_end_hour_5i').val();
    endDateTime.setMinutes(parseInt(endMin));
    serviceResult()
  })

  $('#start-date').on('change', function() {
    startDateTime = Date.parse($('#start-date').val().slice(6, 10) + '-' + $('#start-date').val().slice(3, 5) + '-' + $('#start-date').val().slice(0, 2));
    startDateTime = new Date(startDateTime)
    startDateTime.setHours(parseInt(startHour));
    startDateTime.setMinutes(parseInt(startMin));
    serviceResult()
  })

  $('#end-date').on('change', function() {
    endDateTime = Date.parse($('#end-date').val().slice(6, 10) + '-' + $('#end-date').val().slice(3, 5) + '-' + $('#end-date').val().slice(0, 2));
    endDateTime = new Date(endDateTime)
    endDateTime.setHours(parseInt(endHour));
    endDateTime.setMinutes(parseInt(endMin));
    serviceResult()
  })

}

function setStartDates(type) {
  $('#start-date').datepicker({
    format: 'dd/mm/yyyy',
    autoclose: true,
    clearBtn: true,
    language: 'fr',
    multidate: false,
    todayHighlight: true,
    startDate: new Date()
  })
  if(type == "rent") {
    $('#end-date').datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true,
      clearBtn: true,
      language: 'fr',
      multidate: false,
      todayHighlight: true,
      startDate: new Date(new Date().getTime() + 86400000 * 1)
    })
  } else {
    $('#end-date').datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true,
      clearBtn: true,
      language: 'fr',
      multidate: false,
      todayHighlight: true,
      startDate: new Date(new Date().getTime())
    })
  }
}

function checkDeliveryDate() {
  $('#end-date').on('change', function() {
    var startValue = $('#start-date').val();
    var startDate = Date.parse(startValue.slice(6, 10) + '-' + startValue.slice(3, 5) + '-' + startValue.slice(0, 2));
    var endDate = Date.parse($(this).val().slice(6, 10) + '-' + $(this).val().slice(3, 5) + '-' + $(this).val().slice(0, 2));
    if(endDate - startDate < 0) {
      $(this).parent().addClass('has-error');
      $('.btn').addClass('disabled');
    } else {
      $(this).parent().removeClass('has-error');
      $('.btn').removeClass('disabled');
    }
  })
}