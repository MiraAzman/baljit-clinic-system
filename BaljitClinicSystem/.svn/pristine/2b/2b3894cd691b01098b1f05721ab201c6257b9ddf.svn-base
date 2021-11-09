<%@page import="BusinessData.BaseDAL"%> 
 <%
     Integer int_interval = (int) session.getMaxInactiveInterval();
     
     //String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
     
    String s_SiteName = (String) session.getAttribute("SiteName");
    if (s_SiteName == null ) {         
		String[] params = request.getParameterValues("SITE");
        if (params == null) {
            s_SiteName= "DEFAULT";
        }
        else {
            s_SiteName = params[0];            
        }
    
        session.setAttribute("SiteName", s_SiteName);
        
        BaseDAL.SiteCode = s_SiteName;
    }
    String contextPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath()
                        + "/Admin/Adm_Login.jsp"+"?SITE=" + (String) session.getAttribute("SiteName");
     
 %>
 <input type="hidden" id="hid_interval" value="<%= int_interval%>"/>
 <input type="hidden" id="hid_contentPath" value="<%= contextPath%>"/>
<!--<script type="text/javascript" src="js/jquery.min.js"></script>-->
<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
 <!-- include smoothness jQueryUI theme -->
 <!--<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">-->
 <!-- jQuery idletimer plugin http://paulirish.com/2009/jquery-idletimer-plugin/ -->
 <script type="text/javascript" src="../js/jquery.idletimer.js"></script>
 <script type="text/javascript">
        //alert(($("#hid_interval").val() * 1000)- ((5*1000)+ (10 *1000)));
	var idleTime = ($("#hid_interval").val() * 1000)- ((5*1000)+ (30 *1000)); // number of miliseconds until the user is considered idle
	//var idleTime = 600000; 
        var initialSessionTimeoutMessage = 'Your session will expire in <span id="sessionTimeoutCountdown"></span>&nbsp;seconds.<br/><br />Click on <b>OK</b> to continue your session.';
	var sessionTimeoutCountdownId = 'sessionTimeoutCountdown';
	var redirectAfter = 30; // number of seconds to wait before redirecting the user
	var redirectTo = $("#hid_contentPath").val(); // URL to relocate the user to once they have timed out
	var keepAliveURL = 'aaa.jsp'; // URL to call to keep the session alive
	var expiredMessage = 'Your session has expired.  You are being logged out for security reasons.'; // message to show user when the countdown reaches 0
	var running = false; // var to check if the countdown is running
	var timer; // reference to the setInterval timer so it can be stopped
	$(document).ready(function() {
		// create the warning window and set autoOpen to false
		var sessionTimeoutWarningDialog = $("#sessionTimeoutWarning");
		$(sessionTimeoutWarningDialog).html(initialSessionTimeoutMessage);
		$(sessionTimeoutWarningDialog).dialog({
			title: 'Session Expiration Warning',
			autoOpen: false,	// set this to false so we can manually open it
			closeOnEscape: false,
			draggable: false,
			width: 460,
			minHeight: 50, 
			modal: true,
			beforeClose: function() { // bind to beforeclose so if the user clicks on the "X" or escape to close the dialog, it will work too
				// stop the timer
				clearInterval(timer);
					
				// stop countdown
				running = false;
				
				// ajax call to keep the server-side session alive
				$.ajax({
				  url: keepAliveURL,
				  async: false
				});
			},
			buttons: {
				OK: function() {
                                       
                                       clearInterval(timer);
                                 	// close dialog
					$(this).dialog('close');
				}
			},
			resizable: false,
			open: function() {
				// scrollbar fix for IE
				$('body').css('overflow','hidden');
			},
			close: function() {
				// reset overflow
				$('body').css('overflow','auto');
			}
		}); // end of dialog


		// start the idle timer
		$.idleTimer(idleTime);
		
		// bind to idleTimer's idle.idleTimer event
		$(document).bind("idle.idleTimer", function(){
			// if the user is idle and a countdown isn't already running
			if($.data(document,'idleTimer') === 'idle' && !running){
				var counter = redirectAfter;
				running = true;
				
				// intialisze timer
				$('#'+sessionTimeoutCountdownId).html(redirectAfter);
				// open dialog
				$(sessionTimeoutWarningDialog).dialog('open');
				
				// create a timer that runs every second
				timer = setInterval(function(){
					counter -= 1;
					
					// if the counter is 0, redirect the user
					if(counter === 0) {
						$(sessionTimeoutWarningDialog).html(expiredMessage);
						$(sessionTimeoutWarningDialog).dialog('disable');
						window.location = redirectTo;
					} else {
						$('#'+sessionTimeoutCountdownId).html(counter);
					};
				}, 1000);
			};
		});

	});
        
  </script> 
  <div id="sessionTimeoutWarning" style="display: none"></div>
  

