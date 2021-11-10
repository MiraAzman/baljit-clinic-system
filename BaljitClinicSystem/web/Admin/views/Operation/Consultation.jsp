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
    input[type="text"].error { border: 1px solid #A94444; background-color:#FFF0F0; }
    select.error { border: 1px solid #A94444; background-color:#FFF0F0; }
    textarea.error { border: 1px solid #A94444; background-color:#FFF0F0; }
    .textbox-date{
        background: url("../img/calander.png") right no-repeat;
        background-size: 28px 28px;
        background-color: white;
        border: 1px solid #999; 
        outline:0; 
        padding-right: 20px;
        min-width: 80px;
        cursor: pointer;
    }
</style>

<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />

<section id="widget-grid" class="">
    <!--<input type="text" id="lblUserCode" value="<%= session.getAttribute("s_usercode")%>"  class="tboxreadonlyShort"/>-->
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-user-md fa-2x"></i> 
            Consultation
            <input type="hidden" id="ControlDateTime" value="DT" />
        </h1>
    </div>
    <div class="row">
        <form id='form_AdjAdd'>
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-2"  data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-user"></i></span>
                    <span><h2>&nbsp;Patient Information</h2></span>
                </header>
                <div class="widget-body">
                    <table id="tb1" class="table table-bordered table-striped" style="clear:both;">
                        <tbody>
                            <tr>
                                <td width="12%">Patient Name</td> 
                                <td width="1%">:</td>
                                <td width="37%"> 
                                    <input type="text" id="lblName" name="lblName" class="tboxreadonly" readonly/>
                                </td>
                                <td width="12%">Patient IC</td>
                                <td width="1%">:</td>
                                <td width="37%">       
                                    <input type="text" id="lblICNo" name="lblICNo" class="tboxreadonly" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <td>Consultation Note</td>
                                <td>:</td>
                                <td colspan="4">     
                                    <textarea id="txtConsultationNotes" name="txtConsultationNotes" rows="10" style="width:100%;" maxlength="200"></textarea> 
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
                                                           
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">              
                <header>
                    <span class="widget-icon"> <i class="fa fa-medkit"></i></span>
                    <span><h2>&nbsp;Prescription Notes</h2></span>
                </header>                
                <div>
                    <div style="padding-bottom:10px;">                                                                              
                        <input type="button" Id="btnAddProduct" onclick="AddProduct();" class="btn btn-default bg-color-blueDark txt-color-white" value="Add Prescription" />                       
                    </div>
                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->                        
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body">                                
                        <br>
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <h2>Selected Medicine</h2>
                            </header>
                            <div class="container">
                                <div class="row">
                                    <div id="cjqgridSubmitDetail" class="jqgrid-table-nopadding">
                                        <table id="jqgridSubmitDetail" class="table table-striped" ></table>
                                        <!-- <div id="sourceDetail" style="padding-bottom:10px;padding-left:10px;">                                                                              
                                            <input type="button" Id="btnAddSelected" onclick="AddSelectedItems();" class="btn btn-default bg-color-blueDark txt-color-white" value="Add Selected Items" />                                                                                                                                                                                               
                                        </div> -->
                                        <div class="table-responsive">                                        
                                            <div id="gridItemSummary" class="">                              
                                                <table class="table table-striped" id="tbItem" >
                                                    <thead>                                                                                                          
                                                        <th id="lblRemove"> </th>  
                                                        <th id="lblPrdCode">Medicine Name</th>
                                                        <th id="lblPrdCat">Unit Cost</th>
                                                        <th id="lblPrdGrp">Unit Price</th>
                                                        <th id="lblPrdType">Expiry Date</th>
                                                        <th id="lblBatchNo">Qty To Prescribe</th>
                                                        <th id="lblExpiryDate">Total Price</th>
                                                        <th id="idx"></th>  
                                                    </thead>
                                                    <tbody id="ItemGrid" >
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div>
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <!-- <div align="left" class="padding-5" >                                          
                                                            <input type="button" Id="btnDeleteAll"  class="btn btn-default bg-color-blueDark txt-color-white" value="Delete All" style=" width: 80px;" onclick='DeleteAllRows()' />                                          
                                                        </div> -->                                 
                                                        <div align="Center" class="padding-10">                                           
                                                            <input type="button" Id="btnConfirm"  class="btn btn-default bg-color-blueDark txt-color-white" value="Complete Consultation" style="margin-right:20px;" onclick="confirm();" />
                                                            <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white" value="Cancel" style=" width:80px;" onclick="location.href = '#/QueueList'" />
                                                        </div>                                      
                                                    </div>
                                                </div> 
                                            </div>    
                                        </div>
                                    </div>
                                </div>                               
                            </div>
                        </div>                                 
                    </div>
                    <!-- end widget content -->
                </div>
            </div>                  
        </article>                                                
        <div hidden>            
            <input type="hidden" id="hidPrescriptionItems" name="hidPrescriptionItems"/>
        </div>
        </form>                             
    </div>
</section>                                                   
<jsp:include page="../../../includes/loading-no-status.jsp"/>  
<jsp:include page="../../../includes/PopUpInitPage.jsp"/>
<jsp:include page="../../../includes/yes-no.jsp"/>
<script src="js/buttonset.js"></script>
<script type="text/javascript">
   
   var CurrentAllocation = {};
   var LocationFirstTimeRefreshed = false;
   var CurrLocationGrid = {};
   var TotalAllocation = 0;
   var Queue_ID = "";
   var Patient_ID = "";
   
    pageSetUp();
    $('#rdPrdCat').buttonset();
    
    function bindData(sParam) {
         
        Queue_ID = sParam.qu_id;
        Patient_ID = sParam.pt_id; 
        
        $.get('${pageContext.request.contextPath}/Servlet_Patient', 
        {
            PATIENT_ID: Patient_ID, 
            SFC: 'GET_PATIENT_DETAIL'
        }, 
        function (data) {
            var arrData = data.object1[0];

            $('#lblName').val(arrData.pt_name);
            $('#lblICNo').val(arrData.pt_icno);
                     
            //$('#txtHealthHistory').val(arrData.pt_healthhistory);
            //$('#txtAllergyNotes').val(arrData.pt_allergynotes);
            
        });
    }

    pageSetUp();
   
    function AddProduct() {      
        showMedicine({width: 800, height: 600}).done(function (rowIn) {

            //alert(JSON.stringify(rowIn));           
            $("#tbItem tbody").append("<tr id=tr" + curRow + ">" +               
                "<td><a style='cursor:pointer;' onclick='showRemovePopup("+curRow+")'><i class='fa fa-fw fa-lg fa-trash-o'/></a></td>" +
                "<td><input type='text' class='form-control' readonly ID='txtName" + curRow + "' name='txtName" + curRow + "' style='width:250px' /></td>" +               
                "<td><input type='text' class='form-control' readonly ID='txtUnitCost" + curRow + "' name='txtUnitCost" + curRow + "' style='width:100px' /></td>" +
                "<td><input type='text' class='form-control' readonly ID='txtPrice" + curRow + "' name='txtPrice" + curRow + "' style='width:100px' /></td>" +
                "<td><input type='text' class='form-control' readonly ID='txtExpiryDate" + curRow + "' name='txtExpiryDate" + curRow + "' style='width:100px' /></td>" +
                "<td><input type='text' class='form-control' ID='txtQty" + curRow + "' name='txtQty" + curRow + "' style='width:100px' /></td>" +
                "<td><input type='text' class='form-control' readonly ID='txtTotalPrice" + curRow + "' name='txtTotalPrice" + curRow + "' style='width:80px' value='0.00' /></td>" +               
                "<td><input type='hidden' class='form-control'ID='hidIdx" + curRow + "' name='hidIdx' value='' /></td>" +    
                "</tr>"
            );                
            
            $("#hidIdx"+ curRow).val(rowIn.md_id); 
            $("#txtName"+ curRow).val(rowIn.md_name);
            $("#txtUnitCost"+ curRow).val(rowIn.md_unitcost);
            $("#txtPrice"+ curRow).val(rowIn.md_price);
            $("#txtExpiryDate"+ curRow).val(rowIn.md_expirydate);   
            $("#txtQty"+curRow).keyup(function(){                    
                RecalcTotalPrice(this.id.substring(6));
            });
            
            curRow = curRow + 1; 
        });
    }
    
    function RecalcTotalPrice(rowId) { 
        var qty = $("#txtQty"+rowId).val(); 
        var price = $("#txtPrice"+rowId).val(); 

        $("#txtTotalPrice"+ rowId).val(qty*price); 
    }

    
    var curRow = 0;

    function showRemovePopup(rowId)
    {
        showYesNo({
            title: "Are you sure to remove the particular item?",
            width: 520,
            _HtmlBody:
                "<table class='selection-criteria' style='width:100%' >" +
                "<tr><td align='center'>" +
                "<button style='width:180px' class='btn btn-default bg-color-blueDark txt-color-white' onclick='DeleteRow("+rowId+")';>Yes</button>" +
                "</td><td align='center'>" +
                "<input type='button' Id='btnCloseDelete' class='btn btn-default bg-color-blueDark txt-color-white' value='No' style=' width: 180px;' data-dismiss='modal' />" +
                "</td>" +
                "</tr>" +
                "</table>",
            Yes: false,
            No: false
        });  
    }
    function confirm()
    {
        var $this = $(this);
        var bValidate = true;
        var rowCount = $('#tbItem tr').length; 
        if (rowCount === 1) {
            $this.find("a").removeAttr("disabled"); 
            $.bigBoxWarning({
                title: "No Medicine Prescription.",
                content: "Please select item for Prescription.<br> Please try again...",
                timeout: 3000
            });
            return;
        }      
       
         document.getElementById("btnConfirm").disabled = true;
         if (bValidate) {
                  showYesNo({
                    title: "Complete Consultation",
                    width: 420,
                    noClose: true,
                    isModal: true,
                    body: [
                        "<br><h4>Confirm to complete consultation?<h4><br>"
                    ],
                    show: function () {
                    },
                    Yes: {
                         text: "Yes",
                        opt: function () {           
                            adjustStock();
                            hideYesNo();
                        }
                    },
                    No: {
                        text: "No",
                        opt: function () {
                            document.getElementById("btnConfirm").disabled = false;
                            hideYesNo();
                        }
                    }
                });
        }else {
            $.bigBox({
                title: "Warning!",
                content: "Please select Quantity or UOM before proceeed to save!!",
                color: "#C46A69",
                //timeout: 6000,
                icon: "fa fa-warning shake animated",
                timeout: 6000
            });
            document.getElementById("btnConfirm").disabled = false;
        }
    }
        
    function adjustStock()
    {
         var $this = $(this);
            var AdjItem = new Array();
            var rowAdjItem = 0;
            $('#tbItem tr').each(function (row, th) {                
                if (row > 0) {                
                    var rowid = $(this).closest('tr').attr('id');
                    var rowno = rowid.substring(2);

                    AdjItem[rowAdjItem] = {
                        "INDEX": $('#hidIdx' + rowno).val(),
                        "QTY": $('#txtQty' + rowno).val(),                   
                        "TOTAL_PRICE": $('#txtTotalPrice' + rowno).val()
                    };
                    rowAdjItem = rowAdjItem + 1;
                }
            });           
            var ItemToSend = JSON.stringify(AdjItem);
        
            $('#hidPrescriptionItems').val(ItemToSend);

        $this.off('click');
        $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/Servlet_Queue?SFC=UPDATE_CONSULTATION",
                data: {
                    PRESCRIPTION_ITEMS: $('#hidPrescriptionItems').val(),
                    QUEUE_ID: Queue_ID,
                    CONSULTATION_NOTES: $('#txtConsultationNotes').val()
                },
            dataType: 'json',
            beforeSend: function (xhr) {
                $.showLoadingNoStatus();
            },
            success: function (response, status, xhr) {
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Success.",
                        content: "Stock Adjustment Updated Successfully.",
                        timeout: 6000
                    });
                   // $('#btnCancel').trigger('click');
                } else {
                    $.bigBoxFail({
                        title: "Stock Adjustment FAIL.",
                        content: "There is some error during Stock Adjustment creation.<br> Please try again...",
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
    
    function DeleteRow(rowId)
    {
        $('table#tbItem tr#tr' + rowId).remove();
        hideYesNo(true);
    }
   

</script>
