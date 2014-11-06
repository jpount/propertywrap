Property = angular.module('Property',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

Property.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'HomeController'
      )
])

controllers = angular.module('controllers',[])
