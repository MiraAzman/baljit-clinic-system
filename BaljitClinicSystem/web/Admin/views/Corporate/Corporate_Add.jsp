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
            <i class="fa-fw fa fa-building fa-2x"></i> 
            Add New Panel Company                                         
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
                <form id="form_AddCorporate" name="form_AddCorporate" method="post">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Corporate Information</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbUserInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="12%"><font color="red">*</font> <b>Corporate Name</b></td>
                                                <td width="1%">:</td>
                                                <td width="37%"> 
                                                    <input type="text" id="txtName" name="txtName" class="form-control" maxlength="100"/>   
                                                </td>
                                                <td width="12%">Contact Person</td>
                                                <td width="1%">:</td>
                                                <td width="37%">       
                                                    <input type="text" id="txtContactPerson" name="txtContactPerson" class="form-control" maxlength="50"/>   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Email</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtEmail" name="txtEmail" class="form-control" maxlength="50"/>   
                                                </td>
                                                <td>Telephone No</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtTelNo" name="txtTelNo"  class="form-control" maxlength="50"/> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Website</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtWebsite" name="txtWebsite" class="form-control" maxlength="50"/> 
                                                </td>
                                                <td>Fax No</td>
                                                <td>:</td>
                                                <td>       
                                                    <input type="text" id="txtFaxNo" name="txtFaxNo" class="form-control" maxlength="50"/>     
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Address</td>
                                                <td>:</td>
                                                <td> 
                                                    <textarea id="txtAddress" name="txtAddress" rows="5" style="width:100%;" maxlength="200"></textarea> 
                                                </td>
                                                <td>Active?</td>
                                                <td>:</td>
                                                <td>       
                                                    <input type="checkbox" id="chkIsActive" name="chkIsActive" value="N"/>   
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
                        <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Save" onclick= "Add();" style="margin-right:20px;"/>
                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" onclick="location.href = '#/CorporateList'" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">
                          
    var pagefunction = function() {
        
        $().ready(function () {
            
            $("#chkIsActive").click(function() {                
                if ($('#chkIsActive').is(":checked")) { 
                    $('#chkIsActive').val('Y');
                } else if ($('#chkIsActive').is(":unchecked")) {
                    $('#chkIsActive').val('N'); 
                }
            });
            
            //$(".numeric").numeric();  
                      
            var container = $('div.errorContainer');
            var validator = $("#form_AddCorporate").validate({
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
                errorContainer: container,
                errorLabelContainer: $("ol", container),
                wrapper: 'li'
            });
            
        }); 
    }; 
    //loadScript("js/jquery.numeric.js", pagefunction);  
    
    
    function Add(){
        var $this = $(this);
        var $validItem = $("#form_AddCorporate").valid();
//        var $validEmail = validEmail($("#txtEmail").val());
//        if ($validItem === true && $validEmail === true) {
            document.getElementById("btnSave").disabled = true;

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
//        } 
//        else if ($validEmail === false){
//            $.bigBoxFail({
//                title: "INVALID Email.",
//                content: "Please enter a valid email address and try again...",
//                timeout: 6000
//            });
//        }
    }            

    function createNew(){
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/Servlet_Corporate?SFC=UPDATE_CORPORATE",
            data: { 
                METHOD: "INSERT",
                NAME: $('#txtName').val(),
                EMAIL: $('#txtEmail').val(),
                WEBSITE: $('#txtWebsite').val(),
                ADDRESS: $('#txtAddress').val(),
                CONTACT_PERSON: $('#txtContactPerson').val(),
                TEL_NO: $('#txtTelNo').val(),
                FAX_NO: $('#txtFaxNo').val(),
                IS_ACTIVE: $('#chkIsActive').val()
            },
            dataType: 'json',
            beforeSend: function(xhr){
                $.showLoadingNoStatus();
            },
            success: function(response,status,xhr){
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Create Corporate SUCCESS.",
                        content: "Corporate creation SUCCESS.",
                        timeout: 6000
                    });
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
                       window.location.href = "#/CorporateList"; 
                    }, 500);
                } else {
                    $.hideLoadingNoStatus(function () {
                    }, 0);
                }
            }
        });
    }

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
