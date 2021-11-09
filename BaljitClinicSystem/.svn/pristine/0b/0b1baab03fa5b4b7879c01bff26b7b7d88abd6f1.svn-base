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
                

                
                .when('/DemoList', {
                    templateUrl: 'views/DemoList.jsp',
                    controller: 'PageViewController'
                })
                
                  .when('/DemoDetail/:SINGUPID', {
                    templateUrl: 'views/DemoDetail.jsp',
                    controller: 'DetailViewController'
                })
                
                .when('/HospitalList', {
                    templateUrl: 'views/HospList.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/AddNewHospital', {
                    templateUrl: 'views/Hosp_AddEdit.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/HospDetail/:HOSPCODE', {
                    templateUrl: 'views/HospDetail.jsp',
                    controller: 'DetailViewController'
                })
                
                 .when('/ProductMasterList', {
                    templateUrl: 'views/Product/Prd_MasterList.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/AddNewProduct', {
                    templateUrl: 'views/Product/Prd_AddEdit.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/ProductDetail/:PRDCODE', {
                    templateUrl: 'views/Product/Prd_Detail.jsp',
                    controller: 'DetailViewController'
                })
                
                 //LLT 2015-12-16 - Add supplier nav
                .when('/SupplierMasterList', {
                    templateUrl: 'views/Supplier/Sup_MasterList.jsp',
                    controller:'PageViewController'
                })
                
                .when('/SupplierDetail/:SUPCODE',{
                    templateUrl:'views/Supplier/Sup_Detail.jsp',
                    controller:'DetailViewController'
                })
                
                .when('/AddNewSupplier',{
                    templateUrl: 'views/Supplier/Sup_AddEdit.jsp',
                    controller: 'PageViewController'
                })
                //LLT END
                
                //LLT 2015-12-28 - Add GRN nav
                .when('/AddGRNItem',{
                    templateUrl: 'views/StockReceive/GRN_AddEdit.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/GRN',{
                    templateUrl: 'views/StockReceive/GRN.jsp',
                    controller: 'PageViewController'
                })
                //LLT END Add GRN nav
                
                .when('/POListing',{
                    templateUrl: 'views/PurchaseOrder/PO_Listing.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/AddPO',{
                    templateUrl: 'views/PurchaseOrder/PO_AddEdit.jsp',
                    controller: 'PageViewController'
                })

 //  Add UOM nav
                .when('/UOMMasterList', {
                    templateUrl: 'views/MasterSetup/StkUOM_MasterList.jsp',
                    controller:'PageViewController'
                })
                
                .when('/UOMDetail/:UOMCODE',{
                    templateUrl:'views/MasterSetup/StkUOM_Detail.jsp',
                    controller:'DetailViewController'
                })
                
                .when('/AddNewUOM',{
                    templateUrl: 'views/MasterSetup/StkUOM_AddEdit.jsp',
                    controller: 'PageViewController'
                })
                
               
                .when('/StockReturnList', {
                    templateUrl: 'views/StockReturn/Ret_HistoryList.jsp',
                    controller:'PageViewController'
                })
                 .when('/AddNewStockReturn', {
                    templateUrl: 'views/StockReturn/Ret_Add.jsp',
                    controller: 'PageViewController'
                })
                
                .when('/StockReturnDetail/:RETHDRIDX', {
                    templateUrl: 'views/StockReturn/Ret_Detail.jsp',
                    controller: 'DetailViewController'
                })
                //  END
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
