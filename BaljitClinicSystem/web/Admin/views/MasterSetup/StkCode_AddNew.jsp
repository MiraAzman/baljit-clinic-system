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
<!--            Code Master Setup  -->
            <Label ID="txtPageTitle" Text="Vessel:" style="font-weight:lighter;"   >
            <!--<input type="label" Id="txtPageTitle" name="txtPageTitle" value = "Master Code Setup" >-->
           
        </h1>
    </div>
    <div class="widget-body row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            
            <!--ERROR MESSAGE-->
            <div class="row" style="padding-bottom:10px;padding-left:10px;padding-right:10px;">
                <div class="errorContainer alert alert-danger alert-block">
                    <h4 class="alert-heading">There were some field left out or invalid inputs. Please brief through the form and reenter necessarily.</h4>
                    <ol id="error_list">
                    </ol>
                </div>
            </div>
            <!--END OF ERROR MESSAGE-->
            
            <div class="row">
                <form id="form_AddStkCode" name="form_AddStkCode" method="post">
                    <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Code Information</h2></span>
                            </header>
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbStkCodeInfo" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <!--width01-->
                                            <tr>
                                                <td width="10%"><font color="red">*</font> <b>Code</b></td>  <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="89%"> 
                                                    <input type="text" style="width:950px;"  id="txtCode" name="txtCode" maxlength="6" class="form-control" rel="popover-hover" data-original-title="Code" data-content="A Code is a unique mixture of alphanumerical code with a maximum length of 6 characters." />    
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <!--width01-->
                                                <td width="10%"><font color="red">*</font> <b>Description</b></td> <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="89%">       
                                                    <input type="text" style="width:950px;" id="txtDesc" name="txtDesc"  maxlength="100" class="form-control" rel="popover-hover" data-original-title="Description" data-content="A description is the code description with a maximum length of 100 characters." />    
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
                        <input type="button" Id="btnSave"  class="btn btn-default bg-color-blueDark txt-color-white" value="Save" style="margin-right:20px;"/>
                        <input type="button" Id="btnCancel"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Cancel" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../../includes/loading-no-status.jsp"/>
<!--yesno01--><!--Aaron include yes-no.jsp in the code-->
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">

    function bindData(sParam) {  
        var pagefunction = function() {


            $().ready(function () {

  $("#txtPageTitle").html('Master Code Setup - ' + sParam.DESC);
                var container = $('div.errorContainer');

                var validator = $("#form_AddStkCode").validate({
                    rules: {
                        txtCode: "required",
                        txtDesc: "required"
                    },
                    messages: {
                        txtCode: "Code cannot be blank.",
                        txtDesc: "Description cannot be blank."
                    },
                    //onfocusout: false, //re01
                    //onkeyup: false,    //re01
                    errorContainer: container,
                    errorLabelContainer: $("ol", container),
                    wrapper: 'li'
                });
             
                $("#btnSave").click(function(){

                    var $validItem = $("#form_AddStkCode").valid();

                    if ($validItem === true) {
                        document.getElementById("btnSave").disabled = true;

                        //add confirmation box and loading status when user try to create new code
                        showYesNo({
                            title: "Confirmation needed",
                            width: 420,
                            noClose: true,
                            isModal: true,
                            body: [
                                "<br><h4>Please confirm the details entered.<h4><br>"
                            ],
                            show: function(){},
                            Yes:{
                                text: "Yes",
                                opt: function(){
                                    $.ajax({
                                        type: "POST",
                                        url: "${pageContext.request.contextPath}/Servlet_Stock?SFC=UPDATE_CODETYPE",
                                        data: { 
                                            TYPE: sParam.TYPE,
                                            CODE: $('#txtCode').val(),
                                            DESC: $('#txtDesc').val(),
                                            FUNCTION: 'ADD'
                                        },
                                        dataType: 'json',
                                        beforeSend:function(xhr){
                                            $.showLoadingNoStatus();
                                        },
                                        success: function(response,status,xhr){
                                            if (response.bool === true) { //c02
                                                $.bigBoxSuccess({
                                                    title: "Create Item SUCCESS.",
                                                    content: "Item creation SUCCESS.",
                                                    timeout: 6000
                                                });
                                            } 
                                            else {
                                                $.bigBoxFail({
                                                    title: "Create Item FAIL.",
                                                    content: "There is some error during item creation.<br> Please try again...",
                                                    timeout: 6000
                                                });
                                            }  
                                        },
                                        error: function (xhr, status, error) {  //c02
                                            $.bigBoxFail({
                                                title: "Transaction ERROR",
                                                content: "There is some error occur during data transfer. Please try again later",
                                                timeout: 6000
                                            });
                                        },
                                        complete: function (xhr, status) {  //c02
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
                            No:{
                                text: "No",
                                opt: function(){
                                    document.getElementById("btnSave").disabled = false;
                                    hideYesNo();
                                }
                            }
                        });
                    } 
                });
                
                $("#btnCancel").click(function(){

                     location.href = '#/CodeSetupList/'+ sParam.TYPE;  
                     
                });
                
            }); 
        };      
        pagefunction();
//        $("#txtPageTitle").html(sParam.DESC);

    }
        
 
        
</script>
