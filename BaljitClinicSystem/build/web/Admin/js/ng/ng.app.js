var smartApp = angular.module('smartApp', [
    'ngRoute',
    //'ngAnimate', // this is buggy, jarviswidget will not work with ngAnimate :(
    'ui.bootstrap',
    'plunker',
    'app.controllers',
    'app.demoControllers',
    'app.main',
    'app.navigation',
    'app.localize',
    'app.activity',
    'app.smartui'
]);

smartApp.config(['$routeProvider', '$provide', function ($routeProvider, $provide) {

        $routeProvider
                .when('/', {
                    redirectTo: '/dashboard'
                })

                
                .when('/test_webservices', {
                    templateUrl: 'views/test_webservices.jsp',
                    controller: 'PageViewController'
                })

                /* We are loading our views dynamically by passing arguments to the location url */

                // A bug in smartwidget with angular (routes not reloading). 
                // We need to reload these pages everytime so widget would work
                // The trick is to add "/" at the end of the view.
                // http://stackoverflow.com/a/17588833
                .when('/dashboard', {
                    templateUrl: 'views/dashboard.jsp',
                    controller: 'PageViewController'
                })
                
                //PATIENT
                .when('/PatientList', {
                    templateUrl: 'views/Patient/Patient_List.jsp',
                    controller: 'PageViewController'
                })    
                .when('/AddPatient', {
                    templateUrl: 'views/Patient/Patient_Add.jsp',
                    controller: 'PageViewController'
                })
                .when('/PatientDetail/:pt_id', {
                    templateUrl: 'views/Patient/Patient_Detail.jsp',
                    controller: 'DetailViewController'
                })                
               
                 .when('/CodeSetupList/:TYPE*', {
                    templateUrl: 'views/MasterSetup/StkCode_Listing.jsp',
                    controller: 'DetailViewController'
                })
                .when('/AddNewList/:TYPE*/:DESC*', {
                    templateUrl: 'views/MasterSetup/StkCode_AddNew.jsp',
                    controller: 'DetailViewController'
                })
                .when('/CodeDetail/:TYPE*/:CODE*/:DESC*', {
                    templateUrl: 'views/MasterSetup/StkCode_Detail.jsp',
                    controller: 'DetailViewController'
                })
                
                //User Setup 
                .when('/UserList', {
                    templateUrl: 'views/MasterSetup/User_Listing.jsp',
                    controller: 'PageViewController'
                })
                .when('/AddNewUser', {
                    templateUrl: 'views/MasterSetup/User_AddNew.jsp',
                    controller: 'PageViewController'
                })
                .when('/UserDetail/:CODE*', {
                    templateUrl: 'views/MasterSetup/User_Detail.jsp',
                    controller: 'DetailViewController'
                }) 
                
                //Corporate Setup 
                .when('/CorporateList', {
                    templateUrl: 'views/Corporate/Corporate_Listing.jsp',
                    controller: 'PageViewController'
                })
                .when('/AddNewCorporate', {
                    templateUrl: 'views/Corporate/Corporate_Add.jsp',
                    controller: 'PageViewController'
                })
                .when('/CorporateDetail/:cp_id', {
                    templateUrl: 'views/Corporate/Corporate_Detail.jsp',
                    controller: 'DetailViewController'
                }) 
                
                //Registration Queue 
                .when('/QueueList', {
                    templateUrl: 'views/Queue/Queue_Listing.jsp',
                    controller: 'PageViewController'
                })
                
                //Medicine Setup 
                .when('/MedicineList', {
                    templateUrl: 'views/Medicine/Medicine_Listing.jsp',
                    controller: 'PageViewController'
                })
                .when('/AddNewMedicine', {
                    templateUrl: 'views/Medicine/Medicine_Add.jsp',
                    controller: 'PageViewController'
                })
                .when('/MedicineDetail/:md_id', {
                    templateUrl: 'views/Medicine/Medicine_Detail.jsp',
                    controller: 'DetailViewController'
                }) 
                
                .when('/RoleList', {
                    templateUrl: 'views/RoleSetup/RoleSearch.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/AddRole', {
                    templateUrl: 'views/RoleSetup/RoleAdd.jsp',
                    controller: 'PageViewController'
                })
                .when('/MenuList', {
                    templateUrl: 'views/RoleSetup/RoleSearch.jsp',
                    controller: 'PageViewController'
                })                         
                .when('/ChangePassword', {
                    templateUrl: 'views/MasterSetup/User_Change_Password.jsp',
                    controller: 'PageViewController'
                })               
                .otherwise({
                    redirectTo: '/dashboard'
                });
                

        // with this, you can use $log('Message') same as $log.info('Message');
        $provide.decorator('$log', ['$delegate',
            function ($delegate) {
                // create a new function to be returned below as the $log service (instead of the $delegate)
                function logger() {
                    // if $log fn is called directly, default to "info" message
                    logger.info.apply(logger, arguments);
                }

                // add all the $log props into our new logger fn
                angular.extend(logger, $delegate);
                return logger;
            }]);

    }]);

smartApp.run(['$rootScope', 'settings', function ($rootScope, settings) {
        settings.currentLang = settings.languages[0]; // en
    }]);