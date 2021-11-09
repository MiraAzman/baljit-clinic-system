<!--
Modification ID         By          Date            Comment
--------------------------------------------------------------------------------
yesno01                 Aaron       07Dec2018       include yes-no.jsp in the code
c01                     Aaron       07Dec2018       add confirmation box and loading status when user try to create a new role
c02                     Aaron       17Dec2018       add trap for catching error and complete
re01                    Aaron       02Jan2019       comment out pageSetUp function to enable the showed errors to work properly
-->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    div.errorContainer{
        display:none;
        width:100%;
    }
    div.errorContainer ol li{
        list-style-type:disc;
        margin-left: 20px;
    }
    textarea{
        resize:none;
    }

    input[type=text]:read-only {
        background: #dddddd;
    }
    select:disabled{
        background: #dddddd;
    }
    input[type="text"].invalid { border: 1px dotted red; }
    select.invalid { border: 1px dotted red; }
    textarea.invalid { border: 1px dotted red; }

    label {
        display: inline-block; width: 5em;
    }
    fieldset div {
        margin-bottom: 2em;
    }
    fieldset .help {
        display: inline-block;
    }
    .ui-tooltip {
        width: 210px;
    }
</style>

<%--<jsp:useBean id="bean_ParentCode" scope="page" class="BusinessLogic.BLL_UserProfile" />--%>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-12">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-file fa-2x"></i> 
            Role Setup                                  
        </h1>
    </div>

    <form id="form_RoleAdd" name="form_RoleAdd">
        <div class="row">
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">            

                <div class="row" style="padding-bottom:10px;padding-left:10px;padding-right:10px;">
                    <div class="errorContainer alert alert-danger alert-block">
                        <h4 class="alert-heading">There are some errors, please correct them below.</h4>
                        <ol>
                        </ol>
                    </div>
                </div>
                <div class="jarviswidget jarviswidget-color-blueDark" id="widget3"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false"
                     data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                    <header>
                        <span class="widget-icon"> <i class="fa fa-file"></i> </span>
                        <span><h2>&nbsp;Role Info</h2></span>
                    </header>
                    <div>
                        <table id="tbPolicy" class="table table-bordered table-striped" style="clear: both;">
                            <tr>
                                <td width="12%">Role Code <font color="red" size="3">*</font></td>
                                <td width="1%">:</td>
                                <td width="25%"><label class="input">
                                        <input type="text" id="txtRoleCode" name="txtRoleCode" maxlength="20" required  rel="popover-hover" data-placement="right" data-original-title="Role Code" data-content="Enter Role Code with a maximum length of 20 alphanumeric." style="width:250px;"/>                                                          
                                    </label></td>
                                <td width="12%">Role Status <font color="red" size="3">*</font></td>
                                <td width="1%">:</td>
                                <td width="75%"><label class="select">
                                    <label class="select">
                                        <select id="ddlRoleStatus" name="ddlRoleStatus" rel="popover-hover" data-placement="right" required data-original-title="Role Status" data-content="Role Status use to define role active or inactive." style="width:250px;">
                                            <option value="">- Select Role Status -</option>
                                            <option value="1">Active</option>
                                            <option value="0">Inactive</option>                                            
                                        </select>
                                    </label>                                                       
                                </td>
                            </tr>
                            <tr>
                                <td width="12%">Role Name <font color="red" size="3">*</font></td>
                                <td width="1%">:</td>
                                <td width="25%">
                                    <label class="input">
                                        <input type="text" id="txtRoleName" name="txtRoleName" maxlength="50" required  rel="popover-hover" data-placement="right" data-original-title="Role Name" data-content="Enter Role Name." style="width:250px;"/>                                                          
                                    </label>                                                   
                                </td>                                
                                <td width="12%">Role Business App <font color="red" size="3">*</font></td>
                                <td width="1%">:</td>
                                <td width="75%">
