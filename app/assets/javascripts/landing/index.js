(function() {
    'use strict';
    var app = angular.module("Property", ['n3-pie-chart']);

    app.controller("CanvasCtrl", ["$scope", "$document", "$window", function($scope, $document, $window) {
        $scope.showAddProperty = false;

        $scope.nav = [{
            label: 'Home', active: true
        },
            {
                label: 'Manage', active: false
            },
            {
                label: 'Insights', active: false
            }]

        $scope.info = [
            {
                label: 'Income', amount: '$40,000', highlightItem: false
            },
            {
                label: 'Outflow', amount: '$50,000', highlightItem: false
            }];

        $scope.propertyList = [{
            label: '1 Shelley St, Sydney NSW', yield: '10%', description: ['Last rent paid on 3/2/2014'], outstanding: 0,
            image: '/assets/house1.jpeg'
        },
            {
                label: '16 Martin Pl, Sydney NSW', yield: '4%', description: ['Last rent paid on 3/2/2014', 'Maintenence required', 'Outstanding rent for April'], outstanding: 2,
                image: '/assets/house2.jpeg'
            },
            {
                label: '23 Foveaux, Perth WA', yield: '13%', description: ['Outstanding rent for April'], outstanding: 1,
                image: '/assets/house3.jpeg'
            },
            {
                label: '50 Sunshine St, Gold Coast ', yield: '13%', description: ['Last rent paid on 3/2/2014'], outstanding: 0,
                image: '/assets/house4.jpeg'
            }];

        $scope.options = {thickness: 20};

        $scope.data = [
            {label: "Gold Coast", value: 1, color: "#1f77b4"},
            {label: "Perth", value: 1, color: "#ff7f0e"},
            {label: "Sydney", value: 2, color: "#2ca02c"}
        ];

        $scope.helpItems = [
            {icon: 'dollar', title: 'Macquarie CMA', description: 'Save by automatic transaction matching'},
            {icon: 'line-chart', title: 'Macquarie Wrap', description: 'Directly manage other investments'},
            {icon: 'money', title: 'Macquarie Loan', description: 'Get your home loan approved instantly'}
        ];
        var video1 = document.getElementById("video1");
        video1.autoplay = false;
        var video2 = document.getElementById("video2");
        video2.autoplay = false;
        var video3 = document.getElementById("video3");
        video3.autoplay = false;
        video1.addEventListener('ended',function(){
            $scope.welcomeHighlight = false;
            $scope.info[0].highlightItem = true;
            $scope.$apply();
            video2.play();
        },false);
        video2.addEventListener('ended',function(){
            $scope.info[0].highlightItem = false;
            $scope.info[1].highlightItem = true;
            $scope.$apply();
            video3.play();
        },false);
        video3.addEventListener('ended',function(){
            $scope.info[1].highlightItem = false;
            $scope.$apply();
        },false);

        $scope.test = function(){
            video1.play();
            $scope.welcomeHighlight = true;
        };

        $scope.opposite = function(){
            $scope.info[0].highlightItem = false;
            $scope.info[1].highlightItem = false;
        };

        $document.on('scroll', function($scope){

            setTimeout(function(){
                var section = document.getElementById('property');
                if($window.scrollY > section.offsetTop - 50){
                    document.getElementById('showAddProperty').style.display = "block";

                    if(($window.scrollY + $window.innerHeight) > (section.offsetTop + section.offsetHeight)){
                        document.getElementById('showAddProperty').style.position = "absolute";
                        return;
                    }
                    return;
                }
                document.getElementById('showAddProperty').style.display = "none";
                document.getElementById('showAddProperty').style.position = "fixed";
            }, 500);
        });

    }]);

}());