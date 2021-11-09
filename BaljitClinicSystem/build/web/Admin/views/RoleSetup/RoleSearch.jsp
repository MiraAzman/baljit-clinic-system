<!--
Modification ID     By          Date        Comment
------------------------------------------------------------------------------
yesno01             Aaron       07Dec2018   include yes-no.jsp in the code
c01                 Aaron       07Dec2018   add confirmation box and loading status when user try update a role
c02                 Aaron       17Dec2018   add confirm function and updateDetail function 
name01              Aaron       27Dec2018   change name for btnUpdate
font01              Aaron       02Jan2019   change font style and color for mandatory fields
validate01          Aaron       03Jan2019   add validators for mandatory fields
gg01                    Aaron   08Jan2019   add condition to remove box shadow
-->
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
    /*gg01*/
    input[type="text"]:read-only {box-shadow: none;}
    textarea:read-only {box-shadow: none;}
</style>
<!-- widget grid -->
<section id="widget-grid" class="">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-user-md fa-2x"></i> 
            Role Search                                       
        </h1>
    </div>
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row" style="padding-left:20px;padding-bottom:20px;">
                <button class="btn btn-default bg-color-blueDark txt-color-white form-btn" id="btnRoleAdd" name="btnRoleAdd" onclick="location.href = '#/AddRole'">Create Role</button>
            </div>
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-10"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-user-md"></i></span>
                    <h2>Role Search List</h2>
                </header>
                <div>
                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
<!--                    <div class="widget-body no-padding">
                        <div class="table-responsive">
                            <table id="jqgrid" class="table table-striped table-bordered"  ></table>
                            <div id="pjqgrid"></div>
                        </div>
                    </div>-->
                            <div class="table-responsive">
                                <div id="cjqgrid"></div>
                                <table id="jqgrid" class="table table-striped table-bordered" ></table>
                                <div id="pjqgrid"></div>
                            </div>
                    <!-- end widget content -->
                </div>
            </div>
        </article>
    </div>
  
</section>
<!-- end widget grid -->

<div class="modal fade" id="PoDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 91%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="RoleDetailLabel">Role Detail</h4>
            </div>
            <form id="form_RoleDetail" name="form_RoleDetail">
            <div class="modal-body">
                <div class="widget-body">
                    <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-togglebutton="false">
                        <header>
                            <h2>Role Detail</h2>
                        </header>
                        <div class="container">
                            <!--Purchase Order Header-->
                            <div class="row">
                                <div class="widget-body">

                                    <table id="tbPoHeader" class="table table-bordered table-striped" style="clear:both;">
                                        <tbody>
                                            <tr>
                                                <td width="12%">Role Code <font color="red">*</font></td>  <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="25%"> 
                                                    <input type="text" id="lblRoleCode" name="lblRoleCode" class="tboxreadonly" readonly/>
                                                    
                                                </td>
                                                <td width="12%">Role Status <font color="red">*</font></td>  <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="75%">
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
                                                <td width="12%">Role Name <font color="red">*</font></td> <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="25%">                                                    
                                                    <input type="text" id="lblRoleName" name="lblRoleName" class="tboxreadonly" readonly/>                                                    
                                                </td>
                                                <td width="12%">Role Business App <font color="red">*</font></td> <!--font01-->
                                                <td width="1%">:</td>
                                                <td width="75%">
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
                                                <td width="12%">Role Desc</td>
                                                <td width="1%">:</td>
                                                <td width="25%"> 
                                                    <input type="text" id="lblRoleDesc" name="lblRoleDesc" class="tboxreadonly" readonly/>                                                  
                                                </td>
                                                <td width="12%"></td>
                                                <td width="1%"></td>
                                                <td width="75%">
                                                   
                                                </td>
                                            </tr>
                                          

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                            <!--End Purchase Order Header-->
                            
                          
                    </div>
                    </div>
                    
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
                    
                </div>
            </div>
            </form>
            <div>
                <div class="row">
                    <div class="col-sm-12">
                        <div align="center" class="padding-5" >
                            
                            <input type="button" Id="btnUpdate"  class="btn btn-default bg-color-blueDark txt-color-white" value="Update" style=" width: 100px" onclick ="confirm();"/> <!--name01-->
                            <input type="button" Id="btnCloseDetail"  class="btn btn-default bg-color-blueDark txt-color-white" value="Close" style=" width: 80px;" data-dismiss="modal" />

                        </div>
                    </div>
                </div>
            </div>
    </div>
    </div>
