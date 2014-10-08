$(function(){

  var reaction = function(change){
    console.log(change);

    $("#stripe-button").hide();
  }

  Object.observe($('.total'), reaction);
});