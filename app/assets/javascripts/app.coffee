propertywrap = angular.module('propertywrap',[
  'templates',
  'ngRoute',
  'controllers',
])

propertywrap.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
    .when('/',
      templateUrl: "index.html"
      controller: 'CanvasController'
    )
])

controllers = angular.module('controllers',[])
controllers.controller("CanvasController", [ '$scope',
  ($scope)->
])
