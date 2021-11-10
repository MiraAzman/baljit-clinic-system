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
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-dollar fa-2x"></i> 
            Billing                                        
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
                <form id="form_AddMedicine" name="form_AddMedicine" method="post">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Billing Information</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbUserInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="12%">Patient Name</td>
                                                <td width="1%">:</td>
                                                <td width="37%"> 
                                                    <input type="text" id="lblName" name="lblName" class="tboxreadonly" readonly/>
                                                </td>
                                                <td width="12%">Grand Total</td>
                                                <td width="1%">:</td>
                                                <td width="37%">       
                                                    <input type="text" id="lblGrandTotal" name="lblGrandTotal" class="tboxreadonly" readonly/>  
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Payment Type</td>
                                                <td>:</td>
                                                <td> 
                                                    <select class="form-control" id="ddlPaymentType" name="ddlPaymentType" style="width:250px;">
                                                        <option value="">- Select Payment Type -</option>                         
                                                            <option value="CASH">CASH</option>
                                                            <option value="PANEL COMPANY">PANEL COMPANY</option>
                                                    </select>
                                                </td>
                                                <td></td>
                                                <td></td>
                                                <td> 
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
                        <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Complete Billing" onclick= "Add();" style="margin-right:20px;"/>
                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" onclick="location.href = '#/QueueList'" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">
    var Queue_ID = "";
    function bindData(sParam) { 
         
        Queue_ID = sParam.qu_id;

        $.get('${pageContext.request.contextPath}/Servlet_Queue', 
        {
            QUEUE_ID: Queue_ID, 
            SFC: 'GET_BILLING_DETAIL'
        }, 
        function (data) {
            var arrData = data.object1[0];

            $('#lblName').val(arrData.pt_name);
            $('#lblGrandTotal').val("RM " + arrData.bg_grandTotal);
                     
            //$('#txtHealthHistory').val(arrData.pt_healthhistory);
            //$('#txtAllergyNotes').val(arrData.pt_allergynotes);
            
        });
    }
   
    
    function Add(){
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
    }            

    function createNew(){
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/Servlet_Queue?SFC=UPDATE_BILLING",
            data: { 
                QUEUE_ID: Queue_ID,
                PAYMENT_TYPE: $('#ddlPaymentType').val()
            },
            dataType: 'json',
            beforeSend: function(xhr){
                $.showLoadingNoStatus();
            },
            success: function(response,status,xhr){
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Billing Completed.",
                        content: "",
                        timeout: 6000
                    });
                } 
                else {                     
                    $.bigBoxFail({
                        title: "Billing FAIL.",
                        content: "",
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
                       window.location.href = "#/QueueList"; 
                    }, 500);
                } else {
                    $.hideLoadingNoStatus(function () {
                    }, 0);
                }
            }
        });
    }
        
</script>
