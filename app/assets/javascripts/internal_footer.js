// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require highcharts
//= require admin/libs/bootstrap.min
//= require admin/plugins/flot/jquery.flot
//= require admin/plugins/flot/jquery.flot.tooltip.min
//= require admin/plugins/flot/jquery.flot.pie
//= require admin/plugins/flot/jquery.flot.resize
//= require admin/mvpready-core
//= require admin/mvpready-admin
//= require jquery.formatCurrency-1.4.0.pack
//= require users

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