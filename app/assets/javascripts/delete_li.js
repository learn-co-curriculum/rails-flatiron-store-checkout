$(function(){
  $('.delete_li').click(function(e){
    var id = $(this).attr("data-id");
    $.ajax({
      type: "DELETE",
      url: '/line_items/' + id,
      dataType: "json",
      success: function(data){
        $('.delete_li[data-id=' + id + ']').closest('tr').fadeOut();
        var current_total = parseFloat($('#total').text().replace('$', '')); 
        var deleted_amount = parseFloat(data["price"] / 100);
        var new_total = current_total - deleted_amount;
        $('#total').text('$' + new_total);
      }
    });
    e.preventDefault();
  });
})