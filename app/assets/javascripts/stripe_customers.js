function stripeResponseHandler(status, response) {
  var $form = $('#stripe_customer_form');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    // response contains id and card, which contains additional card details
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));

    // and submit
    $form.get(0).submit();
  }
}


function stripeCustomerCreation() {
  $('#valider').on('click', function(event) {
    var $form = $('#stripe_customer_form');

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken({
      number: $('#card-number').val().replace(/\s/g, ''),
      cvc: $('#card-cvc').val(),
      exp_month: $('#card-expiry-month').val(),
      exp_year: $('#card-expiry-year').val()
    }, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
}