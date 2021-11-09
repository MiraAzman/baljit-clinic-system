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
            <i class="fa-fw fa fa-calendar-o fa-2x"></i> 
            Appointment List                                   
        </h1>
    </div>
    <div class="row">
        <form id='form_MemberSearch'>
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row" style="padding-left:20px;padding-bottom:20px;">
                <input type="button" class="btn btn-default bg-color-blueDark txt-color-white" id="btnAddPatient" name="btnAddPatient" onclick="location.href = '#/AddAppointment'" value="Create New Appointment" style="margin-right:20px;"/>
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
                            <div id="cjqgridPrdMaster"></div>
                            <table id="jqgridPrdMaster" class="table table-striped table-bordered"  ></table>
                            <div id="pjqgridPrdMaster"></div>
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
<script src="js/buttonset.js"></script>
<script type="text/javascript">
   
    pageSetUp();
    $('#rdPrdCat').buttonset();

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
            
            var grid = $("#jqgridPrdMaster"),
                gridPager = "#p" + grid.selector.toString().substring(1),
                conDiv = $("#c" + grid.selector.toString().substring(1)),
                defaultColName =  [ 'View', 'Patient Name','Doctor Name','Appointment Date','Start Time','End Time','Appointment ID'],
                defaultColMol = [                    
                    {name: 'details', index: 'details', formatter: viewDetail,  search: false, sortable: false, width: 80, align:'center',must: true, hidedlg: true},
                    {name: 'pt_name', index: 'pt_name', sortable: true, must: true, hidedlg: true, width: 200},
                    {name: 'doc_name', index: 'doc_name', sortable: true, must: true, hidedlg: true, width: 200},
                    {name: 'app_date', index: 'app_date', sortable: true, width: 100},
                    {name: 'app_starttime', index: 'app_starttime', sortable: true, width: 100},
                    {name: 'app_endtime', index: 'app_endtime', sortable: true, width: 100},
                    {name: 'app_id', index: 'app_id', sortable: true, width: 100, hidden:true}
                ],             
                mainGridName = grid.selector.toString().substring(1),
                temp = readSettings({settingArray:"admin", defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName}),
              currentColName = temp[0],
              currentColMol = temp[1];
        grid.jqGrid({
            url: '${pageContext.request.contextPath}/Servlet_Appointment',
                postData: {
                    SFC: 'GET_APPOINTMENT_LIST'              
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
            return"<a style='cursor: pointer;' title='View Details' href='#/AppointmentDetail/" + rowObject.app_id +  "'><i class='fa fa-fw fa-lg fa-list-alt' /></a>";              
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

        //alert($('#ddlCorp').val());
        $("#jqgridPrdMaster").jqGrid('setGridParam', {
            postData: {
                SFC: 'GET_PRODUCT_LIST',               
                PRDCODE: $('#txtPrdCode').val(),
                PRDNAME: $('#txtPrdDesc').val(),
                PRDGRPFROM: $('#ddlPrdGrpFrom').val(),
                PRDGRPTO: $('#ddlPrdGrpTo').val(),
                PRDTYPFROM: $('#ddlPrdTypeFrom').val(),
                PRDTYPTO: $('#ddlPrdTypeTo').val(),
                PRDCAT: $('input[name=rdPrdCat]:checked').val()
            }
        }).trigger("reloadGrid", [{page: 1}]);
    }

    
     loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
        loadScript("js/buttonset.js", function () {
            loadScript("js/excel-export.js", function () {
             
               // $('#rdCCStatus').buttonset();
                //$('#chkpayStatus').buttonset();
               // $('#rdEmpDep').buttonset();
                pagefunction();
            });
        });
    });
    pageSetUp();

</script>
