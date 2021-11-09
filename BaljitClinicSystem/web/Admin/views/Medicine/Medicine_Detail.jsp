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
    select.error { border: 1px solid #A94444; background-color:#FFF0F0; }
    textarea.error { border: 1px solid #A94444; background-color:#FFF0F0; }
</style>
<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />
<section id="widget-grid" class="">
    <input type="hidden" value={{params}} id="hidHospCode">

    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-medkit fa-2x"></i> 
            Medicine Inventory Details                                        
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
                <form id="form_Corporate" name="form_Corporate" method="post">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Medicine Information</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbUserInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="12%"><font color="red">*</font> <b>Medicine Name</b></td>
                                                <td width="1%">:</td>
                                                <td width="37%"> 
                                                    <input type="text" id="txtName" name="txtName" class="form-control" maxlength="100"/>   
                                                </td>
                                                <td width="12%">Batch No.</td>
                                                <td width="1%">:</td>
                                                <td width="37%">       
                                                    <input type="text" id="txtBatchNo" name="txtBatchNo" class="form-control" maxlength="10"/>   
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Unit of Measurement</td>
                                                <td>:</td>
                                                <td> 
                                                    <select class="form-control" id="ddlUOM" name="ddlUOM" style="width:250px;">
                                                        <option value="">- Select Unit of Measurement -</option>                         
                                                        <jstl:forEach var="ddl_UOM" items="${DDL.ddlGet('GET_CODEDESC','UOM','',sessionScope.SiteName)}">
                                                            <option value="${ddl_UOM.VALUE}">${ddl_UOM.TEXT}</option>
                                                        </jstl:forEach>  
                                                    </select>
                                                </td>
                                                <td>Expiry Date</td>
                                                <td>:</td>
                                                <td> 
                                                    <input type="text" id="txtExpiryDate" name="txtExpiryDate" class="searchbox-date" style="width:250px;"/> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Unit Cost</td>
                                                <td>:</td>
                                                <td> 
                                                    <div style="float:left;">RM&nbsp;</div><input type="number" id="txtUnitCost" name="txtUnitCost" class="form-control" style="width:100px;"/>
                                                </td>
                                                <td>Qty</td>
                                                <td>:</td>
                                                <td>       
                                                    <input type="number" id="txtQty" name="txtQty" class="form-control" style="width:100px;"/>     
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Price</td>
                                                <td>:</td>
                                                <td> 
                                                    <div style="float:left;">RM&nbsp;</div><input type="number" id="txtPrice" name="txtPrice" class="form-control" style="width:100px;"/> 
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
    </div>
                                                
    <div>
        <div class="row">
            <div class="col-sm-12">
                <div align="center" class="padding-5" >
                    <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Save" onclick= "SaveDetail();" style="margin-right:20px;"/>
                    <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white" value="Cancel" onclick="location.href = '#/MedicineList'" />
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<!-- yesno01--><!-- Aaron include yes-no.jsp to the code-->
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">     
    
    var Medicine_Index = "";
    
    function bindData(sParam) {
        $(document).ready(function() {

            Medicine_Index = sParam.md_id;     
            var request = $.ajax({
                type:'POST',
                url:"${pageContext.request.contextPath}/Servlet_Medicine",
                data:  {
                    SFC: 'GET_MEDICINE_DETAIL', 
                    MEDICINE_ID: Medicine_Index                  
                },
                dataType: 'json',
                success: function(data) {               
                    var arrData = data.object1[0];

                    $('#txtName').val(arrData.md_name);
                    $('#txtBatchNo').val(arrData.md_batchno);
                    $('#ddlUOM').val(arrData.md_uom);
                    $('#txtExpiryDate').val(arrData.md_expirydate);
                    $('#txtUnitCost').val(arrData.md_unitcost);
                    $('#txtQty').val(arrData.md_qty);
                    $('#txtPrice').val(arrData.md_price);

                    if (arrData.md_isactive === 'Y') {
                        $('#chkIsActive').prop('checked', true);   
                        $('#chkIsActive').val('Y');
                    } else {
                        $('#chkIsActive').prop('checked', false);  
                        $('#chkIsActive').val('N');
                    }
                }        
            });    
            
            $("#chkIsActive").click(function() {                
                if ($('#chkIsActive').is(":checked")) { 
                    $('#chkIsActive').val('Y');
                } else if ($('#chkIsActive').is(":unchecked")) {
                    $('#chkIsActive').val('N'); 
                }
            });
        }); 
    }
    
    //validate01
    var pagefunction = function() {
            
            var container = $('div.errorContainer');    
    }; 
    
    function SaveDetail(){

        document.getElementById("btnSave").disabled = true;
        showYesNo({
            title: "Confirmation needed",
            width: 420,
            noClose: true,
            isModal: true,
            body: [
            "<br><h4>Are you confirm to proceed this action?<h4><br>"
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
        var $this = $(this);
        $.ajax({
            type:'POST',
            url:"${pageContext.request.contextPath}/Servlet_Medicine",
            data:  {
                SFC: 'UPDATE_MEDICINE',
                METHOD: "UPDATE",
                INDEX: Medicine_Index,
                NAME: $('#txtName').val(),
                BATCH_NO: $('#txtBatchNo').val(),
                UOM: $('#ddlUOM').val(),
                EXPIRY_DATE: $('#txtExpiryDate').val(),
                UNIT_COST: $('#txtUnitCost').val(),
                QTY: $('#txtQty').val(),
                PRICE: $('#txtPrice').val(),
                IS_ACTIVE: $('#chkIsActive').val()
            },
            dataType: 'json',
            beforeSend: function(xhr){
                $.showLoadingNoStatus();
            },
            success: function(response,status,xhr) {
                if (response.bool === true){
                    $.bigBoxSuccess({
                        title: "Saved Successfully.",
                        content: "",
                        timeout: 6000
                    });
                }
                else{
                    $.bigBoxFail({
                        title: "Update FAIL.",
                        content: "There is some error when updating the details.PLease try again later",
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
                       window.location.href = "#/MedicineList"; 
                    }, 500);
                } else {
                    $.hideLoadingNoStatus(function () {
                    }, 0);
                }
            }                             
        });
    }
    
    pagefunction();

</script>
