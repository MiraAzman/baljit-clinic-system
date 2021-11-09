<!--
Modification ID     By      Date        Comment
--------------------------------------------------------------------------------
yesno01             Aaron   07Dec2018   include yes-no.jsp in the code
c01                 Aaron   07Dec2018   add confirmation box and loading status when user try to create a new user
c02                 Aaron   12Dec2018   add createNew function to be called by Add()
font01              Aaron   20Dec2018   change font style and color
len01               Aaron   20Dec2018   set maximum length for a textbox
re01                Aaron   02Jan2019   comment out calling pageSetUp function to make the show error works
email01             Aaron   11Jan2019   add validation for email address
-->

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
    <!--<span>{{params}}</span>-->
    <input type="hidden" value={{params}} id="hidHospCode">

    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-file fa-2x"></i> 
            User Info Setup                                         
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
                <form id="form_AddUser" name="form_AddUser" method="post">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Information</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbUserInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="12%"><font color="red">*</font> <b>User Code</b></td> <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="30%"> 
                                                    <input type="text" id="txtCode" name="txtCode" required class="form-control" rel="popover-hover" data-original-title="User Code" data-content="A User Code is a unique mixture of alphanumerical code with a maximum length of 20 characters." maxlength="20"/> <!--len01-->   
                                                </td>
                                                <td width="12%">Contact No.</td>
                                                <td width="1%">:</td>
                                                <td width="70%">       
                                                    <input type="text" id="txtContactNo" name="txtContactNo"  class="form-control" maxlength="20"/> <!--len01-->    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><font color="red">*</font> <b>User Password</b></td> <!--font01-->
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtPwd" name="txtPwd"  class="form-control" maxlength="20"/> <!--len01-->    
                                                </td>
                                                <td>Email</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtEmail" name="txtEmail"  class="form-control" maxlength="200" placeholder="username@email.com"/> <!--len01--> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><font color="red">*</font> <b>User Name</b></td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtName" name="txtName" class="form-control" maxlength="100"/> <!--len01-->    
                                                </td>
                                                <td>Company Code</td>
                                                <td>:</td>
                                                <td>       
                                                    <label id="selectComp" class="searchbox">
                                                        <select class="form-control" id="ddlComp" name="ddlComp" rel="popover-hover" data-original-title="Company" data-content="Select Company." style="width:350px;">
                                                            <option value="">- Select Company -</option>                                        
                                                            <jstl:forEach var="ddl_Comp" items="${DDL.ddlGet('GET_COMP', '', '', sessionScope.SiteName)}">
                                                                <option value="${ddl_Comp.VALUE}">${ddl_Comp.VALUE} - ${ddl_Comp.TEXT}</option>
                                                            </jstl:forEach> 
                                                        </select>    
                                                    </label>      
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>First Name</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtFirstName" name="txtFirstName"  class="form-control" maxlength="50"/> <!--len01-->   
                                                </td>
                                                <td>Location Code</td>
                                                <td>:</td>
                                                <td>       
                                                    <label id="selectLoc" class="searchbox">
                                                        <select class="form-control" id="ddlLoc" name="ddlLoc" rel="popover-hover" data-original-title="Location" data-content="Select Location." style="width:350px;cursor:default;">
                                                            <option value="">- Select Location -</option>                                          
                                                        </select>    
                                                    </label>    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Last Name</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtLastName" name="txtLastName"  class="form-control" maxlength="50"/> <!--len01-->    
                                                </td>
                                                <td></td><td></td><td></td>
                                            </tr>
                                            
                                            <tr>
                                                <td>Role</td>
                                                <td>:</td>
                                                <td>       
                                                    <label id="selectRole" class="searchbox">
                                                        <select class="form-control" id="ddlRole" name="ddlRole" rel="popover-hover" data-original-title="Role" data-content="Select Role." style="width:350px;cursor:default;">
                                                            <option value="">- Select User Role -</option>                                          
                                                        </select>    
                                                    </label>    
                                                </td>
                                                
                                                <td></td><td></td><td></td>
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
                        <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Save" onclick= "Add();"/>
                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" onclick="location.href = '#/UserList'" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<!-- yesno01--><!-- Aaron include yes-no.jsp in the code-->
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">
    //re01
    //pageSetUp();
    
