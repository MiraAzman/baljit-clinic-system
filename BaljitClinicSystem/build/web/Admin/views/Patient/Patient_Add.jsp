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
</style>
<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />
<section id="widget-grid" class="">
    <input type="hidden" id="lblUserCode" value="<%= session.getAttribute("usercode")%>"/> 
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-users fa-2x"></i> 
            New Patient Registration                                        
        </h1>
    </div>
    <div class="widget-body row">
        <form id="form_Patient" name="form_Patient">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row" style="padding-bottom:10px;padding-left:10px;padding-right:10px;">
                <div class="errorContainer alert alert-danger alert-block">
                    <h4 class="alert-heading">There were some field left out or invalid inputs like below:</h4>
                    <ol>
                    </ol>
                </div>
            </div>
            
            <div class="jarviswidget" id="wid-id-6"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" 
                data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false" style="float:left;width:100%;">
                
                <ul id="tabTemplate" class="nav nav-tabs bordered">
                    <li class='active'><a href='#tabGenInfo' data-toggle='tab' id='tab1'>General Information</a></li>
                    <li><a href='#tabMedDtl' data-toggle='tab' id='tab2'>Medical Details</a></li>
                    <li><a href='#tabBillDtl' data-toggle='tab' id='tab3'>Billing Details</a></li>
                </ul>
                
                <div id="tabContent" class="tab-content padding-10">
                    <div class="tab-pane fade in active" id="tabGenInfo">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-7" data-widget-editbutton="false" data-widget-custombutton="false"
                            data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <div style="text-align:center;"><span><h2 id='titleTemplate'>General Information</h2></span></div>
                            </header>                                
                            <!-- widget content -->
                            <div class="widget-body">
                                <table id="tb1" class="table table-bordered table-striped" style="clear:both;">
                                    <tbody>
                                        <tr>
                                            <td width="12%"><font color="red">*</font> <b>Patient Name</b></td> 
                                            <td width="1%">:</td>
                                            <td width="37%"> 
                                                <input type="text" id="txtName" name="txtName" class="form-control" maxlength="100"/> 
                                            </td>
                                            <td width="12%">Registration Date</td>
                                            <td width="1%">:</td>
                                            <td width="37%">       
                                                <input type="text" id="txtRegisterDate" name="txtRegisterDate" class="form-control" disabled/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><font color="red">*</font> <b>IC/Passport No.</b></td>
                                            <td>:</td>
                                            <td>     
                                                <input type="text" id="txtICNo" name="txtICNo" class="form-control" maxlength="50"/> 
                                            </td>
                                            <td>Date of Birth</td>
                                            <td>:</td>
                                            <td>  
                                                <input type="text" id="txtDOB" name="txtDOB" class="searchbox-date" style="width:250px;"/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Contact No.</td>
                                            <td>:</td>
                                            <td> 
                                                <input type="text" id="txtContactNo" name="txtContactNo" class="form-control" maxlength="50"/>
                                            </td>
                                            <td>Age</td>
                                            <td>:</td>
                                            <td>

                                            </td>
                                        </tr>   
                                        <tr>
                                            <td>Email</td>
                                            <td>:</td>
                                            <td> 
                                                <input type="text" id="txtEmail" name="txtEmail" class="form-control" maxlength="50"/>
                                            </td>
                                            <td>Gender</td>
                                            <td>:</td>
                                            <td>
                                                <select class="form-control" id="ddlGender" name="ddlGender" style="width:250px;">
                                                    <option value="">- Select Gender -</option>    
                                                    <option value="M">Male</option> 
                                                    <option value="F">Female</option> 
                                                </select>    
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td rowspan="2">Address</td>
                                            <td rowspan="2">:</td>
                                            <td rowspan="2"> 
                                                <textarea id="txtAddress" name="txtAddress" rows="5" style="width:100%;" maxlength="200"></textarea>
                                            </td>
                                            <td>Ethnic Group</td>
                                            <td>:</td>
                                            <td>
                                                <select class="form-control" id="ddlEthnicGroup" name="ddlEthnicGroup" style="width:250px;">
                                                    <option value="">- Select Ethnic Group -</option>                         
                                                    <jstl:forEach var="ddl_EthnicGroup" items="${DDL.ddlGet('GET_CODEDESC','ETHNIC','',sessionScope.SiteName)}">
                                                        <option value="${ddl_EthnicGroup.VALUE}">${ddl_EthnicGroup.TEXT}</option>
                                                    </jstl:forEach>  
                                                </select>
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td>Nationality</td>
                                            <td>:</td>
                                            <td>
                                                <select class="form-control" id="ddlNationality" name="ddlNationality" style="width:250px;">
                                                    <option value="">- Select Nationality -</option>        
                                                    <jstl:forEach var="ddl_Nationality" items="${DDL.ddlGet('GET_CODEDESC','NATION','',sessionScope.SiteName)}">
                                                        <option value="${ddl_Nationality.VALUE}">${ddl_Nationality.TEXT}</option>
                                                    </jstl:forEach>  
                                                </select>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- end widget content -->
                        </div>  
                    </div>
                            
                    <div class="tab-pane fade in" id="tabMedDtl">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-7" data-widget-editbutton="false" data-widget-custombutton="false"
                            data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <div style="text-align:center;"><span><h2 id='titleTemplate'>Medical Details</h2></span></div>
                            </header>                                
                            <!-- widget content -->
                            <div class="widget-body">
                                <table id="tb2" class="table table-bordered table-striped" style="clear:both;">
                                    <tbody>
                                        <tr>
                                            <td width="12%">Blood Group</td> 
                                            <td width="1%">:</td>
                                            <td width="37%"> 
                                                <select class="form-control" id="ddlBloodGroup" name="ddlBloodGroup" style="width:250px;">
                                                    <option value="">- Select Blood Group -</option>                         
                                                    <jstl:forEach var="ddl_BloodGroup" items="${DDL.ddlGet('GET_CODEDESC','BLD','',sessionScope.SiteName)}">
                                                        <option value="${ddl_BloodGroup.VALUE}">${ddl_BloodGroup.TEXT}</option>
                                                    </jstl:forEach>  
                                                </select>
                                            </td>
                                            <td width="12%">Smoking?</td>
                                            <td width="1%">:</td>
                                            <td width="37%">       
                                                <input type="checkbox" id="chkIsSmoking" name="chkIsSmoking" value="N"/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Height (cm)</td>
                                            <td>:</td>
                                            <td>     
                                                <input type="number" id="txtHeight" name="txtHeight" class="form-control" step="0.01" style="width:100px;"/>
                                            </td>
                                            <td>Alcohol?</td>
                                            <td>:</td>
                                            <td>  
                                                <input type="checkbox" id="chkIsAlcohol" name="chkIsAlcohol" value="N"/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Weight (kg)</td>
                                            <td>:</td>
                                            <td> 
                                                <input type="number" id="txtWeight" name="txtWeight" class="form-control" step="0.01" style="width:100px;"/>
                                            </td>
                                            <td>Currently Pregnant?</td>
                                            <td>:</td>
                                            <td>
                                                <input type="checkbox" id="chkIsPregnant" name="chkIsPregnant" value="N"/> 
                                            </td>
                                        </tr>   
                                        <tr>
                                            <td>Health History</td>
                                            <td>:</td>
                                            <td> 
                                                <textarea id="txtHealthHistory" name="txtHealthHistory" rows="10" style="width:100%;" maxlength="200"></textarea>
                                            </td>
                                            <td>Allergy Notes</td>
                                            <td>:</td>
                                            <td>
                                                <textarea id="txtAllergyNotes" name="txtAllergyNotes" rows="10" style="width:100%;" maxlength="200"></textarea>
                                            </td>
                                        </tr>  
                                    </tbody>
                                </table>
                            </div>
                            <!-- end widget content -->
                        </div>  
                    </div>
                            
                    <div class="tab-pane fade in" id="tabBillDtl">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-7"  data-widget-editbutton="false" data-widget-custombutton="false"
                            data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <div style="text-align:center;"><span><h2 id='titleTemplate'>Billing Details</h2></span></div>
                            </header>                                
                            <!-- widget content -->
                            <div class="widget-body">
                                <table id="tb3" class="table table-bordered table-striped" style="clear:both;">
                                    <tbody>
                                        <tr>
                                            <td width="12%">Panel Company</td> 
                                            <td width="1%">:</td>
                                            <td width="37%"> 
                                                <select class="form-control" id="ddlPanelCompany" name="ddlPanelCompany" style="width:300px;">
                                                    <option value="">- Select Panel Company -</option>                         
                                                    <jstl:forEach var="ddl_PanelCompany" items="${DDL.ddlGet('GET_CORPORATE','','',sessionScope.SiteName)}">
                                                        <option value="${ddl_PanelCompany.VALUE}">${ddl_PanelCompany.TEXT}</option>
                                                    </jstl:forEach>  
                                                </select>
                                            </td>
                                            <td width="12%">Employee Code</td>
                                            <td width="1%">:</td>
                                            <td width="37%">       
                                                <input type="text" id="txtEmployeeCode" name="txtEmployeeCode" class="form-control" maxlength="20"/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Employee Name</td>
                                            <td>:</td>
                                            <td>     
                                                <input type="text" id="txtEmployeeName" name="txtEmployeeName" class="form-control" maxlength="100"/> 
                                            </td>
                                            <td>Relationship</td>
                                            <td>:</td>
                                            <td>  
                                                <select class="form-control" id="ddlRelationship" name="ddlRelationship" style="width:250px;">
                                                    <option value="">- Select Relationship -</option>                         
                                                    <jstl:forEach var="ddl_Relationship" items="${DDL.ddlGet('GET_CODEDESC','REL','',sessionScope.SiteName)}">
                                                        <option value="${ddl_Relationship.VALUE}">${ddl_Relationship.TEXT}</option>
                                                    </jstl:forEach>  
                                                </select>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- end widget content -->
                        </div>  
                    </div>
                </div>
            </div>              
        </article>
        </form>
        <div>
            <div class="row">
                <div class="col-sm-12">
                    <div align="center" class="padding-5" >
                        <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Save" onclick ="confirm();" style="margin-right:20px;"/> 
                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" onclick="location.href = '#/PatientList'" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../../includes/loading-no-status.jsp"/>
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">

    $().ready(function () {
        
        $("#chkIsSmoking, #chkIsAlcohol, #chkIsPregnant").click(function(){                
            if ( $('#chkIsSmoking').is(":checked") ) { 
                $('#chkIsSmoking').val('Y');
            } else if ( $('#chkIsSmoking').is(":unchecked") )
                $('#chkIsSmoking').val('N'); {
            }
        
            if ( $('#chkIsAlcohol').is(":checked") ) { 
                $('#chkIsAlcohol').val('Y');
            } else if ( $('#chkIsAlcohol').is(":unchecked") )
                $('#chkIsAlcohol').val('N'); {
            }
        
            if ( $('#chkIsPregnant').is(":checked") ) { 
                $('#chkIsPregnant').val('Y');
            } else if ( $('#chkIsPregnant').is(":unchecked") )
                $('#chkIsPregnant').val('N'); {
            }
        });
        
        var tempDate = new Date(); 
        $("#txtRegisteredBy").val($("#lblUserCode").val());
            
        var todayDate = tempDate.getFullYear() + "-" + ("0" +(tempDate.getMonth()+1)).slice(-2) + "-" + ("0" + tempDate.getDate()).slice(-2); 
        
        $("#txtRegisterDate").val(todayDate);

        $("#txtDOB").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: "yy-mm-dd"
        });
                
        var fromDate = $.datepicker.formatDate('yy-mm-dd', new Date(tempDate.getFullYear(), tempDate.getMonth() - 4, tempDate.getDate()));

        //$("#txtDocDateTo").datepicker("option", "minDate", fromDate);
        $("#txtDOB").datepicker("option", "maxDate", tempDate);
        $("#txtDOB").datepicker("option", "prevText", '<i class="fa fa-chevron-left"></i>');
        $("#txtDOB").datepicker("option", "nextText", '<i class="fa fa-chevron-right"></i>');
            
        $(".numeric").numeric();
        var container = $('div.errorContainer');
    });
    //loadScript("js/jquery.numeric.js", pagefunction);

    function confirm(){

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
                    createNew();
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
    
    function createNew(){
        var $this = $(this);
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/Servlet_Patient?SFC=UPDATE_PATIENT",
            data: {
                METHOD: "INSERT",
                NAME: $('#txtName').val(),
                IC_NO: $('#txtICNo').val(),
                DOB: $('#txtDOB').val(),
                CONTACT_NO: $('#txtContactNo').val(),
                EMAIL: $('#txtEmail').val(),
                GENDER: $('#ddlGender').val(),
                ADDRESS: $('#txtAddress').val(),
                ETHNIC_GROUP: $('#ddlEthnicGroup').val(),
                NATIONALITY: $('#ddlNationality').val(),
                BLOOD_GROUP: $('#ddlBloodGroup').val(),        
                HEIGHT: $('#txtHeight').val(),            
                WEIGHT: $('#txtWeight').val(),           
                HEALTH_HISTORY: $('#txtHealthHistory').val(),
                ALLERGY_NOTES: $('#txtAllergyNotes').val(),
                PANEL_COMPANY: $('#ddlPanelCompany').val(),
                EMPLOYEE_CODE: $('#txtEmployeeCode').val(),
                EMPLOYEE_NAME: $('#txtEmployeeName').val(),
                RELATIONSHIP: $('#ddlRelationship').val(),
                IS_SMOKING: $('#chkIsSmoking').val(),
                IS_ALCOHOL: $('#chkIsAlcohol').val(),
                IS_PREGNANT: $('#chkIsPregnant').val()  
                //PATIENT_DATA : JSON.stringify($('#form_Patient').serializeArray())
            },
            dataType: 'json',
            beforeSend: function (xhr) {
                $.showLoadingNoStatus();
            },
            success: function(response, status, xhr) {
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Register Patient SUCCESS.",
                        content: "",
                        timeout: 6000
                    });
                }
                else{
                    $.bigBoxFail({
                        title: "Register Patient FAIL.",
                        content: "There is some error during patient registration.<br> Please try again...",
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
                       window.location.href = "#/PatientList";
                    }, 500);
                } else {
                    $.hideLoadingNoStatus(function () {
                    }, 0);
                }
            }
        });
    }

</script>
