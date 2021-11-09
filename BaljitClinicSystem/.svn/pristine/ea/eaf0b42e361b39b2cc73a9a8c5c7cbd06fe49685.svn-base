<!DOCTYPE html>
<html lang="en-us" data-ng-app="smartApp">
    <head>
        <meta charset="utf-8">
        <!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

        <title>  </title>
        <meta name="description" content="">
        <meta name="author" content="">

        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <!-- Basic Styles -->
        <!--  <link rel="stylesheet" type="text/css"  href="../template/css/demo6.css">
          <link rel="stylesheet" type="text/css" href="../../template/css/easyui.css" />
          <script src="../../template/Js/jquery-1.4.4.min.js"></script>
          <script src="../../template/Js/jquery.easyui.min.js"></script>-->

        <link rel="stylesheet" type="text/css" media="screen" href="../css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" media="screen" href="../css/font-awesome.min.css">

        <!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
        <link rel="stylesheet" type="text/css" media="screen" href="../css/smartadmin-production.min.css">
        <!--<link rel="stylesheet" type="text/css" media="screen" href="../css/smartadmin-skins.min.css">-->

        <!-- SmartAdmin RTL Support is under construction-->
        <!--<link rel="stylesheet" type="text/css" media="screen" href="../css/smartadmin-rtl.min.css">-->

        <!-- JQUERY Multiselect2side css -->
        <!--<link rel="stylesheet" type="text/css" media="screen" href="../template/css/jquery.multiselect2side.css" />-->

        <!-- We recommend you use "your_style.css" to override SmartAdmin
             specific styles this will also ensure you retrain your customization with each SmartAdmin update.
        -->        <link rel="stylesheet" type="text/css" media="screen" href="../css/your_style.css"> 

        <!-- Goes with demo.js, you can delete this css when designing your own WebApp -->
        <!--<link rel="stylesheet" type="text/css" media="screen" href="../css/demo.min.css">-->

        <!-- FAVICONS -->
        <!--<link rel="shortcut icon" href="img/favicon/medexicon.ico" type="image/x-icon">-->
        <link rel="icon" href="img/favicon/medexicon.ico" type="image/x-icon">

        <!-- GOOGLE FONT -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

        <!-- Specifying a Webpage Icon for Web Clip
                 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
        <link rel="apple-touch-icon" href="img/splash/sptouch-icon-iphone.png">
        <link rel="apple-touch-icon" sizes="76x76" href="img/splash/touch-icon-ipad.png">
        <link rel="apple-touch-icon" sizes="120x120" href="img/splash/touch-icon-iphone-retina.png">
        <link rel="apple-touch-icon" sizes="152x152" href="img/splash/touch-icon-ipad-retina.png">

        <!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">

        <!-- Startup image for web apps -->
        <link rel="apple-touch-startup-image" href="img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
        <link rel="apple-touch-startup-image" href="img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
        <link rel="apple-touch-startup-image" href="img/splash/iphone.png" media="screen and (max-device-width: 320px)">
        <style type="text/css">
            .ui-jqgrid tr.jqgrow td {
                word-wrap: break-word; /* IE 5.5+ CSS3 see http://www.w3.org/TR/css3-text/#text-wrap */
                white-space: pre-wrap; /* CSS3 */
                white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
                white-space: -pre-wrap; /* Opera 4-6 */
                white-space: -o-pre-wrap; /* Opera 7 */
                overflow: hidden;
                height: auto;
                vertical-align: middle;
                padding-top: 3px;
                padding-bottom: 3px
            }
        </style>

    </head>
    <!-- POSSIBLE CLASSES: minified, fixed-ribbon, fixed-header, fixed-width, top-menu
             You can also add different skin classes such as "smart-skin-0", "smart-skin-1" etc...-->




    <!-- MAIN PANEL -->
    <div id="pageHeader" class="row padding-10"></div>
    <div id="selectionCriteria" class="row padding-10"></div>
    <div class="row padding-10" style='margin-left: 25px;margin-right: 25px'>
        <div class="row">
            <div id="cjqgrid" class="table">
                <table id="jqgrid" class="table table-striped table-bordered"  ></table>
                <div id="pjqgrid"></div>
            </div>
            <!--            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-10"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
                                <header id='pageHeader'>
                                    
                                </header>
                                <div>
                                     widget edit box 
                                    <div class="jarviswidget-editbox">
                                         This area used as dropdown edit box 
                                    </div>
                                     end widget edit box 
            
                                     widget content 
                                    
                                     end widget content 
                                </div>
                            </div>
                        </article>-->
        </div>
    </section>
