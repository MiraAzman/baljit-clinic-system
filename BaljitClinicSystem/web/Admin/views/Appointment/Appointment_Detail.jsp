<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="DDL" scope="page" class="BusinessLogic.Servlet_PopulateData" />
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
    select:disabled{
        background: #dddddd;
    }
    li{
        list-style:none;
    }
    .disabledTab{
        pointer-events: none;
    }
    input[type="text"].error { border: 1px solid #A94444; background-color:#FFF0F0; }
    select.error { border: 1px solid #A94444; background-color:#FFF0F0; }
    textarea.error { border: 1px solid #A94444; background-color:#FFF0F0; }
    input[type="text"]:read-only {box-shadow: none;}
    textarea:read-only {box-shadow: none;}
</style>
<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />
<section id="widget-grid" class="">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-users fa-2x"></i> 
            Appointment Details                                     
        </h1>
    </div>
    <div class="widget-body row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row">
                <form id="form_Appointment" name="form_Appointment">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Appointment Info</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbProductInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="12%">Patient Name</td> 
                                                <td width="1%">:</td>
                                                <td width="37%"> 
                                                    <input type="hidden" id="hdnAppointmentID" name="hdnAppointmentID"/>
                                                    <input type="text" id="lblPatient" name="lblPatient" readonly class="tboxreadonly"/>
                                                    <select class="form-control" id="ddlPatient" name="ddlPatient" style="width:350px;display:none;">
                                                        <option value="">- Select Patient -</option>                         
                                                        <jstl:forEach var="ddl_Patient" items="${DDL.ddlGet('GET_PATIENT','','',sessionScope.SiteName)}">
                                                            <option value="${ddl_Patient.VALUE}">${ddl_Patient.TEXT}</option>
                                                        </jstl:forEach>  
                                                    </select> 
                                                </td>
                                                <td width="12%">Doctor Name</td>
                                                <td width="1%">:</td>
                                                <td width="37%"> 
                                                    <input type="text" id="lblDoctor" name="lblDoctor" readonly class="tboxreadonly"/>
                                                    <select class="form-control" id="ddlDoctor" name="ddlDoctor" style="width:350px;display:none;">
                                                        <option value="">- Select Doctor -</option>                         
                                                        <jstl:forEach var="ddl_Doctor" items="${DDL.ddlGet('GET_DOCTOR','','',sessionScope.SiteName)}">
                                                            <option value="${ddl_Doctor.VALUE}">${ddl_Doctor.TEXT}</option>
                                                        </jstl:forEach>  
                                                    </select>  
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Appointment Date</td>
                                                <td>:</td>
                                                <td>     
                                                    <input type="text" id="lblDate" name="lblDate" readonly class="tboxreadonly"/>
                                                    <input type="text" id="txtDate" name="txtDate" class="searchbox-date" style="width:250px;display:none;"/> 
                                                </td>
                                                <td>Start Time</td>
                                                <td>:</td>
                                                <td>  
                                                    <input type="text" id="lblStartTime" name="lblStartTime" readonly class="tboxreadonly"/>
                                                    <select class="form-control" id="ddlStartTime" name="ddlStartTime" style="width:200px;display:none;">
                                                        <option value="">- Select Start Time -</option>                         
                                                        <jstl:forEach var="ddl_StartTime" items="${DDL.ddlGet('GET_CODEDESC','TIME','',sessionScope.SiteName)}">
                                                            <option value="${ddl_StartTime.VALUE}">${ddl_StartTime.TEXT}</option>
                                                        </jstl:forEach> 
                                                    </select>    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Description</td>
                                                <td>:</td>
                                                <td>     
                                                    <input type="text" id="lblDescription" name="lblDescription" readonly class="tboxreadonly"/>
                                                    <input type="text" id="txtDescription" name="txtDescription" class="form-control" style="display:none;"/>
                                                </td>
                                                <td>End Time</td>
                                                <td>:</td>
                                                <td>
                                                    <input type="text" id="lblEndTime" name="lblEndTime" readonly class="tboxreadonly"/>
                                                    <select class="form-control" id="ddlEndTime" name="ddlEndTime" style="width:200px;display:none">
                                                        <option value="">- Select End Time -</option>                         
                                                        <jstl:forEach var="ddl_EndTime" items="${DDL.ddlGet('GET_CODEDESC','TIME','',sessionScope.SiteName)}">
                                                            <option value="${ddl_EndTime.VALUE}">${ddl_EndTime.TEXT}</option>
                                                        </jstl:forEach>  
                                                    </select> 
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
                        <input type="button" id="btnEdit" class="btn btn-default bg-color-blueDark txt-color-white form-btn" name="btnEdit" value="Edit Detail" onclick="enableEdit()" style="margin-right:20px;"/>
                        <input type="button" id="btnSave" class="btn btn-default bg-color-blueDark txt-color-white" value="Update" style="display:none;margin-right:20px;" onclick="confirm();" />
                        <input type="button" id="btnCancel" class="btn btn-default bg-color-blueDark txt-color-white" value="Go Back" onclick="location.href = '#/AppointmentList'" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../../includes/loading-no-status.jsp"/>
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">

    function bindData(sParam) {
                   
        $.get('${pageContext.request.contextPath}/Servlet_Appointment', 
        {
            APPOINTMENT_ID: sParam.app_id, 
            SFC: 'GET_APPOINTMENT_DETAIL'
        }, 
        function (data) {
            var arrData = data.object1[0];

            $('#hdnAppointmentID').val(arrData.app_id);
            $('#lblPatient').val(arrData.pt_name);
            $('#ddlPatient').val(arrData.app_patientid);
            $('#lblDoctor').val(arrData.doc_name);
            $('#ddlDoctor').val(arrData.app_doctorid);
            $('#lblDate, #txtDate').val(arrData.app_date);
            $('#lblDescription, #txtDescription').val(arrData.app_description);    
            $('#lblStartTime, #ddlStartTime').val(arrData.app_starttime);   
            $('#lblEndTime, #ddlEndTime').val(arrData.app_endtime);   
        });
    }
    
    function enableEdit() {
        $.showLoadingNoStatus();
   
        document.getElementById('btnSave').style.display = '';
        document.getElementById('btnEdit').style.display = 'none';

        $('#lblPatient, #lblDoctor, #lblDate, #lblDescription, #lblStartTime, #lblEndTime').hide();
        
        $('#ddlPatient, #ddlDoctor, #txtDate, #txtDescription, #ddlStartTime, #ddlEndTime').show();
        
        $("#txtDate").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: "yy-mm-dd"
        });
        $("#txtDate").datepicker("option", "prevText", '<i class="fa fa-chevron-left"></i>');
        $("#txtDate").datepicker("option", "nextText", '<i class="fa fa-chevron-right"></i>');

        $.hideLoadingNoStatus();
    }

    function confirm(){
                   
        document.getElementById("btnSave").disabled = true;
        showYesNo({
            title: "Confirmation needed",
            width: 420,
            noClose: true,
            isModal: true,
            body: [
               "<br><h4>Are you sure to proceed this action?<h4><br>"
            ],
            show: function(){},
            Yes: {
                text: "Yes",
                opt: function(){
                   updateDetail();
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
    
    function updateDetail(){

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/Servlet_Appointment?SFC=UPDATE_APPOINTMENT",
            data: {
                APPOINTMENT_DATA : JSON.stringify($('#form_Appointment').serializeArray()),
                METHOD : 'UPDATE',
                APPOINTMENT_ID : $('#hdnAppointmentID').val()
            },
            dataType: 'json',
            beforeSend: function (xhr) {
                $.showLoadingNoStatus();
            },
            success: function(response, status, xhr) {
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Appointment Success Updated.",
                        content: "Appointment Success Updated.",
                        timeout: 6000
                    });
                }
                else{
                    $.bigBoxFail({
                        title: "Update Appointment FAIL.",
                        content: "There is some error during appointment update.<br> Please try again...",
                        timeout: 6000
                    });
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
                       location.reload();
                    }, 500);
                } else {
                    $.hideLoadingNoStatus(function () {
                    }, 0);
                }
            }
        });
    }

</script>