//    getDLL("ddlComp", "GET_COMP", "", "");
//    getDLL("ddlLoc", "GET_LOCATION", "", "");
    getDLL("ddlRole", "ROLE_SEARCH", "", "");

    function getDLL (ddl, method, param1, param2) {
        $.get('${pageContext.request.contextPath}/Servlet_PopulateData', {SFC: 'GET_DLL', METHOD: method, P1: param1, P2: param2}, function (data) {
            for(var i=0; i < data.length; i++){                                                          
                $("#"+ddl).append($("<option>").val(data[i].VALUE).html(data[i].TEXT));
            }     
        });     
    }         
        
            $("#ddlComp").change(function(){
                $('#ddlLoc').empty();
                var sCompany = this.value;   
        if (sCompany !== "") { 
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/Servlet_Stock?SFC=GET_REL_LOCATION",
                    data: {
                        COMPANY: sCompany
                    },
                    dataType: 'json',
                    success: function(data) {
                        $("select#ddlLoc").append( $("<option>").val("").html("- Select Location -")); 
                        for (var a=0 ; a<data.object1.length ; a++) {                   
                            var arrData = data.object1[a];                
                            $("select#ddlLoc").append( $("<option>")
                                .val(arrData.VALUE)
                            .html(arrData.VALUE + " - " + arrData.TEXT)
                            ); 
                        }
                    }
                });                                                           
                $("#ddlLoc").prop("disabled", false); 
        } else {
            $("select#ddlLoc").append( $("<option>").val("").html("- Select Location -"));
            $("#ddlLoc").prop("disabled", true);
        }
            });
            
    var pagefunction = function() {
        
        
        $().ready(function () {
            $(".numeric").numeric();  //re01
            $("#wid-id-GST").hide();  
            
//            $("#ddlLoc").prop("disabled", true);
        
//            $("#ddlComp").change(function(){
//                $('#ddlLoc').empty();
//
//                var sCompany = this.value;   
//                $.ajax({
//                    type: "GET",
//                    url: "${pageContext.request.contextPath}/Servlet_Stock?SFC=GET_REL_LOCATION",
//                    data: {
//                        COMPANY: sCompany
//                    },
//                    dataType: 'json',
//                    success: function(data) {
//                        $("select#ddlLoc").append( $("<option>").val("").html("- Select Location -")); 
//
//                        for (var a=0 ; a<data.object1.length ; a++) {                   
//                            var arrData = data.object1[a];                
//                            $("select#ddlLoc").append( $("<option>")
//                                .val(arrData.VALUE)
//                                .html(arrData.VALUE)
//                            ); 
//                        }
//                    }
//                    //error: function(){ alert('error'); }
//                });                                                           
//                $("#ddlLoc").prop("disabled", false); 
//            });
            
            var container = $('div.errorContainer');
            var validator = $("#form_AddUser").validate({
                rules: {
                    txtCode: "required",
                    txtName: "required",
                    txtPwd: "required"
                },
                messages: {
                    txtCode: "User Code cannot be blank.",
                    txtName: "User Name cannot be blank.",
                    txtPwd: "User Password cannot be blank."
                },
                //onfocusout: false,   //re01
                //onkeyup: false,     //re01
                errorContainer: container,
                errorLabelContainer: $("ol", container),
                wrapper: 'li'
            });  //end of validate
            
        }); 
    }; 
    loadScript("js/jquery.numeric.js", pagefunction);   //re01
    
    
    function Add(){
        var $this = $(this);
        var $validItem = $("#form_AddUser").valid();
        var $validEmail = validEmail($("#txtEmail").val());
        if ($validItem === true && $validEmail === true) {
            document.getElementById("btnSave").disabled = true;
            //c01
            //Aaron
            //add confirmation box and loading status when user try to create a new user
            showYesNo({
                title: "Confirmation needed",
                width: 420,
                noClose: true,
                isModal: true,
                body: [
                    "<br><h4>Please confirm all the details entered.<h4><br>"
                ],
                show: function(){},
                Yes: {
                    text: "Yes",
                    opt: function(){
                        createNew(); //c02
                        hideYesNo();
                    }
                },
                No:{
                    text: "No",
                    opt: function(){
                        document.getElementById("btnSave").disabled = false;
                        hideYesNo();
                    }
                }
            });
        } 
        //email01
        else if ($validEmail === false){
            $.bigBoxFail({
                title: "INVALID Email.",
                content: "Please enter a valid email address and try again...",
                timeout: 6000
            });
        }
    }            
            //c01
            //Aaron
            
    //c02
    //Aaron
    function createNew(){
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/Servlet_User?SFC=UPDATE_USER",
            data: { 
                FUNCTION: 'ADD',
                CODE: $('#txtCode').val(),
                NAME: $('#txtName').val(),
                PWD: $('#txtPwd').val(),
                FIRST_NAME: $('#txtFirstName').val(),
                LAST_NAME: $('#txtLastName').val(),
                CONTACT_NO: $('#txtContactNo').val(),
                EMAIL: $('#txtEmail').val(),
                COMPANY: $('#ddlComp').val(),
                LOCATION: $("#ddlLoc").val(),  
                ROLE: $("#ddlRole").val()
            },
            dataType: 'json',
            beforeSend: function(xhr){
                $.showLoadingNoStatus();
            },
            success: function(response,status,xhr){
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Create User SUCCESS.",
                        content: "User creation SUCCESS.",
                        timeout: 6000
                    });
                        //location.href = "#/UserList"; 
                } 
                else {
                    if (response.msg === 'DUPLICATE_USR_CODE'){
                        $.bigBoxFail({
                            title: "Create User FAIL.",
                            content: "Error : User Code entered is already exist.<br> Please try again...",
                            timeout: 6000
                        });
                    } 
                    else {                      
                        $.bigBoxFail({
                            title: "Create User FAIL.",
                            content: "There is some error during item creation.<br> Please try again...",
                            timeout: 6000
                        });
                    }
                }  
            },
            error: function (xhr, status, error) {
                $.bigBoxFail({
                    title: "Transaction ERROR",
                    content: "There is some error occur during data transfer. Please try again later",
                    timeout: 6000
                 });
            },
            complete: function (xhr, status) {
                if (xhr.status === 200) {
                    $.hideLoadingNoStatus(function () {
                       window.location.href = "#/UserList"; 
                    }, 500);
                } else {
                    $.hideLoadingNoStatus(function () {
                    }, 0);
                }
            }
        });
    }
    //c02
    //Aaron
            
