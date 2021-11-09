


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



        		<div id="logo-group">

				<!-- PLACE YOUR LOGO HERE -->
				<span id="">  </span>
				<!-- END LOGO PLACEHOLDER -->			
			</div>		

			<!-- pulled right: nav area -->
			<div class="pull-right">
				
				<!-- collapse menu button -->
				<div id="hide-menu" class="btn-header pull-right">
					<span> <a href="javascript:void(0);" data-action="toggleMenu" title="Collapse Menu"><i class="fa fa-reorder"></i></a> </span>
				</div>
				<!-- end collapse menu -->
				
				

				<!-- logout button -->
				<div id="logout" class="btn-header transparent pull-right">
					<span> <a href="${pageContext.request.contextPath}/Admin/signout.jsp" title="Sign Out" data-action="userLogout" data-logout-msg= "Are you sure want to logout?"><i class="fa fa-sign-out"></i></a> </span>
				</div>
				<!-- end logout button -->

				<!-- search mobile button (this is hidden till mobile view port) -->
				<div id="search-mobile" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0)" title="Search"><i class="fa fa-search"></i></a> </span>
				</div>
				<!-- end search mobile button -->

				

				<!-- fullscreen button -->
				<!--<div id="fullscreen" class="btn-header transparent pull-right">
					<span> <a href="javascript:void(0);" data-action="launchFullscreen" title="Full Screen"><i class="fa fa-arrows-alt"></i></a> </span>
				</div>-->
				<!-- end fullscreen button -->

				<!-- #Voice Command: Start Speech -->
				<!--<div id="speech-btn" class="btn-header transparent pull-right hidden-sm hidden-xs">
					<div> 
						<a href="javascript:void(0)" title="Voice Command" data-action="voiceCommand"><i class="fa fa-microphone"></i></a> 
						<div class="popover bottom"><div class="arrow"></div>
							<div class="popover-content">
								<h4 class="vc-title">Voice command activated <br><small>Please speak clearly into the mic</small></h4>
								<h4 class="vc-title-error text-center">
									<i class="fa fa-microphone-slash"></i> Voice command failed
									<br><small class="txt-color-red">Must <strong>"Allow"</strong> Microphone</small>
									<br><small class="txt-color-red">Must have <strong>Internet Connection</strong></small>
								</h4>
								<a href="javascript:void(0);" class="btn btn-success" onclick="commands.help()">See Commands</a> 
								<a href="javascript:void(0);" class="btn bg-color-purple txt-color-white" onclick="$('#speech-btn .popover').fadeOut(50);">Close Popup</a> 
							</div>
						</div>
					</div>
				</div>-->
				<!-- end voice command -->

				<!-- multiple lang dropdown : find all flags in the image folder -->
                                
				<ul data-lang-menu="" class="header-dropdown-list hidden-xs" data-ng-controller="LangController">
					
                                       <li>
                                            <font color="#FFFFF">Login As : <%= session.getAttribute("fullname")%> </font>
                                        </li>
                                        <li>
						<a href="" class="dropdown-toggle" data-toggle="dropdown">
							<img alt="" class="flag flag-{{ currentLang.flagCode }}" src="img/blank.gif"> <span> {{ currentLang.translation }} </span> <i class="fa fa-angle-down"></i> 
						</a>
						<ul class="dropdown-menu pull-right">
							<li data-ng-class="{active: lang == currentLang}" data-ng-repeat="lang in languages">
								<a href="" data-ng-click="setLang(lang)" ><img class="flag flag-{{ lang.flagCode }}" src="img/blank.gif" /> {{ lang.language }} ({{ lang.translation }}) </a>
							</li>
						</ul>
					</li>
				</ul>
				<!-- end multiple lang -->

			</div>
			<!-- end pulled right: nav area -->
                        
<script type="text/javascript">
   
    
 
</script>     
                         