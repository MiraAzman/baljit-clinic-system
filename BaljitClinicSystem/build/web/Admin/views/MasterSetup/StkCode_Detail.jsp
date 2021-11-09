<!--
Modification ID     By          Date        Comment
-------------------------------------------------------------------------------
yesno01             Aaron       17Dec2018   include yes-no.jsp in the code
c01                 Aaron       17Dec2018   add confirmation box and loading status when user try to update existing record
font01              Aaron       27Dec2018   change font style and color for mandatory fields
len01               Aaron       27Dec2018   set maxlength for Description textbox
validate01          Aaron       02Jan2019   add validation when mandatory fields is not filled up
gg01                    Aaron   08Jan2019   add condition to remove box shadow
-->
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
        margin-left: -100px;
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
    .edittbox{
        font-family: Arial, Helvetica, sans-serif; 
        font-size: 14px;
        Width: 100%;
        margin-left: 5px;
    }
    /*gg01*/
    input[type="text"]:read-only {box-shadow: none;}
    textarea:read-only {box-shadow: none;}
    .col-lg-12{float: none;}
    .col-md-12{float:none;}
    .col-sm-12{float:none;}
    .col-xs-12{float:none;}
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
            <!--Code Detail-->    
            <Label ID="txtPageTitle" Text="Vessel:" style="font-weight:lighter;"   >

        </h1>
    </div>
    <div class="widget-body row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row" style="padding-bottom:10px;padding-left:10px;padding-right:10px;">
                <div class="errorContainer alert alert-danger alert-block">
                    <h4 class="alert-heading">There were some field left out or invalid inputs. Please brief through the form and reenter necessarily.</h4>
                    <ol>
                    </ol>
                </div>
            </div>
            <div class="row">
                <form id="form_StkCodeType" name="form_StkCodeType">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Code Info</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbStkCodeTypeInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="18%"><font color="red">*</font> <b>Code</b></td> <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="25%"> 
                                                    <input type="text" id="txtCode" name="txtCode" readonly class="tboxreadonly" />    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="18%"><font color="red">*</font> <b>Description</b></td> <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="75%">       
                                                    <input type="text" id="txtDesc" name="txtDesc" class="form-control" maxlength="100" />    <!--len01--> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="18%">Record Status</td>
                                                <td width="1%">:</td>
                                                <td width="25%">                                                         
                                                    <input type="checkbox" id="txtrecstatus" name="txtrecstatus" />    
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
                        <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Save" />
                        <!--<input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" onclick="location.href = '#/CodeSetupList'" />-->
                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<!--yesno01-->
<jsp:include page="../../../includes/yes-no.jsp"/>
<!--<script src="js/buttonset.js"></script>-->
<script type="text/javascript">
    pageSetUp();
    
    function bindData(sParam) {
        var pagefunction = function(){
        $(document).ready(function() {
            $("#txtPageTitle").html('Master Code Edit - ' + sParam.DESC);
            strType = sParam.TYPE;
            strCode = sParam.CODE;        
            $.ajax({
                type:'POST',
                url:"${pageContext.request.contextPath}/Servlet_Stock",
                data:  {
                    SFC: 'VIEW_CODE_DETAIL', 
                    TYPE: strType,
                    CODE: strCode
                },
                dataType: 'json',
                success: function(data) {               
                            var arrData = data.object1[0];

                            $('#txtCode').val(arrData.cd_cdcode);
                            $('#txtDesc').val(arrData.cd_cddesc);                                            
                            if(arrData.recstatus === '1'){ $('#txtrecstatus').prop('checked', true); }
                            //alert("SUCCESS "); 
                        }        
                //error:  AjaxError
            });  
            //validate01
            var container = $('div.errorContainer');
            var validator = $("#form_StkCodeType").validate({
                rules: {
                    txtDesc: "required"
                },
                messages: {
                    txtDesc: "Description cannot be blank."
                },
                errorContainer: container,
                errorLabelContainer: $("ol", container),
                wrapper: 'li'
            });
            
            $("#btnSave").click(function(){
                var strDesc = document.getElementById("txtDesc").value;
                var recstatus;
                var $validItem = $("#form_StkCodeType").valid();    //validate01
                if($('#txtrecstatus').is(":checked")) {
                    recstatus = '1';
                }else{
                    recstatus = '0';
                }
                //c01
                //Aaron
                if ($validItem === true){
                document.getElementById("btnSave").disabled = true;
                showYesNo({
                   title:  "Confirmation needed",
                   width: 420,
                   noClose: true,
                   isModal: true,
                   body: [
                       "<br><h4>PLease confirm all the details entered.<h4><br>"
                   ],
                   show: function(){},
                   Yes: {
                       text: "Yes",
                       opt: function(){
                            $.ajax({
                                type:'POST',
                                url:"${pageContext.request.contextPath}/Servlet_Stock",
                                data:  {
                                    SFC: 'UPDATE_CODETYPE', 
                                    CODE: strCode,
                                    DESC: strDesc,
                                    recstatus: recstatus,
                                    FUNCTION: 'EDIT',
                                    TYPE: sParam.TYPE
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
                                            content: "There is some error when updating the details. Please try again later...",
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
                                           window.location.href = "#/CodeSetupList/'+ sParam.TYPE";
                                        }, 500);
                                    } else {
                                        $.hideLoadingNoStatus(function () {
                                        }, 0);
                                    }
                                }
                            });
                            hideYesNo();
                       }
                   },
                   No: {
                       text: "No",
                       opt: function(){
                           document.getElementById("btnSave").disabled = false;
                           hideYesNo();
                       }
                   }
                });
                //c01
                //Aaron
                }    
            });
        
        
            $("#btnCancel").click(function(){
                     location.href = '#/CodeSetupList/'+ sParam.TYPE;                       
            });
        });   
        };
        pagefunction();
    }
</script>
