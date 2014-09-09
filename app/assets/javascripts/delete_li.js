$(function(){
  $('.delete_li').click(function(e){
    var id = $(this).attr("data-id");
    $.ajax({
      type: "DELETE",
      url: '/line_items/' + id,
      dataType: "json",
      success: function(data){

        $('.delete_li[data-id=' + id + ']').closest('tr').fadeOut();

        var new_total = data.total / 100;

        $('#total').text('$' + new_total);

        $('#stripe-button').html('<script src="https://checkout.stripe.com/checkout.js" class="stripe-button" data-key="' + data.stripe_api + '" data-description="Order total: ' + '$' + new_total + '" data-amount="' + data.total + '"></script>');
      }
    });
    e.preventDefault();
  });
})