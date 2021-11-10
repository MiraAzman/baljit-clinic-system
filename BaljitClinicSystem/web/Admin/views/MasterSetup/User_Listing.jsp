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
</style>

<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />

<section id="widget-grid" class="">
    <!--<input type="text" id="lblUserCode" value="<%= session.getAttribute("s_usercode")%>"  class="tboxreadonlyShort"/>-->
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-file fa-2x"></i> 
            User Info                                    
        </h1>
    </div>
    <div class="row">
        <form id="form_User" name="form_User">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row" style="padding-left:20px;padding-bottom:20px;">
                <input type="button" class="btn btn-default bg-color-blueDark txt-color-white" id="btnAddUser" name="btnAddUser" value="Add New" style="margin-right:20px;"/>
            </div>
            
            <div class="row" style="padding-bottom:10px;padding-left:10px;padding-right:10px;">
                <div class="errorContainer alert alert-danger alert-block">
                    <h4 class="alert-heading">There were some field left out or invalid inputs. Please brief through the form and reenter necessarily.</h4>
                    <ol>
                    </ol>
                </div>
            </div>
            
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-2"  data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-search"></i></span>
                    <span><h2>&nbsp;Locate User Info</h2></span>
                </header>
                <div class="no-padding">
                    <div class="widget-body">
                        <div id="selectCriTab" class="tab-content">
                            <div class="tab-pane fade active in padding-5 no-padding-bottom" id="selectCriTab_s1">
                                <table id="tblSearch" class="selection-criteria">
                                    <tr>
                                        <td width="15%">User Code:</td>
                                        <td width="100%">                                            
                                            <input type="text" id="txtUserCode" name="txtUserCode"  placeholder="--Enter User Code--" class="searchbox-text" />
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td width="15%">User Name:</td>
                                        <td width="100%">                                            
                                            <input type="text" id="txtUserName" name="txtUserName"  placeholder="--Enter User Name--" class="searchbox-text" />
                                        </td>  
                                    </tr>
                                    <tr>
                                         <td colspan="6">
                                              <div align="right" class="padding-5" >
                                                <input type="submit" Id="btnSearch"  class="btn btn-default bg-color-blueDark txt-color-white"  value="Search" />
                                            </div>
                                         </td>                                        
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                                                         
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">             
                <header>
                    <span class="widget-icon"> <i class="fa fa-file"></i></span>
                    <span><h2>&nbsp;Result</h2></span>            
                </header>  
                <div>             
                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->                  
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body">
<!--                        <input type="button" href="#myModal" data-toggle="modal" value="Print Reports" class="btn btn-default bg-color-blueDark txt-color-white" />&nbsp;
                        <input type="button" id="btnMemExport" name="btnCorpExport" onclick='ExportData()' value="Export"  class="btn btn-default bg-color-blueDark txt-color-white"  style="margin-right:20px;"/>-->                                
                        <div class="table-responsive">
                            <div id="cjqgridUserMaster"></div>
                            <table id="jqgridUserMaster" class="table table-striped table-bordered"  ></table>
                            <div id="pjqgridUserMaster"></div>
                        </div>
                        <div style=" display: none;">
                            <table id="ExportPrdMaster" class="table table-striped table-bordered"   ></table>
                        </div>
                    </div>
                    <!-- end widget content -->
                </div>
            </div> 
        </article>
        </form>                             
    </div>
</section>
 <jsp:include page="../../includes/loading-no-status.jsp"/>  
<script src="js/buttonset.js"></script>
    
