<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="DDL" scope="page" class="BusinessLogic.Servlet_PopulateData" />
<jsp:useBean id="DDLRole" scope="page" class="BusinessLogic.Servlet_User" />
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
    .centered {
        position: fixed;
        top: 50%;
        left: 50%;
        margin-top: -50px;
        margin-left: -200px;
    }
    div.errorContainer, div.errorContainer2{
        display:none;
        width:100%;
    }
    div.errorContainer, div.errorContainer2 ol li{
        list-style-type:disc;
        margin-left: 20px;
    }
    li{
        list-style:none;
    }
    .disabledTab{
        pointer-events: none;
    }
    input[type="text"].error { border: 1px solid #A94444; background-color:#FFF0F0; }
    textarea.error { border: 1px solid #A94444; background-color:#FFF0F0; }
</style>
<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />
<section id="widget-grid" class="">
    <input type="hidden" id="lblUserCode" value="<%= session.getAttribute("usercode")%>"/> 

    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-lock fa-2x"></i> 
            Change Password                                    
        </h1>
    </div>
    <div class="widget-body row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            
            <div class="row" style="padding-bottom:10px;padding-left:10px;padding-right:10px;">
                <div class="errorContainer alert alert-danger alert-block">
                    <h4 class="alert-heading">There were some field left out or invalid inputs. Please brief through the form and reenter necessarily.</h4>
                    <ol id="error_list">
                    </ol>
                </div>
            </div>         
            <div class="row">
                <form id="formChangePwd" name="formChangePwd" method="post">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Password Info</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">
                                    <table id="tbUserInfo" class="selection-criteria" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="18%">Current Password</td>
                                                <td width="1%">:</td>
                                                <td width="81%"> 
                                                    <input type="password" id="txtCurrentPwd" name="txtCurrentPwd" class="form-control" style="width:250px;"/>    
<!--                                                </td>-->
<!--                                                <td width=64%">-->
                                                    <span id="error_CurrentPwdRequired" style="color:red;display:none;"><i class="fa fa-fw fa-lg fa-exclamation-triangle"></i> Please enter your current password</span>
                                                    <span id="error_CurrentPwdWrong" style="color:red;display:none;"><i class="fa fa-fw fa-lg fa-exclamation-triangle"></i> Your password was incorrect</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>New Password</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="password" id="txtNewPwd" name="txtNewPwd" class="form-control" onchange="CheckMatchPwd();" onkeyup="CheckMatchPwd();" style="width:250px;"/>    
<!--                                                </td>-->
<!--                                                <td>-->
                                                    <span id="error_NewPwdRequired" style="color:red;display:none;"><i class="fa fa-fw fa-lg fa-exclamation-triangle"></i> Please enter your new password</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Re-type New Password</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="password" id="txtNewPwd2" name="txtNewPwd2" class="form-control" onchange="CheckMatchPwd();" onkeyup="CheckMatchPwd();" style="width:250px;"/>    
<!--                                                </td>-->
<!--                                                <td>-->
                                                    <span id="error_PwdNotMatch" style="color:red;display:none;"><i class="fa fa-fw fa-lg fa-exclamation-triangle"></i> Passwords do not match</span>
                                                </td>
                                            </tr>
                                        </tbody>                                       
                                    </table>
                                </div>
                            </div>
                        </div>
                    </article>                   
                </form>
            </div>
        </article>
                                                
        <div>
            <div class="row">
                <div class="col-sm-12">
                    <div align="center" class="padding-5" >
                        <input type="button" Id="btnSave" class="btn btn-default bg-color-blueDark txt-color-white" value="Save Changes"/>
<!--                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" onclick="location.href = '#/UserList'" />-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<script type="text/javascript">
    
    pageSetUp();     
    
    $("#btnSave").click(function() {
        $("#error_CurrentPwdRequired, #error_CurrentPwdWrong, #error_PwdNotMatch, #error_NewPwdRequired").hide();
        
        var bRequired = true;
        if ($("#txtCurrentPwd").val() === "") {
            $('#error_CurrentPwdRequired').show();   
            bRequired = false;
        } 
        else if ($("#txtNewPwd").val() === "") {
            $('#error_NewPwdRequired').show();   
            bRequired = false;
        }
               
        if (bRequired) {
            var bMatchPwd = CheckMatchPwd();
            if (bMatchPwd) {
                UpdatePassword();
            }
        }
    });
    
    function CheckMatchPwd() {
        $("#error_NewPwdRequired").hide();
        if ($("#txtNewPwd").val() !== $("#txtNewPwd2").val()) {
            $('#error_PwdNotMatch').show();        
            return false;
        } else {
            $('#error_PwdNotMatch').hide();
            return true;
        }
    }
 
    $("#formChangePwd").validate({
        rules : {
            txtNewPwd2 : {
                required : true,
                //minlength : 3,
                //maxlength : 15,
                equalTo : '#txtNewPwd'
            }
        },
        submitHandler : function(form) {
            //check if old password is same                                            
        },
        errorPlacement : function(error, element) {
            //error.insertAfter(element.parent());
            return true;
        }
    });
    
    function UpdatePassword() {
        
        if ($("#txtCurrentPwd").val() !== '') {
            var request = $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/Servlet_User?SFC=UPDATE_PASSWORD",
                data: { 
                    CURRENT_PWD: $('#txtCurrentPwd').val(),
                    NEW_PWD: $("#txtNewPwd").val()
                },
                dataType: 'json'
            });               
            request.done(function (response) {
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Password Updated",
                        content: "",
                        timeout: 6000
                    });
                   // location.href = "#/UserList"; 
                } else {
                    if (response.msg !== "") {
                        //$("#error_CurrentPwdWrong").show();
                        $.bigBoxFail({
                            title: "Your current password was incorrect",
                            content: "Please enter the correct password.",
                            timeout: 6000
                        });
                    } else {
                        $.bigBoxFail({
                            title: "Change Password FAIL.",
                            content: "There is some error during password update.<br> Please try again...",
                            timeout: 6000
                        });
                    }   
                }
            });
        } else { 
            $('#error_CurrentPwdRequired').show();    
        }
    }
           
</script>
