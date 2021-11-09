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
</style>
<link rel="stylesheet" type="text/css" href="css/your_style.css" />
<link rel="stylesheet" type="text/css" href="js/plugin/jqgrid/ui.multiselect.css" />

<section id="widget-grid" class="">
    <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
        <h1 class="page-title txt-color-blueDark">
            <!-- PAGE HEADER -->
            <i class="fa-fw fa fa-users fa-2x"></i> 
            Patient List                                   
        </h1>
    </div>
    <div class="row">
        <form id='form_MemberSearch'>
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row" style="padding-left:20px;padding-bottom:20px;">
                <input type="button" class="btn btn-default bg-color-blueDark txt-color-white" id="btnAddPatient" name="btnAddPatient" onclick="location.href = '#/AddPatient'" value="Add New Patient" style="margin-right:20px;"/>
            </div> 
            
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-2"  data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">
                <header>
                    <span class="widget-icon"> <i class="fa fa-search"></i></span>
                    <span><h2>&nbsp;Search Patient</h2></span>
                </header>
                <div class="no-padding">
                    <div class="widget-body">
                        <div id="selectCriTab" class="tab-content">
                            <div class="tab-pane fade active in padding-5 no-padding-bottom" id="selectCriTab_s1">
                                <table id="tblSearch" class="selection-criteria">
                                    <tr>
                                        <td width="15%">Name:</td>
                                        <td width="100%">                                            
                                            <input type="text" id="txtName" name="txtName" class="searchbox-text" placeholder="--Enter Patient Name--"/>
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td>IC/Passport No:</td>
                                        <td>                                            
                                            <input type="text" id="txtICNo" name="txtICNo" class="searchbox-text" placeholder="--Enter Patient IC/Passport No.--"/>
                                        </td>  
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <div align="right" class="padding-5" >
                                                <input type="submit" Id="btnSearch" class="btn btn-default bg-color-blueDark txt-color-white" value="Search" onclick="Search();"/>
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
                    <h2>Result</h2>
                </header>  
                <div>
             
                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">    
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body">                               
                        <div class="table-responsive">
                            <div id="cjqgridPatientList"></div>
                            <table id="jqgridPatientList" class="table table-striped table-bordered"  ></table>
                            <div id="pjqgridPatientList"></div>
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
<jsp:include page="../../../includes/loading-no-status.jsp"/>  
<jsp:include page="../../../includes/PopUpInitPage.jsp"/>
<jsp:include page="../../../includes/yes-no.jsp"/>
<script type="text/javascript">
   
    pageSetUp();

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
            
            var grid = $("#jqgridPatientList"),
                gridPager = "#p" + grid.selector.toString().substring(1),
                conDiv = $("#c" + grid.selector.toString().substring(1)),
                defaultColName =  ['View','Full Name','IC/Passport No.','Date of Birth','Contact No.','Patient ID','Register'],
                defaultColMol = [                    
                    {name: 'details', index: 'details', formatter: viewDetail,  search: false, sortable: false, width: 50, align:'center',must: true, hidedlg: true},
                    {name: 'pt_name', index: 'pt_name', sortable: true, must: true, hidedlg: true, width: 200},
                    {name: 'pt_icno', index: 'pt_icno', sortable: true, must: true, hidedlg: true, width: 150},
                    {name: 'pt_dob', index: 'pt_dob', sortable: true, width: 100},
                    {name: 'pt_contactno', index: 'pt_contactno', sortable: true, width: 100},
                    {name: 'pt_id', index: 'pt_id', hidden:true},
                    {name: 'addToQueue', index: 'addToQueue', formatter: addToQueue, search: false, sortable: false, width: 80, align:'center',must: true, hidedlg: true}
                ],             
                mainGridName = grid.selector.toString().substring(1),
                temp = readSettings({settingArray:"admin", defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName}),
              currentColName = temp[0],
              currentColMol = temp[1];
        grid.jqGrid({
            url: '${pageContext.request.contextPath}/Servlet_Patient',
                postData: {
                    SFC: 'GET_PATIENT_LIST',
                    NAME: "",
                    IC_NO: ""
                },
            datatype: "json",
            mtype: 'POST',
            colNames: currentColName,
            colModel: currentColMol,
            rownumbers: true,
            gridview: true,
            rownumWidth: 40,
            rowNum: 20,
            rowList: [10, 20, 25, 30, 50, 100],
            pager: gridPager,
            sortname: 'stk_stockcode',
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
            return "<a style='cursor: pointer;' title='View Details' href='#/PatientDetail/" + rowObject.pt_id +  "'><i class='fa fa-fw fa-lg fa-list-alt' /></a>";              
        }
        
        function addToQueue(cellvalue, options, rowObject) {
            return "<input type='button' id='btnRegister' class='btn btn-primary' value='Add To Queue' onclick='AddToQueue(\"" + rowObject.pt_id + "\");'/>";              
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

    function Search() {
        $("#jqgridPatientList").jqGrid('setGridParam', {
            postData: {
                SFC: 'GET_PATIENT_LIST',              
                NAME: $('#txtName').val(),
                IC_NO: $('#txtICNo').val()
            }
        }).trigger("reloadGrid", [{page: 1}]);
    }

    function AddToQueue(pt_id) {
        showYesNo({
            title: "Confirmation needed",
            width: 420,
            noClose: true,
            isModal: true,
            body: [
               "<br><h4>Confirm to register the patient?<h4><br>"
            ],
            show: function(){},
            Yes: {
                text: "Yes",
                opt: function(){
                    AddPatientToQueue(pt_id);
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
    }
    
    function AddPatientToQueue(pt_id) {
        
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/Servlet_Queue?SFC=UPDATE_QUEUE",
            data: {
                METHOD: "INSERT",
                PATIENT_ID: pt_id  
            },
            dataType: 'json',
            success: function(response, status, xhr) {
                $.bigBoxSuccess({
                    title: "Register Patient SUCCESS.",
                    content: "",
                    timeout: 6000
                });
            },
            error: function (xhr, status, error) {
                $.bigBoxFail({
                    title: "Transaction ERROR",
                    content: "There is some error occur during data transfer. Please try again later",
                    timeout: 6000
                });
            }
        });
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
