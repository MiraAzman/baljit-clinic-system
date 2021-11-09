angular.module('app.controllers', [])
        .factory('settings', ['$rootScope', function ($rootScope) {
                // supported languages
                var settings = {
                    languages: [
                        {
                            language: 'English',
                            translation: 'English',
                            langCode: 'en',
                            flagCode: 'us'
                        },
                        /*{
                         language: 'Espanish',
                         translation: 'Espanish',
                         langCode: 'es',
                         flagCode: 'es'
                         },
                         {
                         language: 'German',
                         translation: 'Deutsch',
                         langCode: 'de',
                         flagCode: 'de'
                         },
                         {
                         language: 'Korean',
                         translation: '한국의',
                         langCode: 'ko',
                         flagCode: 'kr'
                         },
                         {
                         language: 'French',
                         translation: 'français',
                         langCode: 'fr',
                         flagCode: 'fr'
                         },
                         {
                         language: 'Portuguese',
                         translation: 'português',
                         langCode: 'pt',
                         flagCode: 'br'
                         },
                         {
                         language: 'Russian',
                         translation: 'русский',
                         langCode: 'ru',
                         flagCode: 'ru'
                         },*/
                        {
                            language: 'Chinese',
                            translation: '中文',
                            langCode: 'zh',
                            flagCode: 'cn'
                        },
                        {
                            language: 'Malay',
                            translation: 'Malay',
                            langCode: 'my',
                            flagCode: 'my'
                        }
                    ]

                };

                return settings;

            }])

        .controller('PageViewController', ['$scope', '$route', '$animate', function ($scope, $route, $animate) {
                if (window.onbeforeunload) {
                    window.onbeforeunload = {};
                }
                $scope.$on('$viewContentLoaded', function () {
                    $scope.name = "CorpDetCorpCtrl";
                    $scope.params = $route;
//                    alert($scope.foo);//foo
                });
                // controler of the dynamically loaded views, for DEMO purposes only.
                /*$scope.$on('$viewContentLoaded', function() {
                 });*/
//                $scope.name = "DetailViewController";
//                $scope.params = $route;
//                bindData($scope.params);
//                alert(JSON.stringify(sessionStorage.getItem('gridSetting')));
//                if (!jQuery.isEmptyObject(sessionStorage)) {
                var tempArray = JSON.parse(sessionStorage.getItem('gridSetting'));
                if (!isEmpty(tempArray)) {
                    var array = {};
                    array.gridSetting = tempArray;
                    $.ajax({
                        type: "POST",
                        url: "http://" + contextPath + "/Servlet_Menu?SFC=Save_Item",
                        dataType: 'json',
                        data: {SITEM: JSON.stringify(array)}
                    });
//                if (!$.browser.mozilla) {
                    location.reload();
//                }
//                alert(JSON.stringify(sessionStorage));
                    sessionStorage.removeItem('gridSetting');
                }
            }])

        .controller('CorpDetCorpCtrl', ['$scope', '$routeParams', '$animate', function ($scope, $routeParams, $animate) {
                // controler of the dynamically loaded views, for DEMO purposes only.
                $scope.$on('$viewContentLoaded', function () {
                    $scope.name = "CorpDetCorpCtrl";
                    $scope.params = $routeParams;
                });
            }])

        .controller('Ctrl', ['$scope', '$routeParams', '$animate', function ($scope, $routeParams, $animate) {
                // controler of the dynamically loaded views, for DEMO purposes only.
                $scope.name = "CorpDetCorpCtrl";
                $scope.params = $routeParams;
            }])


        .controller('DetailViewController', function ($scope, $routeParams) {
            $scope.name = "DetailViewController";
            $scope.params = $routeParams;
            bindData($scope.params);
        })


        .controller('MemberDetailViewController', function ($scope, $routeParams) {
            $scope.name = "MemberDetailViewController";
            $scope.params = $routeParams;
            bindData($scope.params);
        })

        .controller('MemberClaimViewController', function ($scope, $routeParams) {
            $scope.name = "MemberClaimViewController";
            $scope.params = $routeParams;
        })

        .controller('ProviderDetailViewController', function ($scope, $routeParams) {
            $scope.name = "ProviderDetailViewController";
            $scope.params = $routeParams;
            runDetail($scope.params);
        })
        .controller('ProvGrpDetailViewController', function ($scope, $routeParams) {
            $scope.name = "ProvGrpDetailViewController";
            $scope.params = $routeParams;
        })
        .controller('CorporateDetailViewController', function ($scope, $routeParams) {
            $scope.name = "CorporateDetailViewController";
            $scope.params = $routeParams;
        })

