<%@page import="BusinessData.BaseDAL"%>
<%@page import="BusinessLogic.BLL_Common"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" 
    contentType="text/html; charset=windows-1256"
    pageEncoding="windows-1256"
%>

<%
 String s_errormsg = "";
 String s_loginid = "";
 String s_passwordid = "";
 String s_bussapp = "";
 String s_cppcode = "";
 String s_SiteName = "";
 
    String [] params = request.getParameterValues("SITE");
    if (params == null){
        session.setAttribute("SiteName", "DEFAULT");             
    }
    else
    {
        session.setAttribute("SiteName", params[0]);            
    }
 
    s_errormsg = BusinessLogic.BLL_Common.establish_MySQLconn((String)session.getAttribute("SiteName"));
 
 if (s_errormsg == "")
 {
      if((String)session.getAttribute("errormsg")!=null)
    {
        s_errormsg = (String)session.getAttribute("errormsg");
    }     
 
    if((String)session.getAttribute("loginid")!=null)
    {
        s_loginid = (String)session.getAttribute("loginid");
    } 
 
    if((String)session.getAttribute("loginpwd")!=null)
    {
        s_passwordid = (String)session.getAttribute("loginpwd");
    }
 
 
    if((String)session.getAttribute("bussapp")!=null)
    {
        s_bussapp = (String)session.getAttribute("bussapp");

    }
    
//    if((String)session.getAttribute("SiteName")!=null)
//    {
//        s_SiteName = (String)session.getAttribute("SiteName");
//
//    }
    else
    {
        session.removeAttribute("loginid");
        session.removeAttribute("errormsg");
        session.removeAttribute("bussapp");  
        session.removeAttribute("loginpwd");
        session.removeAttribute("cppcode");

//        session.removeAttribute("SiteName");
//        s_SiteName = (String)session.getAttribute("SiteName");
//        session.invalidate();
//        session.setAttribute("SiteName", s_SiteName);
        
    }
    
    params = request.getParameterValues("SITE");
    if (params == null){
        session.setAttribute("SiteName", "DEFAULT");             
    }
    else
    {
        session.setAttribute("SiteName", params[0]);            
    }
    s_SiteName = (String) session.getAttribute("SiteName");
    BaseDAL.SiteCode = (String) session.getAttribute("SiteName");
 }
 
%>

<!DOCTYPE html>
<!--<html lang="en-us" id="extr-page" data-ng-app="smartApp" style="background: url('img/bg/bg_services.jpg')no-repeat center center fixed;-webkit-background-size: auto;-moz-background-size: auto;-o-background-size: auto;background-size: 100% 100%;">-->
<html lang="en-us" id="extr-page" data-ng-app="smartApp" style="background-color:#FFF;padding-top:0px;padding-bottom:0px;-webkit-background-size: auto;-moz-background-size: auto;-o-background-size: auto;background-size: 100% 100%;">
<!--<html lang="en-us" id="extr-page" data-ng-app="smartApp" style="-webkit-background-size: auto;-moz-background-size: auto;-o-background-size: auto;background-size: 100% 100%;">-->
	<head>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title> Baljit Clinic System  </title>
		<meta name="description" content="">
		<meta name="author" content="">

		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="css/font-awesome.min.css">

		<!-- SmartAdmin Styles : Please note (smartadmin-production.css) was created using LESS variables -->
		<link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-production.min.css">
		<link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-skins.min.css">

		<!-- SmartAdmin RTL Support is under construction
			 This RTL CSS will be released in version 1.5
		<link rel="stylesheet" type="text/css" media="screen" href="css/smartadmin-rtl.min.css"> -->

		<!-- We recommend you use "your_style.css" to override SmartAdmin
		     specific styles this will also ensure you retrain your customization with each SmartAdmin update.
		<link rel="stylesheet" type="text/css" media="screen" href="../css/your_style.css"> -->

		<!-- Demo purpose only: goes with demo.js, you can delete this css when designing your own WebApp -->
		<link rel="stylesheet" type="text/css" media="screen" href="css/demo.min.css">

		<!-- Angular Related CSS -->
<!--		<link rel="stylesheet" type="text/css" media="screen" href="css/ng.min.css">-->
                
		<!-- FAVICONS -->
		<link rel="shortcut icon" href="img/favicon/favicontemp.png" type="image/x-icon">
		<link rel="icon" href="img/favicon/favicontemp.png" type="image/x-icon">

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

	</head>
	<body class="animated fadeInDown" >
            
		<!-- possible classes: minified, no-right-panel, fixed-ribbon, fixed-header, fixed-width-->
		

		<!--<div id="main" role="main" style="background: url('img/bg/bg_services.jpg')no-repeat center center fixed;-webkit-background-size: auto;-moz-background-size: auto;-o-background-size: auto;background-size: 100% 100%;">-->
                <div id="main" role="main" style="background-color:#FFF;padding-top:0px;padding-bottom:0px;-webkit-background-size: auto;-moz-background-size: auto;-o-background-size: auto;background-size: 100% 100%;">

			<!-- MAIN CONTENT -->
			<div id="content" class="container">

				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-7 col-lg-8 hidden-xs hidden-sm">
						<h1 class="txt-color-red login-header-big">Baljit Clinic System</h1>
						<div class="hero" style="display:none;">

							<div class="pull-left login-desc-box-l">
								<h4 class="paragraph-header">Save money with smart inventory management.</h4>
                                                                <h4 class="paragraph-header">Sharper purchasing and sales.</h4>
                                                                <h4 class="paragraph-header">Streamline the warehouse</h4>
								
							</div>
