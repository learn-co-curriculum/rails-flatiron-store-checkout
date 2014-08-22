$(function(){
  $('.form-control').bind("enterKey", function(e){
    var new_quantity = $(this).attr('value');
    var id = $(this).attr("data-id");

    $.ajax({
      type: "PATCH",
      url: '/line_items/' + id,
      dataType: "json",
      data: JSON.stringify({new_quantity: new_quantity}),
      success: function(data){
        debugger;
        var new_total = data.total / 100;
        $('#total').text('$' + new_total);
        $('#stripe-button').html(
        '<script src="https://checkout.stripe.com/checkout.js" class="stripe-button" data-key="' + data.stripe_api + '" data-description="Order total: ' + '$' + new_total + '" data-amount="' + data.total + '"></script>')
      }
    });
    e.preventDefault();
  });
})