</div>
<!-- END MAIN PANEL -->

<!-- PAGE FOOTER -->
<!-- END FOOTER -->

<!-- SHORTCUT AREA : With large tiles (activated via clicking user name tag)
Note: These tiles are completely responsive,
you can add as many as you like
-->
<!-- END SHORTCUT AREA -->

<!--================================================== -->

<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)
<script data-pace-options='{ "restartOnRequestAfter": true }' src="js/plugin/pace/pace.min.js"></script>-->

<!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<script>
            if (!window.jQuery) {
                document.write('<script src="../js/libs/jquery-2.0.2.min.js"><\/script>');
            }
</script>

<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script>
            if (!window.jQuery.ui) {
                document.write('<script src="../js/libs/jquery-ui-1.10.3.min.js"><\/script>');
            }
</script>

<!-- MAIN APP JS FILE -->
<script src="../js/app.config.js"></script>

<!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
<script src="../js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>

<!-- BOOTSTRAP JS -->
<script src="../js/bootstrap/bootstrap.min.js"></script>

<!-- CUSTOM NOTIFICATION -->
<script src="../js/notification/SmartNotification.min.js"></script>

<!-- JARVIS WIDGETS -->
<script src="../js/smartwidgets/jarvis.widget.min.js"></script>

<!-- EASY PIE CHARTS -->
<script src="../js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

<!-- SPARKLINES -->
<script src="../js/plugin/sparkline/jquery.sparkline.min.js"></script>

<!-- JQUERY VALIDATE -->
<script src="../js/plugin/jquery-validate/jquery.validate.min.js"></script>

<!-- JQUERY MASKED INPUT -->
<script src="../js/plugin/masked-input/jquery.maskedinput.min.js"></script>

<!-- JQUERY SELECT2 INPUT -->
<script src="../js/plugin/select2/select2.min.js"></script>

<!-- JQUERY UI + Bootstrap Slider -->
<script src="../js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

<!-- browser msie issue fix -->
<script src="../js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

<!-- FastClick: For mobile devices: you can disable this in app.js -->
<script src="../js/plugin/fastclick/fastclick.min.js"></script>

<!--[if IE 8]>
        <h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
<![endif]-->

<!-- AngularJS -->
<script src="../js/libs/angular/angular.js"></script>
<script src="../js/libs/angular/angular-route.js"></script>
<script src="../js/libs/angular/angular-animate.js"></script>
<script src="../js/libs/angular/ui-bootstrap-custom-tpls-0.11.0.js"></script>

<!-- ANGULAR: Handled via "ribbon" directive
<script src="js/demo.js"></script>-->

<!-- MAIN APP JS FILE -->
<!--<script src="../js/app.js"></script>-->

<!-- MAIN ANGULAR JS FILE -->
<!--<script src="../js/ng/ng.app.js"></script>-->
<!--<script src="../js/ng/ng.controllers.js"></script>-->
<!--<script src="../js/ng/ng.directives.js"></script>-->

<!-- PLUNKER -->
<script src="../js/ng/plunker.js"></script>

<!-- PAGE RELATED PLUGIN(S) -->
<script src="../js/plugin/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
<script src="../js/plugin/fuelux/wizard/wizard.min.js"></script>

<!-- JQUERY MULTISELECT2SIDE JS -->
<script src="../template/Js/jquery.multiselect2side.js" ></script>