//            var request = $.ajax({
//                    type: "POST",
//                    url: "${pageContext.request.contextPath}/Servlet_User?SFC=UPDATE_USER",
//                    data: { 
//                        FUNCTION: 'ADD',
//                        CODE: $('#txtCode').val(),
//                        NAME: $('#txtName').val(),
//                        PWD: $('#txtPwd').val(),
//                        FIRST_NAME: $('#txtFirstName').val(),
//                        LAST_NAME: $('#txtLastName').val(),
//                        CONTACT_NO: $('#txtContactNo').val(),
//                        EMAIL: $('#txtEmail').val(),
//                        COMPANY: $('#ddlComp').val(),
//                        LOCATION: $("#ddlLoc").val(),  
//                        ROLE: $("#ddlRole").val()
//                    },
//                    dataType: 'json'
//                    //success: function() {alert("success");},
//                    //error: function() {alert("failed");}
//            });               
//            request.done(function (response) {
//                if (response.bool === true) {
//                    $.bigBoxSuccess({
//                        title: "Create User SUCCESS.",
//                        content: "User creation SUCCESS.",
//                        timeout: 6000
//                    });
//                    location.href = "#/UserList"; 
//                } else {
//                    if (response.msg === 'DUPLICATE_USR_CODE'){
//                        $.bigBoxFail({
//                            title: "Create User FAIL.",
//                            content: "Error : User Code entered is already exist.<br> Please try again...",
//                            timeout: 6000
//                        });
//                    } else {                      
//                        $.bigBoxFail({
//                            title: "Create User FAIL.",
//                            content: "There is some error during item creation.<br> Please try again...",
//                            timeout: 6000
//                        });
//                    }
//                }  
//            });
//        } 
//    }
    //email01
    function validEmail(email){
        var reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if (email === ""){
            return true;
        }
        else{
            return reg.test(email);
        }
    }
    pagefunction();
        
</script>
