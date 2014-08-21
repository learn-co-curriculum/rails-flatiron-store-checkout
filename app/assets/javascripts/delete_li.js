$('.delete_li').click(function(e){
  $.ajax({
    type: "DELETE",
    url: '/line_items/' + id,
    dataType: "json",
    success: function(){
      $(this).closest('tr').fadeOut();
    }
  });
  e.stopPropagation();
  e.preventDefault();
});