<!-- DATATABLE PLUGIN(S) -->
<script src="../js/plugin/datatables/jquery.dataTables.min.js"></script>
<script src="../js/plugin/datatables/dataTables.colVis.min.js"></script>
<script src="../js/plugin/datatables/dataTables.tableTools.min.js"></script>
<script src="../js/plugin/datatables/dataTables.bootstrap.min.js"></script>
<script src="../js/plugin/datatable-responsive/datatables.responsive.min.js"></script>

<script src="../js/plugin/jqgrid/grid.locale-en.min.js"></script>
<script src="../js/plugin/jqgrid/jquery.jqGrid.min.js"></script>

<!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
<!-- Voice command : plugin -->
<script src="../js/speech/voicecommand.min.js"></script>
<link rel="stylesheet" type="text/css" href="../template/css/easyui.css" />
<script type="text/javascript">
            /* DO NOT REMOVE : GLOBAL FUNCTIONS!
             *
             * pageSetUp(); WILL CALL THE FOLLOWING FUNCTIONS
             *
             * // activate tooltips
             * $("[rel=tooltip]").tooltip();
             *
             * // activate popovers
             * $("[rel=popover]").popover();
             *
             * // activate popovers with hover states
             * $("[rel=popover-hover]").popover({ trigger: "hover" });
             *
             * // activate inline charts
             * runAllCharts();
             *
             * // setup widgets
             * setup_widgets_desktop();
             *
             * // run form elements
             * runAllForms();
             *
             ********************************
             *
             * pageSetUp() is needed whenever you load a page.
             * It initializes and checks for all basic elements of the page
             * and makes rendering easier.
             *
             */

            /*
             * ALL PAGE RELATED SCRIPTS CAN GO BELOW HERE
             * eg alert("my home function");
             * 
             * var pagefunction = function() {
             *   ...
             * }
             * loadScript("js/plugin/_PLUGIN_NAME_.js", pagefunction);
             * 
             */

            function refresh(objIn) {
                $("#jqgrid").jqGrid('clearGridData').jqGrid('setGridParam', objIn).trigger("reloadGrid");
            };
            
            //LLT 2016-05-25 for datepicker function
             $(window).on('load',function(){
                $(window.document).find(window.object2).datepicker({
                    numberOfMonths: 1,
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd"
                });
            });
            //END LLT for datepicker function
            
            var globalfunc;
            (function () {
                if (typeof window.selection == "string") {
                    $("#selectionCriteria").html(window.selection);
                }
                if (typeof window.selection == "string") {
                    $("#pageHeader").html(window.header);
                }
                if (typeof window.function == "object" || typeof window.function == "function") {
                    globalfunc = window.function;
                }
                $("#jqgrid").jqGrid(window.object);
                
                // remove classes
                $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
                $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
                $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
                $(".ui-jqgrid-pager").removeClass("ui-state-default");
                $(".ui-jqgrid").removeClass("ui-widget-content");

                // add classes
                $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
                $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");


                $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
                $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus");
                $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil");
                $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o");
                $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
                $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
                $(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
                $(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

                $(".ui-icon.ui-icon-seek-prev").wrap("<div class='btn btn-sm btn-default'></div>");
                $(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");

                $(".ui-icon.ui-icon-seek-first").wrap("<div class='btn btn-sm btn-default'></div>");
                $(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");

                $(".ui-icon.ui-icon-seek-next").wrap("<div class='btn btn-sm btn-default'></div>");
                $(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");

                $(".ui-icon.ui-icon-seek-end").wrap("<div class='btn btn-sm btn-default'></div>");
                $(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");
                $(window).on('resize', function () {
                    jQuery("#jqgrid").jqGrid('setGridWidth', jQuery("#cjqgrid").width());
                });
                jQuery("#jqgrid").on('myRefresh', function () {
                    resizeWidth({grid: jQuery("#jqgrid"), gridDiv: jQuery("#cjqgrid")});
                });                  
            })();

</script>

</html>