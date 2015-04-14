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
    } else {
      var endDate = startDate;
    }
    endDate = new Date(endDate).toString();
    endYear = year(endDate);
    endMonth = month(endDate);
    endDay = day(endDate);
    endDate = endDay + "/" + endMonth + "/" +endYear;
    endDateJs = endYear + "-" + endMonth + "-" +endDay;
    $('#end-date').val(endDate);
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
      $('span').removeClass("hidden");
      $(this).parent().addClass('has-error');
      $('.btn').addClass('disabled');
    } else {
      $('span').addClass("hidden");
      $(this).parent().removeClass('has-error');
      $('.btn').removeClass('disabled');
    }
  })
}