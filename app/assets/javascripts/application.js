//= require jquery
//= require jquery_ujs
//= require angular/angular
//= require angular-route/angular-route
//= require angular-resource/angular-resource
//= require angular-flash/dist/angular-flash
//= require angular-rails-templates
//= require cocoon
//= require highcharts
//= require bootstrap-datepicker
//= require_tree .

jQuery(function($) {
  // Show clicked element on an ajx call
  $(".selectable").bind("ajax:before", function() {
    $(this).addClass("selected");
  }).bind("ajax:complete", function() {
    $(".selected").removeClass("selected");
  });

  $("div[data-load]").filter(":visible").each(function(){
    var path = $(this).attr('data-load');
    $(this).load(path);
  });
});