//        .controller('CorpDetCorpCtrl', function($scope, $routeParams) {
//            $scope.name = "CorpDetCorpCtrl";
//            $scope.params = $routeParams;
//        })
//        
        .controller('CorpProvNetDetailViewController', function ($scope, $routeParams) {
            $scope.name = "CorpProvNetDetailViewController";
            $scope.params = $routeParams;
        })
        .controller('CBCDetCtrl', function ($scope, $routeParams) {
            $scope.name = "CBCDetCtrl";
            $scope.params = $routeParams;
        })
        .controller('PayerDetailViewController', function ($scope, $routeParams) {
            $scope.name = "PayerDetailViewController";
            $scope.params = $routeParams;
        })

        .controller('BECDetViewCtrl', function ($scope, $routeParams) {
            $scope.name = "BECDetViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('BenPlanViewCtrl', function ($scope, $routeParams) {
            $scope.name = "BenPlanViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('BenPlanGrpViewCtrl', function ($scope, $routeParams) {
            $scope.name = "BenPlanGrpViewCtrl";
            $scope.params = $routeParams;
        })
        .controller('BenPlanGrpPlanViewCtrl', function ($scope, $routeParams) {
            $scope.name = "BenPlanGrpPlanViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('BenPlanCondViewCtrl', function ($scope, $routeParams) {
            $scope.name = "BenPlanCondViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('CorpBenGrpViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpBenGrpViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('CorpGradeViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpGradeViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('CorpBenGrpPlanViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpBenGrpPlanViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('CorpBenGrpLimitViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpBenGrpLimitViewCtrl";
            $scope.params = $routeParams;
        })
        .controller('CorpBenGrpLimitPlanViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpBenGrpLimitPlanViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('CorpGradeBenViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpGradeBenViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('CorpHierarchyViewCtrl', function ($scope, $routeParams) {
            $scope.name = "CorpHierarchyViewCtrl";
            $scope.params = $routeParams;
        })

        .controller('SmartAppController', ['$scope', function ($scope) {
                // your main controller

            }])

        .controller('LangController', ['$scope', 'settings', 'localize', function ($scope, settings, localize) {
                $scope.languages = settings.languages;
                $scope.currentLang = settings.currentLang;
                $scope.setLang = function (lang) {
                    settings.currentLang = lang;
                    $scope.currentLang = lang;
                    localize.setLang(lang);
                };

                // set the default language
                $scope.setLang($scope.currentLang);

            }])

        .controller('MenuDetailViewController', function ($scope, $routeParams) {
            $scope.name = "MenuDetailViewController";
            $scope.params = $routeParams;
            BindData($scope.params);
        })

        ;

angular.module('app.demoControllers', [])
        .controller('WidgetDemoCtrl', ['$scope', '$sce', function ($scope, $sce) {
                $scope.title = 'SmartUI Widget';
                $scope.icon = 'fa fa-user';
                $scope.toolbars = [
                    $sce.trustAsHtml('<div class="label label-success">\
				<i class="fa fa-arrow-up"></i> 2.35%\
			</div>'),
                    $sce.trustAsHtml('<div class="btn-group" data-toggle="buttons">\
		        <label class="btn btn-default btn-xs active">\
		          <input type="radio" name="style-a1" id="style-a1"> <i class="fa fa-play"></i>\
		        </label>\
		        <label class="btn btn-default btn-xs">\
		          <input type="radio" name="style-a2" id="style-a2"> <i class="fa fa-pause"></i>\
		        </label>\
		        <label class="btn btn-default btn-xs">\
		          <input type="radio" name="style-a2" id="style-a3"> <i class="fa fa-stop"></i>\
		        </label>\
		    </div>')
                ];

                $scope.content = $sce.trustAsHtml('\
						Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod\
						tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,\
						quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo\
						consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse\
						cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non\
						proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');
            }])

        .controller('ActivityDemoCtrl', ['$scope', function ($scope) {
                var ctrl = this;
                ctrl.getDate = function () {
                    return new Date().toUTCString();
                };

                $scope.refreshCallback = function (contentScope, done) {
                    // use contentScope to get access with activityContent directive's Control Scope
                    console.log(contentScope);

                    // for example getting your very long data ...........
                    setTimeout(function () {
                        done();
                    }, 3000);

                    $scope.footerContent = ctrl.getDate();
                };

                $scope.items = [
                    {
                        title: 'Msgs',
                        count: 14,
                        src: 'ajax/notify/mail.html',
                        onload: function (item) {
                            console.log(item);
                            alert('[Callback] Loading Messages ...');
                        }
                    },
                    {
                        title: 'Notify',
                        count: 3,
                        src: 'ajax/notify/notifications.html'
                    },
                    {
                        title: 'Tasks',
                        count: 4,
                        src: 'ajax/notify/tasks.html',
                        //active: true
                    }
                ];

                $scope.total = 0;
                angular.forEach($scope.items, function (item) {
                    $scope.total += item.count;
                });

                $scope.footerContent = ctrl.getDate();

            }])
        ;

var hasOwnProperty = Object.prototype.hasOwnProperty;

function isEmpty(obj) {

    // null and undefined are "empty"
    if (obj == null)
        return true;

    // Assume if it has a length property with a non-zero value
    // that that property is correct.
    if (obj.length > 0)
        return false;
    if (obj.length === 0)
        return true;

    // Otherwise, does it have any properties of its own?
    // Note that this doesn't handle
    // toString and valueOf enumeration bugs in IE < 9
    for (var key in obj) {
        if (hasOwnProperty.call(obj, key))
            return false;
    }

    return true;
}