<!--                                    <label class="checkbox" required  rel="popover-hover" data-placement="right" data-original-title="Role Business App" data-content="Select at least one Role Business App.">
                                        <label class="checkbox"><input type="checkbox" name="chkCorporate">Corporate</label>
                                        <label class="checkbox"><input type="checkbox" name="chkProvider">Provider</label>
                                        <label class="checkbox"><input type="checkbox" name="chkAdmin">Admin</label>
                                        <label class="checkbox"><input type="checkbox" name="chkPHR">PHR</label>                                                                                 
                                    </label>     -->
                                    <label class="select">
                                        <select id="ddlBizRole" name="ddlBizRole" rel="popover-hover" data-placement="right" required data-original-title="Role Status"  style="width:250px;">
                                            <option value="">- Select Role Business App -</option>
                                            <option value="ADMIN">Admin</option>
                                            <option value="APPROVAL">Approval</option>
                                            <option value="USER">User</option>
                                            <option value="VERIFY">Verify</option>
                                        </select>
                                    </label>   
                                </td>                                                      
                            </tr>
                            <tr>
                                <td width="12%">Role Desc </td>
                                <td width="1%">:</td>
                                <td width="25%">
                                    <label class="input">
                                        <textarea class="custom-scroll" id="txtRoleDesc" name="txtRoleDesc" maxlength="500" wrap="hard" row="3" resize="none" rel="popover-hover" data-placement="right" data-original-title="Description" data-content="Enter Role's decription for future reference on certain preferences with a maximum length of 100 characters." style="width:250px; height:50px;"></textarea>                                                           
                                    </label>                                                   
                                </td>                                
                                <td width="12%"></td>
                                <td width="1%"></td>
                                <td width="75%"></td>                                                      
                            </tr>
                        </table>
                        <div align="center" style="padding-bottom:20px;">
                            <input type="submit" class="btn btn-default bg-color-blueDark txt-color-white form-btn" id="btnRoleSave" name="btnRoleSave" value="Save" style="margin-right:20px;"/>
                            <input type="reset" class="btn btn-default bg-color-blueDark txt-color-white form-btn" id="btnRoleReset" name="btnRoleReset" onclick="resetEvt()" value="Reset" style="margin-right:20px;"/>
                            <input type="button" class="btn btn-default bg-color-blueDark txt-color-white form-btn" id="btnRoleCancel" name="btnRoleCancel" onclick="location.href = '#/RoleList'" value="Cancel" style="margin-right:20px;"/>
                        </div>
                    </div>
                    <div hidden>
                      
                    </div>
                </div>

            </article>
            
             <article class="col-sm-12 col-md-12 col-lg-12">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3"  data-widget-editbutton="false" data-widget-custombutton="false"
                             data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                            <header>
                                <span class="widget-icon"> <i class="fa fa-file"></i></span>
                                <span><h2>&nbsp;Role Function</h2></span>
                            </header>
                           <!-- <div class="padding-10">-->
                           <div class="widget-body">
                                 <!--<div id="dgContainer" class="widget-body no-padding" >-->
<!--                            <div class="table-responsive">
                                <div id="cjqgridRolefc"></div>
                                <table id="jqgridRolefc" class="table table-striped table-bordered"  ></table>
                                <div id="pjqgridRolefc"></div>
                            </div>-->
                          <!--  </div>-->

<!--                                <input type="button" Id="btnAddItem" onclick="add_Item();"  class="btn btn-default bg-color-blueDark txt-color-white" value="Add New Item" />&nbsp;-->
  
                                 <div id="gridRoleItemSummary" class="">
<!--                                <div id="bar-chart" class="chart"></div>-->

                                <table  class="table table-striped" id="tbRoleFc" >
                                    <thead>
                                    
                                    <th id="MENUDESC">Menu Desc</th>                                    
                                    <th id="ALLOWVIEW">Allow View</th>
                                    <th id="ALLOWADD">Allow Add</th>
                                    <th id="ALLOWEDIT">Allow Edit</th>
                                    <th id="ALLOWDEL">Allow Del</th>
                                    <th id="HASVERIFY">Has Verify</th>
                                    <th id="HASAPPROVAL">Has Approval</th>                                   
                                    </thead>
                                    <tbody id="RoleItemGrid" >

                                    </tbody>
                                </table>

                            </div>
                            </div>
                        </div>



                    </article>
            
        </div>
    </form>