<script type="text/javascript">
    
    pageSetUp();
    
    $().ready(function(){
        $("#ddlLoc").prop("disabled", true);       
        $("#btnSearch").click(function(){          
            $("#wid-id-1").hide();
            Search();
        });
        
        $("#btnAddUser").click(function(){
            location.href = '#/AddNewUser';
        });
        
        $("#ddlComp").change(function(){
            $('#ddlLoc').empty();

            var sCompany = this.value;   
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/Servlet_Stock?SFC=GET_REL_LOCATION",
                data: {
                    COMPANY: sCompany
                },
                dataType: 'json',
                success: function(data) {
                    $("select#ddlLoc").append( $("<option>").val("").html("- Select Location -")); 

                    for (var a=0 ; a<data.object1.length ; a++) {                   
                        var arrData = data.object1[a];                
                        $("select#ddlLoc").append( $("<option>")
                            .val(arrData.VALUE)
                            .html(arrData.VALUE)
                        ); 
                    }
                }
            });                                                           
            $("#ddlLoc").prop("disabled", false); 
        });
    });
    
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
    };
    
    function run_jqgrid_function() {
            
            var grid = $("#jqgridUserMaster"),
                gridPager = "#p" + grid.selector.toString().substring(1),
                conDiv = $("#c" + grid.selector.toString().substring(1)),
                defaultColName =  [ 'Action', 'Code', 'Name', 'Record Status' ],
                defaultColMol = [
                    //  {name:'MEM_NRIC',index:'MEM_NRIC', sortable:true, searchoptions: { sopt: ['cn']}, formatter:'showlink',formatoptions:{baseLinkUrl:'../ProviderPortal/Prov_Patient_Detail.jsp',addParam: '',showAction:'',idName:'PMemNRIC'}},                     
                    {name: 'details', index: 'details', formatter: viewDetail,  search: false, sortable: false, width: 120, align:'center',must: true, hidedlg: true},
                    {name: 'usr_code', index: 'usr_code', sortable: true, must: true, hidedlg: true, width: 120},
                    {name: 'usr_name', index: 'usr_name', sortable: true, must: true, hidedlg: true, width: 220},
                    {name: 'usr_recstatus', index: 'usr_recstatus', sortable: true, width: 120}
                ],
              
                mainGridName = grid.selector.toString().substring(1),
                //temp = readSettings({settingArray:${sessionScope.settings}, defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName});//,
                temp = readSettings({settingArray:"admin", defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName}),
              currentColName = temp[0],
              currentColMol = temp[1];
       // alert(JSON.stringify(temp));
        grid.jqGrid({
            url: '${pageContext.request.contextPath}/Servlet_User',
                postData: {
                    SFC: 'GET_USER_LIST', 
                    CODE: $('#txtUserCode').val(),
                    NAME: $('#txtUserName').val(),
                    COMPANY: $('#ddlComp').val(),
                    LOCATION: $('#ddlLoc').val()
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
            sortname: 'usr_code',
            viewrecords: true,
            sortorder: 'asc',
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
        
        function viewDetail(cellvalue, options, rowObject) {
            //return "<a  target='_self' class='btn btn-default bg-color-blueDark txt-color-white' title='Member Detail' href='#/MemberDetail/" + rowObject.MEM_ID + "/" + rowObject.MEM_CorpCode + "'>View Details</a>";         
            return"<a style='cursor: pointer;' title='View Details' href='#/UserDetail/" + rowObject.usr_code +  "'><i class='fa fa-fw fa-lg fa-list-alt' /></a>";  
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
        //quickSetupChooser({grid: grid, defaultColMol: defaultColMol, settingName: mainGridName,
        //settingArray:${sessionScope.settings},
        quickSetupChooser({grid: grid, defaultColMol: defaultColMol, settingName: mainGridName,
            settingArray:"admin",
            done: function () {
                resizeWidth({grid: grid, gridDiv: conDiv});
            }
        });
        grid.jqGrid('setGridWidth', conDiv.width());
        };//END OF run_jqgrid_function 

    function Search() {      
        $("#wid-id-1").show();
        $("#jqgridUserMaster").jqGrid('setGridParam', {
            postData: {
                SFC: 'GET_USER_LIST',    
                CODE: $('#txtUserCode').val(),
                NAME: $('#txtUserName').val(),
                COMPANY: $('#ddlComp').val(),
                LOCATION: $('#ddlLoc').val()
            }
        }).trigger("reloadGrid", [{page: 1}]);       
    }
    
    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
        loadScript("js/buttonset.js", function () {
            loadScript("js/excel-export.js", function () {
                pagefunction();
            });
        });
    });
                         
    pageSetUp();
   
</script>