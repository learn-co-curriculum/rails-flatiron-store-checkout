$(function(){
  $('.form-control').on("keyup", function(e){
    if (e.keyCode >= 48 && e.keyCode <= 57) {
      var new_quantity = $(this).val();
      var id = $(this).attr("data-id");

      $.ajax({
        type: "PATCH",
        url: '/line_items/' + id,
        dataType: "json",
        data: { new_quantity: new_quantity },
        success: function(data){

          var new_sub_total_num = parseFloat($('#price').text().replace('$', ''));
          var new_sub_total = new_sub_total_num * new_quantity
          var new_total = data.total / 100;

          $('.total').text('$' + new_total);
          $('#sub-total').text('$' + new_sub_total);

          $('#stripe-button').html('<script src="https://checkout.stripe.com/checkout.js" class="stripe-button" data-key="' + data.stripe_api + '" data-description="Order total: ' + '$' + new_total + '" data-amount="' + data.total + '"></script>')
        }
      });
    }
    e.preventDefault();
  });
})