</section>
<jsp:include page="../../../includes/loading-no-status.jsp"/>
<!-- yesno01--><!--Aaron include yes-no.jsp in the code-->
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">
    //pageSetUp(); //re01
    
    $("#btnRoleSave").click(function() {
        //var mydata = jQuery("#jqgridRolefc").jqGrid('getRowData');//$("#jqgridRolefc").jqGrid('getGridParam','data');
        var RoleData = new Array();
        $('#tbRoleFc tr').each(function (row, th) { 
         // alert($('#tbRoleFc tr').size());
            RoleData[row] = {
                  "MnuCode": $('#txtMnuCode' + row).val()
                , "MnuDesc": $('#txtMnuName' + row).val()
                , "MnuType": $('#txtMnuType' + row).val()
                , "MnuSeq": $('#txtMnuSeq' + row).val()
                , "HasView": ($('#chkView_' + row).is(':checked').toString().replace("false", 0)).replace("true",1)
                , "HasAdd": ($('#chkAdd_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
                , "HasEdit": ($('#chkEdit_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
                , "HasDel": ($('#chkDel_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
                , "HasVerify": ($('#chkVerify_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
                , "HasApprove": ($('#chkApprove_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
             };        
        });
        
         RoleData.splice(($('#tbRoleFc tr').size() -1), 1);
        //alert(JSON.stringify(RoleData));
        console.log(JSON.stringify(RoleData));
        
        var container = $('div.errorContainer');

        var validator = $("#form_RoleAdd").validate({
            rules: {
                txtRoleCode: "required",
                ddlRoleStatus: "required",
                txtRoleName: "required",
                ddlBizRole :"required"
                
                
            },
            messages: {
                txtRoleCode: "Please enter role code.",
                ddlRoleStatus: "Please select role status.",
                txtRoleName: "Please enter role name.",
                ddlBizRole: "Please select role business app."             
            },
            errorContainer: container,
            errorLabelContainer: $("ol", container),
            wrapper: 'li',
            submitHandler: function() {
                document.getElementById('btnRoleSave').disabled = true;
                document.getElementById('btnRoleReset').disabled = true;
                document.getElementById('btnRoleCancel').disabled = true;
                //c01
                //Aaron
                //add confirmation box and loading status 
                showYesNo({
                   title: "Confirmation needed",
                   width: 420,
                   noClose: true,
                   isModal: true,
                   body:[
                       "<br><h4>Please confirm all the details entered.<h4><br>"
                   ],
                   show: function(){},
                   Yes:{
                       text: "Yes",
                       opt: function(){
                            $.ajax({
                                type: "POST",
                                url: "${pageContext.request.contextPath}/Servlet_Role?SFC=Set_Role_Add",
                                data: {
                                    ADDROLE: JSON.stringify($('#form_RoleAdd').serializeArray()),
                                    ROLEFC : JSON.stringify(RoleData)
                   
                                },
                                dataType: 'json',
                                beforeSend: function(xhr){
                                    $.showLoadingNoStatus();
                                },
                                success: function(response,xhr,status){ //c02
                                    if (response.bool === true) {
                                        $.bigBoxSuccess({
                                            title: "Create ROLE SUCCESS.",
                                            content: "ROLE creation SUCCESS.",
                                            timeout: 6000
                                        });
                                        //location.href = "#/RoleList";
                                    }
                                    else{
                                        $.bigBoxFail({
                                            title: "Create Role FAIL.",
                                            content: "There is some error during role creation.<br> Please try again...",
                                            timeout: 6000
                                        });
                                        document.getElementById('btnRoleSave').disabled = false;
                                        document.getElementById('btnRoleReset').disabled = false;
                                        document.getElementById('btnRoleCancel').disabled = false;                       
                                    }    
                                },
                                error: function(xhr,status,error){  //c02
                                    $.bigBoxFail({
                                        title: "Transaction ERROR",
                                        content: "There is some error occur during data transfer. Please try again later",
                                        timeout: 6000
                                    });
                                },
                                complete: function(xhr,status){ //c02
                                    if (xhr.status === 200) {
                                        $.hideLoadingNoStatus(function () {
                                            window.location.href = "#/RoleList";
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
                            hideYesNo();
                        }
                       
                    }
                });
                //c01
                //Aaron
//                var request = $.ajax({
//                    type: "POST",
//                    url: "${pageContext.request.contextPath}/Servlet_Role?SFC=Set_Role_Add",
//                    data: {
//                    ADDROLE: JSON.stringify($('#form_RoleAdd').serializeArray()),
//                    ROLEFC : JSON.stringify(RoleData)
//                   
//                },
//                    //data: $('#form_RoleAdd').serialize(),
//                    dataType: 'json'
//                });
                
            }
        });
    });
    var pagefunction = function() {
    
        $().ready(function() {
            $(".numeric").numeric();
        });
    
         loadScript("js/plugin/jqgrid/ui.multiselect.js", function () {
            loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
                loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", function () {
                    loadScript("js/column-chooser.js", function () {
                        run_jqgrid_function();
                    });
                });
            });
        });

      
        
        function run_jqgrid_function() {
//              var grid = $("#jqgridRolefc"),
//                    gridPager = "#p" + grid.selector.toString().substring(1),
//                    conDiv = $("#c" + grid.selector.toString().substring(1)),
//                    defaultColName = ['Menu Code', 'Menu Desc', 'Menu Type', 'Allow View', 'Allow Add', 'Allow Edit', 'Allow Del', 'Has Verify', 'Has Approval'],
//                    defaultColMol = [
//                        //  {name:'MEM_NRIC',index:'MEM_NRIC', sortable:true, searchoptions: { sopt: ['cn']}, formatter:'showlink',formatoptions:{baseLinkUrl:'../ProviderPortal/Prov_Patient_Detail.jsp',addParam: '',showAction:'',idName:'PMemNRIC'}},                     
//                       // {name: 'details', index: 'details', hidden: true, formatter: viewDetail, search: false, sortable: false, width: 80, align: 'center', must: true, hidedlg: true},
//                        {name: 'MnuCode', index: 'MnuCode', sortable: true,  width: 100, must: true, hidedlg: true, hidden: true},
//                        {name: 'MnuDesc', index: 'MnuDesc', sortable: true, must: true, hidedlg: true, width: 100, formatter: BoldMainMenu},
//                        {name: 'MnuType', index: 'MnuType', sortable: true, must: true, hidedlg: true, width: 100, hidden: true},
//                        {name: 'HasView', index: 'HasView', sortable: false, width: 120, formatter: 'checkbox', formatoptions: { disabled: false}, edittype: "checkbox", editoptions: { value: "1:0",defaultValue: "1"}},
//                        {name: 'HasAdd', index: 'HasAdd', sortable: false, width: 120, formatter: 'checkbox', formatoptions: {disabled: false },  editoptions: { value: "1:0", defaultValue: "0"}},
//                        {name: 'HasEdit', index: 'HasEdit', sortable: true, width: 120, formatter: 'checkbox', formatoptions: {disabled: false },  editoptions: { value: "1:0", defaultValue: "0"}},
//                        {name: 'HasDel', index: 'HasDel', sortable: true, width: 120, formatter: 'checkbox', formatoptions: {disabled: false },  editoptions: { value: "1:0", defaultValue: "0"}},
//                        {name: 'HasVerify', index: 'HasVerify', sortable: true, width: 100, formatter: 'checkbox', formatoptions: {disabled: false },  editoptions: { value: "1:0", defaultValue: "0"}},
//                        {name: 'HasApprove', index: 'HasApprove', sortable: true, width: 100, formatter: 'checkbox', formatoptions: {disabled: false },  editoptions: { value: "1:0", defaultValue: "0"}}
//                       // {name:'HasView', index:'HasView', width:60, align:'center', formatter:'checkbox',editable:true,edittype:'checkbox',formoptions:{ rowpos:10,elmprefix:"&nbsp;" }
//                       
//                    ],
//                    mainGridName = grid.selector.toString().substring(1),
//                    //temp = readSettings({settingArray:${sessionScope.settings}, defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName});//,
//                    temp = readSettings({settingArray: "admin", defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName}),
//                    currentColName = temp[0],
//                    currentColMol = temp[1];
//            
//             grid.jqGrid({
//                url: '${pageContext.request.contextPath}/Servlet_Role',
//                postData: {
//                    SFC: 'GET_MENU'
//                },
//                datatype: "json",
//                mtype: 'POST',
//                colNames: currentColName,
//                colModel: currentColMol,
//                // rownumbers: true,
//                gridview: true,
//                rownumWidth: 40,
//                rowNum: -1,
//               // rowList: [10, 20, 25, 30, 50, 100],
//               // pager: gridPager,
//                //sortname: '',
//                viewrecords: true,
//                //sortorder: 'asc',
//                toolbarfilter: false,
//                autowidth: true,
//                shrinkToFit: true,
//                loadonce: false,
//                height: 'auto',
//                scrollerbar: false,
//                subGrid: false,
//                rownumbers: true,  
//                multiselect: false,
//                sortable: {
////                    update: function (relativeColumnOrder) {
////                        //sortColumn({settingArray:${sessionScope.settings}, order: relativeColumnOrder, grid: grid, defaultColMol: defaultColMol, settingName: mainGridName});
////                        sortColumn({settingArray: "admin", order: relativeColumnOrder, grid: grid, defaultColMol: defaultColMol, settingName: mainGridName});
////                    }
//                },
//                          beforeProcessing: function (data, status, xhr) {
//                              
//                               for (var i = 0; i < data.rows.length; i++) {
//                        //   alert(data.rows[i].HasAdd);
//                           if (data.rows[i].HasAdd === 'N'){
//                               jQuery("#jqgridRolefc").jqGrid('setSelection',"-1");
//                              //// alert('');
//                              // $('#tr_HasAdd').attr('disabled',true);
//                              // $('#jqgridRolefc_HasAdd').attr('disabled', false);
//                              // $('#jqgridRolefc_HasAdd').prop('disabled', false);
//                              jQuery("#jqgridRolefc").jqGrid('setCell', 1, ["HasAdd"],"");
//                               
//                            }
//
//                      }
//                              
////                        data.datalist;
////                        //alert(data.datalist.length);
////
////                        duplist = data.datalist;
////                        if (data.datalist.length > 0) {
////                            for (var i = 0; i < duplist.length; i++)
////                            {
////                                var tempdupobj = duplist[i];
////                                dupdata += "<option value=" + tempdupobj.MDP_DupMemID + ">" + tempdupobj.MDP_DupMemName + "</option>";
////                            }
////                        }
//                    },
//                loadComplete: function (data) {
//                    
////                 var rowCount  = grid.getGridParam("reccount");
////                  //  alert(rowCount);
////                    alert(data.rows.length);
////                    if ( rowCount > 0 ) {
//                      for (var i = 1; i < data.rows.length; i++) {
//                        //   alert(data.rows[i].HasAdd);
//                           if (data.rows[i].HasAdd === 'N'){
//                              // jQuery("#jqgridRolefc").setCell(i,"HasAdd","",{display : "none"});
//                              // jQuery("#jqgridRolefc").setCell(i,"HasAdd","","  111");
//                             jQuery("#jqgridRolefc").setCell([i],"HasAdd",'',{'background':'#ff0000'});
//                               //jQuery("#jqgridRolefc").setCell(i,"HasAdd",'',{'display':'none'});
//                               
//                               // jQuery("#jqgridRolefc").jqGrid('setCell', 1, ["HasAdd"],"");
//                               //jQuery("#jqgridRolefc").jqGrid('hideCol',["HasAdd"]);
//                              // alert('');
//                              // $('#tr_HasAdd').attr('disabled',true);
//                               //$('#jqgridRolefc_HasAdd').attr('disabled', true);
//                               
//                            }
//
//                      }
//
//                }
//
//            
//            });
//            
//                function formatColor(val, row) {
//                // alert(val);
//                if (val === 'Active') {
//                    return '<span style="color:#008000;"><b>' + val + '</b><span>';
//                }
//                else if (val === 'Inactive') {
//                    return '<span style="color:#000099;"><b>' + val + '</b></span>';
//                }
//                else {
//                    return val;
//                }
//            }
//              
//            function BoldMainMenu(cellvalue, options, rowObject) {
//                if (rowObject.MnuType === 'MN'){
//                    return '<span style="color:#000000;"><b>' + rowObject.MnuDesc + '</b><span>';
//                }else{
//                    return '<span style="color:#000000;">' + rowObject.MnuDesc + '<span>';
//                }
//
//            }
//            
//            function CheckView(cellvalue, options, rowObject) {
//                if (rowObject.HasView === 'Y'){
//                      return "<input type='checkbox' id='chkView_" + rowObject.MnuCode + "'  onchange='getCurrentBinRow(this)' />";
//                }else{
//                    return '';
//                }
//            }
//            
//            function CheckAdd(cellvalue, options, rowObject) {
//                if (rowObject.HasAdd === 'Y'){
//                      return "<input type='checkbox' id='chkAdd_" + rowObject.MnuCode + "'  value='1'>";
//                }else{
//                    return '';
//                }
//            }
//            
//            function CheckEdit(cellvalue, options, rowObject) {
//                if (rowObject.HasEdit === 'Y'){
//                      return "<input type='checkbox' id='chkEdit_" + rowObject.MnuCode + "'  value='1'>";
//                }else{
//                    return '';
//                }
//            }
//            
//            function CheckDel(cellvalue, options, rowObject) {
//                if (rowObject.HasDel === 'Y'){
//                      return "<input type='checkbox' id='chkDel_" + rowObject.MnuCode + "'  value='1'>";
//                }else{
//                    return '';
//                }
//            }
//            
//            function Checkverify(cellvalue, options, rowObject) {
//                if (rowObject.HasVerify === 'Y'){
//                      return "<input type='checkbox' id='chkVerify_" + rowObject.MnuCode + "'  value='1'>";
//                }else{
//                    return '';
//                }
//            }
//            
//            function CheckApproval(cellvalue, options, rowObject) {
//                if (rowObject.HasApprove === 'Y'){
//                      return "<input type='checkbox' id='chkApprove_" + rowObject.MnuCode + "'  value='1'>";
//                }else{
//                    return '';
//                }
//            }
//            
//            
//           
//             // remove classes
//            $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
//            $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
//            $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
//            $(".ui-jqgrid-pager").removeClass("ui-state-default");
//            $(".ui-jqgrid").removeClass("ui-widget-content");
//            // add classes
//            $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
//            $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");
//            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
//            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus");
//            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil");
//            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o");
//            $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
//            $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
//            $(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
//            $(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
//            $(".ui-icon.ui-icon-seek-prev").wrap("<div class='btn btn-sm btn-default'></div>");
//            $(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");
//            $(".ui-icon.ui-icon-seek-first").wrap("<div class='btn btn-sm btn-default'></div>");
//            $(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");
//            $(".ui-icon.ui-icon-seek-next").wrap("<div class='btn btn-sm btn-default'></div>");
//            $(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");
//            $(".ui-icon.ui-icon-seek-end").wrap("<div class='btn btn-sm btn-default'></div>");
//            $(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");
//            $(".ui-pg-input").addClass("pg-input");
//            
//             // resize
//            $(window).on('resize', function () {
//                grid.jqGrid('setGridWidth', conDiv.width());
//            });
//            grid.on('myRefresh', function () {
//                resizeWidth({grid: grid, gridDiv: conDiv});
//            });
////         quickSetupChooser({grid: grid, defaultColMol: defaultColMol, settingName: mainGridName,
////            settingArray:${sessionScope.settings},
//            quickSetupChooser({grid: grid, defaultColMol: defaultColMol, settingName: mainGridName,
//                settingArray: "admin",
//                done: function () {
//                    resizeWidth({grid: grid, gridDiv: conDiv});
//                }
//            });
//            grid.jqGrid('setGridWidth', conDiv.width());
//            
       };
        
        
        
        $.get('${pageContext.request.contextPath}/Servlet_Role', {SFC: 'GET_MENU'}, function (data) {
            var arrData = JSON.parse(data);//data.object1[0];
          //  alert(JSON.stringify(arrData.rows.length));
             for (var a = 0; a < arrData.rows.length; a++)
             {
                $("#tbRoleFc tbody").append("<tr>" +
                "<td><input type='text' readonly class='form-control' ID='txtMnuName" + a + "' name='txtMnuName" + a + "' /><input type='hidden' readonly class='form-control' ID='txtMnuCode" + a + "' name='txtMnuCode" + a + "' /><input type='hidden' readonly class='form-control' ID='txtMnuType" + a + "' name='txtMnuType" + a + "' /><input type='hidden' readonly class='form-control' ID='txtMnuSeq" + a + "' name='txtMnuSeq" + a + "' />" +                                                           
                "<td><input type='checkbox' id='chkView_" + a + "'></td>" +
                "<td><input type='checkbox' id='chkAdd_" + a + "'></td>" +
                "<td><input type='checkbox' id='chkEdit_" + a + "'></td>" +
                "<td><input type='checkbox' id='chkDel_" + a + "'></td>" +
                "<td><input type='checkbox' id='chkVerify_" + a + "'></td>" +
                "<td><input type='checkbox' id='chkApprove_" + a + "'></td>" +
                "</tr>"
                );
        
                $("#txtMnuCode" + a).val(arrData.rows[a].MnuCode);
                $("#txtMnuName" + a).val(arrData.rows[a].MnuDesc);
                $("#txtMnuType" + a).val(arrData.rows[a].MnuType);
                $("#txtMnuSeq" + a).val(arrData.rows[a].MnuSeq);
                
                if (arrData.rows[a].HasView !== 'Y'){
                     $('#chkView_'  + a).css("display","none");
                    //$('#chkView_'  + a).prop('disabled', false);
                }
                
                if (arrData.rows[a].HasAdd !== 'Y'){
                      $('#chkAdd_'  + a).css("display","none");
                   // $('#chkAdd_'  + a).prop('disabled', false);
                }
                
                if (arrData.rows[a].HasEdit !== 'Y'){
                      $('#chkEdit_'  + a).css("display","none");
                   // $('#chkAdd_'  + a).prop('disabled', false);
                }
                
                if (arrData.rows[a].HasDel !== 'Y'){
                      $('#chkDel_'  + a).css("display","none");
                   // $('#chkAdd_'  + a).prop('disabled', false);
                }
                
                if (arrData.rows[a].HasVerify !== 'Y'){
                      $('#chkVerify_'  + a).css("display","none");
                   // $('#chkAdd_'  + a).prop('disabled', false);
                }
                
                if (arrData.rows[a].HasApprove !== 'Y'){
                      $('#chkApprove_'  + a).css("display","none");
                   // $('#chkAdd_'  + a).prop('disabled', false);
                }
                
             }
            
            
        });
        
        
        
    };
    
function getCurrentBinRow(elem) {
    var id = $(elem).closest('tr')[0].id;
    $(elem).closest('tr').toggleClass('redRow'); // adds red bgcolor when checked.
    alert(id);  
}
    
//$("#jqgridRolefc").find('input[type=checkbox]').each(function() {
//    $(this).change( function(){
//        var colid = $(this).parents('tr:last').attr('id');
//        if( $(this).is(':checked')) {
//           $("#jqgridRolefc").jqGrid('setSelection', colid );
//           $(this).prop('checked',true);
//        }
//        return true;
//    });
//});
    
    function resetEvt() {
        document.getElementById('divErrorContainer').display = false;
    }
   // loadScript("js/jquery.numeric.js", pagefunction);
    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
        loadScript("js/buttonset.js", function () {
            loadScript("js/excel-export.js", function () {
                loadScript("js/jquery.numeric.js", function () {
                pagefunction();
            });
            });
        });
    });
    
    
    
</script>