<!--							<img src="img/demo/claimexlogo.png" height="90" width="210" class="pull-right display-image"  >-->
							<!--<img src="img/demo/mediviron_logo.png" class="pull-right display-image"  >-->

						</div>
                                                <div class="clear"></div>
						<div class="row" style="display:none;">
							<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
								<h5 class="about-heading">About Inventory Control - Are you up to date?</h5>
								<p>
                                                                <ul>
                                                                    <li>Optimise your inventory levels</li>
                                                                    <li>Easily exchange information with your customers and suppliers</li>
                                                                    <li>Benefit from a streamlined order to delivery process</li>
                                                                    <li>Compare your supplier performance based on assortment, delivery time and price</li>
                                                                </ul>
									
								</p>
                                                                
							</div>
							<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
								<h5 class="about-heading">Streamline the warehouse!</h5>
								<p>
								<ul>
                                                                    <li>Simply register warehouse transactions including goods received, stock counts and issues</li>
                                                                    <li>Direct insight into current stock levels</li>
                                                                    <li>Keep in control of your stock: your purchasing and sales work in tandem</li>
                                                                    
                                                                </ul>
								</p>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-5 col-lg-4" >
						<div class="well no-padding">
                                                    <form action="${pageContext.request.contextPath}/Servlet_User?SFC=Check_User_Login" id="login-form" class="smart-form client-form" method="post">
                                                        <header>
                                                                Sign In
                                                        </header>

                                                        <fieldset>
                                                            <section>
                                                                    <!--<label class="label">User Login ID</label>-->
                                                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                                                            <input type="text" name="txtloginid" value="" placeholder='User ID'>
                                                                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> Please enter user login ID</b></label>
                                                            </section>
                                                            <section>
                                                                    <!--<label class="label">Password</label>-->
                                                                    <label class="input"> <i class="icon-append fa fa-lock"></i>
                                                                            <input type="password" name="txtpassword" value="" placeholder='Password'>
                                                                            <b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your password</b> </label>
                                                                    <div class="note" style="display:none;">
                                                                            <a href="forgotpassword.html">Forgot password?</a>
                                                                    </div>
                                                            </section>
                                                            <input type="hidden" name="txtBusinessApp" value="ADMIN">                
                                                            <section>
                                                                    <label class="checkbox">
                                                                            <input type="checkbox" name="remember" checked="">
                                                                            <i></i>Stay signed in</label>

                                                            <button type="submit" class="btn btn-primary" style='width:30%; align:right;'>
                                                                    Sign in
                                                            </button>
<!--                                                                             <button type="button" class="btn btn-primary" onClick="location.href='../Login/index.jsp'" style='width:30%;'>
                                                                    Back
                                                            </button>-->

                                                            </section>
                                                            <%                                                                           
                                                              if (s_errormsg != null || s_errormsg != "")
                                                              {
                                                                out.print("<label  class='txt-color-red label' ><b>"+s_errormsg.toString()+"</b></label>");
                                                              }                                                               
                                                            %>
                                                            <section>

                                                            </section>
                                                        </fieldset>
								<!--<footer>
                                                                        									
                                                                       
                                                                                                                                                                                                                        
								</footer>-->
                                                    </form>   
                                                
                                                </div>						
						
					</div>
				</div>
			</div>

		</div>
                                                                        
    <input type="hidden" id="site" value="<%= s_SiteName %>" />

                                                                        
                <!--================================================== -->	

		<!-- PACE LOADER - turn this on if you want ajax loading to show (caution: uses lots of memory on iDevices)
		<script data-pace-options='{ "restartOnRequestAfter": true }' src="js/plugin/pace/pace.min.js"></script>-->

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

		<!-- BOOTSTRAP JS -->
		<script src="js/bootstrap/bootstrap.min.js"></script>

		<!-- JQUERY VALIDATE -->
		<script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>

		<!-- JQUERY MASKED INPUT -->
		<script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>
		
		<!--[if IE 8]>
			
			<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
			
		<![endif]-->

		<script type="text/javascript">
	 $(document).ready(function () {
       
//        $("#hdnReqToDate").val($("#txtReqDTTo").val());
 
  $.ajax({
                type:'POST',
                url:"${pageContext.request.contextPath}/Servlet_SitesDBInfor",
                data:  {
                    SFC: 'GET_SITE_DISPLAYNAME'
                },
                dataType: 'json',
                success: function(data) {               
                             
                         
                        var arrItemData = data.object1[0];  
                        
                         $(document).prop('title', arrItemData.DisplayName + ' ');
//                        $("#lblDocNo").val(arrItemData.DisplayName);               
        
                }     
                //error:  AjaxError
            });
            
        });
    

			$(function() {
				// Validation
				$("#login-form").validate({
					// Rules for form validation
					rules : {
						txtloginid : {
							required : true
							
						},
						txtpassword : {
							required : true,
							minlength : 3,
							maxlength : 20
						}
					},

					// Messages for form validation
					messages : {
						txtloginid : {
							required : 'Please enter your user login ID'
							
						},
						txtpassword : {
							required : 'Please enter your password'
						}
					},

					// Do not change code below
					errorPlacement : function(error, element) {
						error.insertAfter(element.parent());
					}
				});
			});
                        
        
                            
   		</script>
                                    
                                       
              
	</body>
           
</html>