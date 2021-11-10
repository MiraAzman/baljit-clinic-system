<%@page import="BusinessData.BaseDAL"%>
<!DOCTYPE html>
<%  
   
   //localhost:8080/InventoryControl/Admin/index.jsp?SITE=M1
    
    
//    String s_loginpwd = (String) session.getAttribute("loginpwd");
//
//    String s_cppcode = (String) session.getAttribute("cppcode");
//    String s_cppname = (String) session.getAttribute("cppname");
//
//    String s_bussapp = (String) session.getAttribute("bussapp");
    String s_loginid = (String) session.getAttribute("loginid");
    String s_usercode = (String) session.getAttribute("usercode");
    String s_usrName = (String) session.getAttribute("fullname");
    String s_usrMail = (String) session.getAttribute("Usremail");
    String s_CompCode = (String) session.getAttribute("CompCode");
    String s_LocCode = (String) session.getAttribute("LocCode");
    String s_UsrRole = (String) session.getAttribute("UsrRole");
    //---
//    String[] params = request.getParameterValues("SITE");
//    if (params == null){
//        session.setAttribute("SiteName", "DEFAULT");             
//    }
//    else
//    {
//        session.setAttribute("SiteName", params[0]);            
//    }
//    BaseDAL.SiteCode = (String) session.getAttribute("SiteName");
//  String s_SiteName = (String) session.getAttribute("SiteName");
  //---
  
    String s_SiteName = (String) session.getAttribute("SiteName");
    if (s_SiteName == null ) { 
    String[] params = request.getParameterValues("SITE");
        if (params == null){
            s_SiteName= "DEFAULT";
        }
        else
        {
            s_SiteName = params[0];            
        }
        
        session.setAttribute("SiteName", s_SiteName);
        
        BaseDAL.SiteCode = s_SiteName;
    }
//    if (s_loginid == null) {
    if (s_loginid == null ) {         
//        String[] params = request.getParameterValues("SITE");
//        if (params == null){
//            s_SiteName= "DEFAULT";
//        }
//        else
//        {
//            s_SiteName = params[0];            
//        }
//        session.setAttribute("SiteName", s_SiteName);
//        
//        BaseDAL.SiteCode = s_SiteName;
        
        String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        response.sendRedirect(response.encodeRedirectURL(contextPath + "/Admin/Adm_Login.jsp"+"?SITE=" + (String) session.getAttribute("SiteName")));
    }
//
//    if (s_loginid == null || s_loginpwd == null || s_cppcode == null || s_cppname == null || s_bussapp == null || s_usercode == null) {
//        String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
//        response.sendRedirect(response.encodeRedirectURL(contextPath + "/Login/admin_login.jsp"));
//    }
   // session.setAttribute("s_usercode", "Admin");
%>
<html lang="en-us" data-ng-app="smartApp">
    <head>
        <meta charset="utf-8">
        <!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

        <title> Baljit Clinic System </title>
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
        <link rel="stylesheet" type="text/css" media="screen" href="../css/smartadmin-skins.min.css">

        <!-- SmartAdmin RTL Support is under construction-->
        <link rel="stylesheet" type="text/css" media="screen" href="../css/smartadmin-rtl.min.css">

        <!-- JQUERY Multiselect2side css -->
        <link rel="stylesheet" type="text/css" media="screen" href="../css/jquery.multiselect2side.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="../css/chosen.css">

        <!-- We recommend you use "your_style.css" to override SmartAdmin
             specific styles this will also ensure you retrain your customization with each SmartAdmin update. -->
        <link rel="stylesheet" type="text/css" media="screen" href="../css/your_style.css">

        <!-- Goes with demo.js, you can delete this css when designing your own WebApp -->
        <link rel="stylesheet" type="text/css" media="screen" href="../css/demo.min.css">

        <!-- FAVICONS -->
        <link rel="shortcut icon" href="../img/favicon/medexicon.ico" type="image/x-icon">
        <link rel="icon" href="../img/favicon/medexicon.ico" type="image/x-icon">

        <!-- GOOGLE FONT -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">

        <!-- Specifying a Webpage Icon for Web Clip
                 Ref: https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html -->
        <link rel="apple-touch-icon" href="../img/splash/sptouch-icon-iphone.png">
        <link rel="apple-touch-icon" sizes="76x76" href="../img/splash/touch-icon-ipad.png">
        <link rel="apple-touch-icon" sizes="120x120" href="../img/splash/touch-icon-iphone-retina.png">
        <link rel="apple-touch-icon" sizes="152x152" href="../img/splash/touch-icon-ipad-retina.png">

        <!-- iOS web-app metas : hides Safari UI Components and Changes Status Bar Appearance -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">

        <!-- Startup image for web apps -->
        <link rel="apple-touch-startup-image" href="../img/splash/ipad-landscape.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)">
        <link rel="apple-touch-startup-image" href="../img/splash/ipad-portrait.png" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)">
        <link rel="apple-touch-startup-image" href="../img/splash/iphone.png" media="screen and (max-device-width: 320px)">
        <!--FORM UI CSS-->
        <link rel="stylesheet" type="text/css" href="../css/your_style.css" />
    </head>
    <body class="minified smart-style-3" data-ng-controller="SmartAppController">
        <!-- POSSIBLE CLASSES: minified, fixed-ribbon, fixed-header, fixed-width, top-menu
                 You can also add different skin classes such as "smart-skin-0", "smart-skin-1" etc...-->

        <!-- MAIN PANEL -->
        <div id="main" role="main" class="" >

            <!-- HEADER -->
            <header id="header" data-ng-include="'includes/header.jsp'"></header>
            <!-- END HEADER -->
            <!-- RIBBON -->
            <div id="ribbon" data-ng-include="'includes/ribbon.html'" data-ribbon=""></div>
            <!-- END RIBBON -->

            <!-- MAIN CONTENT -->
            <div id="content" data-ng-view="" class="view6-animate"></div>
            <div hidden="">
                <input id="passer" hidden=""/>
            </div>
            <!-- END MAIN CONTENT -->
            <!-- Left panel : Navigation area -->
            <!-- Note: This width of the aside area can be adjusted through LESS variables -->
            <aside id="left-panel" ><span data-ng-include="'includes/left-menuDB.jsp'"></span></aside>
            <!-- END NAVIGATION -->

        </div>
        