</div>
<jsp:include page="../../../includes/loading-no-status.jsp"/>
<!--yesno01--><!--Aaron include yes-no.jsp in the code-->
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">
   
    var pagefunction = function () {
        
       
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
            
            var grid = $("#jqgrid"),
                gridPager = "#p" + grid.selector.toString().substring(1),
                conDiv = $("#c" + grid.selector.toString().substring(1)),
                defaultColName =  ['View','Role Code', 'Role Name', 'Business App', 'Description', 'Date Created', 'Status'],
                defaultColMol = [
                    {name: 'details', index: 'details', formatter: viewDetail, search: false, sortable: false, width: 80, align: 'center', must: true, hidedlg: true},
                    {name: 'RoleCode', index: 'RoleCode', sortable: true},
                    {name: 'RoleName', index: 'RoleName', sortable: true},
                    {name: 'RoleBiz', index: 'RoleBiz', sortable: true },
                    {name: 'RoleDesc', index: 'RoleDesc', sortable: true, search: false},
                    {name: 'createdate', index: 'createdate', sortable: false, search: false},
                    {name: 'ROLSTATUS', index: 'ROLSTATUS', sortable: true, formatter: formatColor}
                ],
              
                mainGridName = grid.selector.toString().substring(1),
                //temp = readSettings({settingArray:${sessionScope.settings}, defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName});//,
                temp = readSettings({settingArray:"admin", defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName}),
              currentColName = temp[0],
              currentColMol = temp[1];
       // alert(JSON.stringify(temp));
        grid.jqGrid({
            url: '${pageContext.request.contextPath}/Servlet_Role',
                postData: {
                        SFC: 'Get_Role_List'               
//                        PRDCODE: $('#txtPrdCode').val(),
//                        PRDNAME: $('#txtPrdDesc').val(),
//                        PrdGrpFrom: $('#ddlPrdGrpFrom').val(),
//                        PrdGrpTo: $('#ddlPrdGrpTo').val(),
//                        PRDTYPFROM: $('#ddlPrdTypeFrom').val(),
//                        PRDTYPTO: $('#ddlPrdTypeTo').val(),
//                        PRDCAT: $('input[name=rdPrdCat]:checked').val()
                },
            datatype: "json",
            mtype: 'POST',
            colNames: currentColName,
            colModel: currentColMol,
           // rownumbers: true,
            gridview: true,
            rownumWidth: 40,
            rowNum: 20,
            rowList: [10, 20, 25, 30, 50, 100],
            pager: gridPager,
            sortname: 'RoleCode',
            viewrecords: true,
            sortorder: 'desc',
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
           scrollerbar: false,        
           sortable: {
                update: function (relativeColumnOrder) {
                    //sortColumn({settingArray:${sessionScope.settings}, order: relativeColumnOrder, grid: grid, defaultColMol: defaultColMol, settingName: mainGridName});
                    sortColumn({settingArray:"admin", order: relativeColumnOrder, grid: grid, defaultColMol: defaultColMol, settingName: mainGridName});
                }
            },
                loadComplete: function () {
                var iLastPage = parseInt($(this).getGridParam('lastpage'));
                $(".ui-jqgrid .ui-pg-input").keydown(function (e) {
                    this.value = this.value.replace(/\D/g, '');
                    var code = e.keyCode || e.which;
                    if (code === 13) {
                        if (this.value > iLastPage) {
                            this.value = iLastPage;
                        } else if (this.value <= 0) {
                            this.value = 1;
                        }
                    }
                });
            }
        });
        
            function formatColor(val, row) {
                // alert(val);
                if (val === 'Active') {
                    return '<span style="color:#008000;"><b>' + val + '</b><span>';
                }
                else if (val === 'Inactive') {
                    return '<span style="color:#000099;"><b>' + val + '</b></span>';
                }
                else {
                    return val;
                }
            }

            function viewDetail(cellvalue, options, rowObject) {
                //return "<a  target='_self' class='btn btn-default bg-color-blueDark txt-color-white' title='Member Detail' href='#/MemberDetail/" + rowObject.MEM_ID + "/" + rowObject.MEM_CorpCode + "'>View Details</a>";
               // return"<a style='cursor: pointer;' title='View Details' href='#/ProductDetail/" + rowObject.stk_stockcode + "'><i class='fa fa-fw fa-lg fa-list-alt' /></a>";
               //"<a style='cursor: pointer;' title='Print/Export' data-toggle='modal' data-target='#myModal2' onclick='printEmployees(\"" + rowObject.CP_Name + "\" , \"" + rowObject.CP_Code + "\")'><i class='fa fa-fw fa-lg fa-user' /></a>" + 
                return "<a class='' style='cursor:pointer;' onclick='OpenDetail(\"" +  rowObject.RoleCode + "\")''><i class='fa fa-fw fa-lg fa-list-alt' /></a>";

            }
        

        // remove classes
        $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
        $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
        $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
        $(".ui-jqgrid-pager").removeClass("ui-state-default");
        $(".ui-jqgrid").removeClass("ui-widget-content");
        // add classes
        $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
        $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");
        $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
        $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus");
        $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil");
        $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o");
        $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
        $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
        $(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
        $(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
        $(".ui-icon.ui-icon-seek-prev").wrap("<div class='btn btn-sm btn-default'></div>");
        $(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");
        $(".ui-icon.ui-icon-seek-first").wrap("<div class='btn btn-sm btn-default'></div>");
        $(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");
        $(".ui-icon.ui-icon-seek-next").wrap("<div class='btn btn-sm btn-default'></div>");
        $(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");
        $(".ui-icon.ui-icon-seek-end").wrap("<div class='btn btn-sm btn-default'></div>");
        $(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");
        $(".ui-pg-input").addClass("pg-input");
        
        // resize
        $(window).on('resize', function () {
            grid.jqGrid('setGridWidth', conDiv.width());
        });
        grid.on('myRefresh', function () {
            resizeWidth({grid: grid, gridDiv: conDiv});
        });
//         quickSetupChooser({grid: grid, defaultColMol: defaultColMol, settingName: mainGridName,
//            settingArray:${sessionScope.settings},
        quickSetupChooser({grid: grid, defaultColMol: defaultColMol, settingName: mainGridName,
            settingArray:"admin",
            done: function () {
                resizeWidth({grid: grid, gridDiv: conDiv});
            }
        });
        grid.jqGrid('setGridWidth', conDiv.width());
        
};
};


    function OpenDetail(s_param) {
        //alert(s_param);
        $("#PoDetail").modal("show");
       // alert(s_param);
        //jQuery("#jqgridPoItem").jqGrid("clearGridData");
        BindRoleDetail(s_param);
    }
    
    function BindRoleDetail(s_param) {
         var paramList = "";
        $.ajax({
            type: "get",
            async: false,
            url: "${pageContext.request.contextPath}/Servlet_Role?SFC=Get_Role_Detail",
            data: {ROLECODE: s_param},
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                var arrData = msg.object1[0];
                 
                
                  $('#lblRoleCode').val(arrData.ROLCODE);
                  $('#lblRoleName').val(arrData.ROLNAME);
                  $('#lblRoleDesc').val(arrData.ROLDESC);
                  $("#ddlRoleStatus").val(arrData.ROLSTATUS);
                  $("#ddlBizRole").val(arrData.ROLBIZAPP);
         
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert("get session failed " + errorThrown);
            }
        });
        $('#tbRoleFc tbody > tr').remove();
        $.get('${pageContext.request.contextPath}/Servlet_Role', {SFC: 'GET_MENU_BY_ROLE', ROLECODE: s_param}, function (data) {
            var arrData = JSON.parse(data);//data.object1[0];
          //alert(JSON.stringify(arrData.rows));
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
                }
                
                if (arrData.rows[a].HasAdd !== 'Y'){
                      $('#chkAdd_'  + a).css("display","none");                   
                }
                
                if (arrData.rows[a].HasEdit !== 'Y'){
                    $('#chkEdit_'  + a).css("display","none");                   
                }
                
                if (arrData.rows[a].HasDel !== 'Y'){
                    $('#chkDel_'  + a).css("display","none");                   
                }
                
                if (arrData.rows[a].HasVerify !== 'Y'){
                    $('#chkVerify_'  + a).css("display","none");
                }
                
                if (arrData.rows[a].HasApprove !== 'Y'){
                    $('#chkApprove_'  + a).css("display","none");                
                }
                
                if(arrData.rows[a].AllowView === '1'){
                    $('#chkView_'  + a).prop('checked', true);
                }
                
                if(arrData.rows[a].AllowAdd === '1'){
                    $('#chkAdd_'  + a).prop('checked', true);
                }
                
                if(arrData.rows[a].AllowEdit === '1'){
                    $('#chkEdit_'  + a).prop('checked', true);
                }
                
                if(arrData.rows[a].AllowDel === '1'){
                    $('#chkDel_'  + a).prop('checked', true);
                }
                
                if(arrData.rows[a].AllowVerify === '1'){
                    $('#chkVerify_'  + a).prop('checked', true);
                }
                
                if(arrData.rows[a].AllowApprove === '1'){
                    $('#chkApprove_'  + a).prop('checked', true);
                }
                
             }
            
            
        });
        
        
   
    };
    
    //c02
    function confirm(){
        var $this = $(this);
        //validate01
        var validator = $("#form_RoleDetail").validate({
            rules: {
                ddlRoleStatus: "required",
                ddlBizRole :"required"
            },
            messages: {
                ddlRoleStatus: "Please select role status.",
                ddlBizRole: "Please select role business app."             
            },
            onclick:false,
            onfocusout: false,
            onkeyup: true
        });
        var $validItem = $("#form_RoleDetail").valid();  //validate01
        var RoleData = new Array();
        $('#tbRoleFc tr').each(function (row, th) { 
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
        if ($validItem === true){  //validate01
        document.getElementById("btnUpdate").disabled = true;
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
                        updateDetail(RoleData);
                        hideYesNo();
                    }
               },
               No:{
                   text: "No",
                   opt: function(){
                       document.getElementById("btnUpdate").disabled = false;
                       hideYesNo();
                   }
               }
            });
    }
    }
    //c02
    function updateDetail(RoleData){
        var $this = $(this);
         
        $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/Servlet_Role?SFC=UPDATE_ROLE",
                data: {
                     ROLEITEM: JSON.stringify($('#form_RoleDetail').serializeArray()),
                     ROLEFC: JSON.stringify(RoleData)
                     
                },
                dataType: 'json',
            beforeSend: function (xhr) {
                      $.showLoadingNoStatus();
                },
            success: function(response,xhr,status) {
                if (response.bool === true) {
                    $.bigBoxSuccess({
                        title: "Role Update.",
                        content: "Role Update Success.",
                        timeout: 6000
                    });
                    
                } 
                else {
                    $.bigBoxFail({
                        title: "FAILED To Update Role.",
                        content: "There is some error during role update.<br> Please try again...",
                        timeout: 6000
                    });
                }
            },
            error: function(xhr,status,error){
                $.bigBoxFail({
                    title: "Transaction ERROR",
                    content: "There is some error occur during data transfer. Please try again later",
                    timeout: 6000
                });
            },
            complete: function(xhr,status){
                document.getElementById("btnUpdate").disabled = false;
                if (xhr.status === 200) {
                    $.hideLoadingNoStatus(function () {
            BindRoleDetail($('#lblRoleCode').val());          
              $("#jqgrid").jqGrid('setGridParam', {
                postData: {
                        SFC: 'Get_Role_List'
                    }
                 }).trigger("reloadGrid", [{page: 1}]);
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
//     $("#btnUpdate").click(function () {
//         
//          var RoleData = new Array();
//        $('#tbRoleFc tr').each(function (row, th) { 
//         // alert($('#tbRoleFc tr').size());
//            RoleData[row] = {
//                  "MnuCode": $('#txtMnuCode' + row).val()
//                , "MnuDesc": $('#txtMnuName' + row).val()
//                , "MnuType": $('#txtMnuType' + row).val()
//                , "MnuSeq": $('#txtMnuSeq' + row).val()
//                , "HasView": ($('#chkView_' + row).is(':checked').toString().replace("false", 0)).replace("true",1)
//                , "HasAdd": ($('#chkAdd_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
//                , "HasEdit": ($('#chkEdit_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
//                , "HasDel": ($('#chkDel_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
//                , "HasVerify": ($('#chkVerify_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
//                , "HasApprove": ($('#chkApprove_' + row).is(':checked').toString().replace("false", 0)).replace("true",1) 
//             };        
//        });
//        
//         RoleData.splice(($('#tbRoleFc tr').size() -1), 1);
//        //alert(JSON.stringify(RoleData));
//       // console.log(JSON.stringify(RoleData));
//            //c01
//            //Aaron
//            //add confirmation box and loading status 
//            showYesNo({
//               title: "Confirmation needed",
//               width: 420,
//               noClose: true,
//               isModal: true,
//               body: [
//                   "<br><h4>Please confirm the details entered.<h4><br>"
//               ],
//               show: function(){},
//               Yes:{
//                   text: "Yes",
//                   opt: function(){
//                        hideYesNo();
//                        var request = $.ajax({
//                        type: "POST",
//                        url: "${pageContext.request.contextPath}/Servlet_Role?SFC=UPDATE_ROLE",
//                        data: {
//                             ROLEITEM: JSON.stringify($('#form_RoleDetail').serializeArray()),
//                             ROLEFC: JSON.stringify(RoleData)
//
//                        },
//                        dataType: 'json',
//                        beforeSend: function () {
//                            //alert('send');
//                              $.showLoadingNoStatus();
//                        },
//                        success: function(data) {
//                            var arrReturn = data;                  
//                            $.hideLoadingNoStatus(function () {
//                                if (arrReturn.bool === true) {
//                                    $.bigBoxSuccess({
//                                        title: "Role Update.",
//                                        content: "Role Update Success.",
//                                        timeout: 6000
//                                    });
//                    
//           
//                                    BindRoleDetail($('#lblRoleCode').val());
//                                    $("#jqgrid").jqGrid('setGridParam', {
//                                    postData: {
//                                        SFC: 'Get_Role_List'
//                                    }
//                                }).trigger("reloadGrid", [{page:1}]);
//                   
//                                } 
//                                else {
//                                    $.bigBoxFail({
//                                        title: "FAILED To Update Role.",
//                                        content: "There is some error during role update.<br> Please try again...",
//                                        timeout: 6000
//                                });
//                            }
//                        },500);
//                    }
//                });
//                }
//               },
//               No:{
//                   text: "No",
//                   opt: function(){
//                       hideYesNo();
//                   }
//               }
//            });
//            });
            //c01
            //Aaron
                
//             var request = $.ajax({
//                type: "POST",
//                url: "${pageContext.request.contextPath}/Servlet_Role?SFC=UPDATE_ROLE",
//                data: {
//                     ROLEITEM: JSON.stringify($('#form_RoleDetail').serializeArray()),
//                     ROLEFC: JSON.stringify(RoleData)
//                     
//                },
//                dataType: 'json',
//                beforeSend: function () {
//                    //alert('send');
//                      $.showLoadingNoStatus();
//                },
//                success: function(data) {
//                   // alert(JSON.stringify(data));
//                    var arrReturn = data;                  
//                   // alert(arrReturn.msg);
//                   $.hideLoadingNoStatus(function () {
//                   
//                    
//                    if (arrReturn.bool === true) {
//                    $.bigBoxSuccess({
//                        title: "Role Update.",
//                        content: "Role Update Success.",
//                        timeout: 6000
//                    });
//                    
//           
//            BindRoleDetail($('#lblRoleCode').val());
//            
//              $("#jqgrid").jqGrid('setGridParam', {
//                postData: {
//                        SFC: 'Get_Role_List'
//                    }
//                 }).trigger("reloadGrid", [{page: 1}]);
//                   
//                   // location.href = "#/PurchaseOrderList";
//                } else {
//                    $.bigBoxFail({
//                        title: "FAILED To Update Role.",
//                        content: "There is some error during role update.<br> Please try again...",
//                        timeout: 6000
//                    });
//                }
//                
//                 },500);
//                 }
//            });
//            });

loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
        loadScript("js/buttonset.js", function () {
            loadScript("js/excel-export.js", function () {            
                pagefunction();
            });
        });
    });
      pageSetUp();

</script>