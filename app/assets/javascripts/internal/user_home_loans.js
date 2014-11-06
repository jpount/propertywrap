$(document).ready(function(){
  $("body").on("click", "input", function() {
    $('[data-behaviour~=datepicker]').datepicker();
  });


})