<input type="hidden" id="site" value="<%= s_SiteName %>" />        
<input type="hidden" id="usercode" value="<%= s_usercode %>" />
        <!-- END MAIN PANEL -->


        <!-- PAGE FOOTER -->
        <div class="page-footer"><span data-ng-include="'includes/footer.html'"></span></div>
        <!-- END FOOTER -->

        <!-- SHORTCUT AREA : With large tiles (activated via clicking user name tag)
        Note: These tiles are completely responsive,
        you can add as many as you like
        -->
        <div id="shortcut"><span data-ng-include="'includes/shortcut.html'"></span></div>
        <!-- END SHORTCUT AREA -->


        <!--================================================== -->

        <!--PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)-->
        <script data-pace-options='{ "restartOnRequestAfter": true }' src="js/plugin/pace/pace.min.js"></script>

        <!-- Link to Google CDN's jQuery + jQueryUI; fall back to local -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script>
                            if (!window.jQuery) {
                                document.write('<script src="js/libs/jquery-2.0.2.min.js"><\/script>');
                            }
        </script>

        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
        <script>
                            if (!window.jQuery.ui) {
                                document.write('<script src="js/libs/jquery-ui-1.10.3.min.js"><\/script>');
                            }
        </script>

        <!-- MAIN APP JS FILE -->
        <script src="js/app.config.js"></script>

        <!-- JS TOUCH : include this plugin for mobile drag / drop touch events-->
        <script src="js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>

        <!-- BOOTSTRAP JS -->
        <script src="js/bootstrap/bootstrap.min.js"></script>

        <!-- CUSTOM NOTIFICATION -->
        <script src="js/notification/SmartNotification.min.js"></script>

        <!-- JARVIS WIDGETS -->
        <script src="js/smartwidgets/jarvis.widget.min.js"></script>

        <!-- EASY PIE CHARTS -->
        <script src="js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>

        <!-- SPARKLINES -->
        <script src="js/plugin/sparkline/jquery.sparkline.min.js"></script>

        <!-- JQUERY VALIDATE -->
        <script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>
        <!--<script src="js/multiselect-provider.js"></script>-->

        <!-- JQUERY MASKED INPUT -->
        <script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>

        <!-- JQUERY SELECT2 INPUT -->
        <script src="js/plugin/select2/select2.min.js"></script>

        <!-- JQUERY UI + Bootstrap Slider -->
        <script src="js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>

        <!-- browser msie issue fix -->
        <script src="js/plugin/msie-fix/jquery.mb.browser.min.js"></script>

        <!-- FastClick: For mobile devices: you can disable this in app.js -->
        <script src="js/plugin/fastclick/fastclick.min.js"></script>

        <!--[if IE 8]>
                <h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
        <![endif]-->

        <!-- AngularJS -->
        <script src="js/libs/angular/angular.js"></script>
        <script src="js/libs/angular/angular-route.js"></script>
        <script src="js/libs/angular/angular-animate.js"></script>
        <script src="js/libs/angular/ui-bootstrap-custom-tpls-0.11.0.js"></script>

        <!-- ANGULAR: Handled via "ribbon" directive
        <script src="js/demo.js"></script>-->

        <!-- MAIN APP JS FILE -->
        <script src="js/app.js"></script>

        <!--Format Date Js-->
        <script src="js/moment.js"></script>

        <!-- MAIN ANGULAR JS FILE -->
        <script src="js/ng/ng.app.js"></script>
        <script src="js/ng/ng.controllers.js"></script>
        <script src="js/ng/ng.directives.js"></script>

        <script src="../js/plugin/jqgrid/grid.locale-en.min.js"></script>
        <script src="../js/plugin/jqgrid/jquery.jqGrid.min.js"></script>

        <!-- PLUNKER -->
        <script src="js/ng/plunker.js"></script>

        <!-- PAGE RELATED PLUGIN(S) -->
        <script src="js/plugin/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
        <script src="js/plugin/fuelux/wizard/wizard.min.js"></script>

        <!-- JQUERY MULTISELECT2SIDE JS -->
        <script src="js/jquery.multiselect2side.js" ></script>

        <script src="js/plugin/jqgrid/ui.multiselect.js"></script>

        <!-- DATATABLE PLUGIN(S) -->
        <script src="js/plugin/datatables/jquery.dataTables.min.js"></script>
        <script src="js/plugin/datatables/dataTables.colVis.min.js"></script>
        <script src="js/plugin/datatables/dataTables.tableTools.min.js"></script>
        <script src="js/plugin/datatables/dataTables.bootstrap.min.js"></script>
        <script src="js/plugin/datatable-responsive/datatables.responsive.min.js"></script>
        <script src="js/jquery.numeric.js"></script>
        <script src="js/jquery.alphanum.js"></script>
        <script src="js/jquery.inputmask.min.js"></script>
        <!-- ENHANCEMENT PLUGINS : NOT A REQUIREMENT -->
        <!-- Voice command : plugin -->
        <script src="js/speech/voicecommand.min.js"></script>
        <!--<link rel="stylesheet" type="text/css" href="../../template/css/easyui.css" />-->
        <%--<jsp:include page="../includes/loading-no-status.jsp"/>--%>
        <script type="text/javascript">
            
                            var bigBoxTimedOut = 6000;
                            // DO NOT  : REMOVEGLOBAL FUNCTIONS!
                            var contextPath = "${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
                                                $(document).ready(function () {
                                                    //timeout = setTimeout("alert('Timeout');", 1500);
                                                    var timeout;
                                                    $(document);
                                                    /*
                                                     .ajaxStart(function () {
                                                     //alert();
                                                     timeout = setTimeout("$('#loadingModal').modal('show');", 1500);
                                                     })
                                                     .ajaxStop(function () {
                                                     $('#loadingModal').modal('hide');
                                                     clearTimeout(timeout);
                                                     });
                                                     */

                                                    $('.grid').bind('mousewheel DOMMouseScroll', function (e) {
                                                        alert();
                                                        var scrollTo = null;

                                                        if (e.type == 'mousewheel') {
                                                            scrollTo = (e.originalEvent.wheelDelta * -1);
                                                        }
                                                        else if (e.type == 'DOMMouseScroll') {
                                                            //alert("DOM");
                                                            scrollTo = 40 * e.originalEvent.detail;
                                                        }

                                                        if (scrollTo) {
                                                            e.preventDefault();
                                                            //$("#jqgridSummary").scrollTop(100);
                                                            //$(this).animate({ scrollTop: 100 }, "slow");
                                                            $(this).closest(".ui-jqgrid-bdiv").scrollTop(scrollTo + $(this).closest(".ui-jqgrid-bdiv").scrollTop());
                                                            //alert($(this).attr('id')+" : "+ $(this).scrollTop());
                                                        }
                                                    });
                                                    pageSetUp();

                                                    $.ajaxSetup({cache: false}); //for IE Caching problem
                                                    pageSetUp();
                                                    $(".numeric").numeric();

                                                    if (($('#usercode').val() !== null) && ($('#site').val() !== null)) { //check whether session is timed out
                                                        //GetAppSettings();
                                                    }
                                                });

                                                $("div.mouseevt").click(function () {
                                                    if (!$.root_.hasClass("menu-on-top")) {
                                                        $.root_.toggleClass("minified");
                                                        $.root_.removeClass("hidden-menu");
                                                        $('html').removeClass("hidden-menu-mobile-lock");
                                                        $this.effect("highlight", {}, 500);
                                                    }
                                                });
                                                                                              
        </script>
        <jsp:include page="../includes/session_admin.jsp"/>      
    </body>

</html>
