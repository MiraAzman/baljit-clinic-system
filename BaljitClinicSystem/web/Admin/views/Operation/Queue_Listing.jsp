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
            <i class="fa-fw fa fa-list fa-2x"></i> 
            Registration Queue                                  
        </h1>
    </div>
    <div class="row">
        <form id="form_User" name="form_User">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                                              
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-1"  data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false">             
                <header>
                    <span class="widget-icon"> <i class="fa fa-file"></i></span>
                    <span><h2>&nbsp;Queue List</h2></span>            
                </header>  
                <div>             
                    <!-- widget edit box -->
                    <div class="jarviswidget-editbox">
                        <!-- This area used as dropdown edit box -->                  
                    </div>
                    <!-- end widget edit box -->

                    <!-- widget content -->
                    <div class="widget-body">                           
                        <div class="table-responsive">
                            <div id="cjqgridQueueList"></div>
                            <table id="jqgridQueueList" class="table table-striped table-bordered"  ></table>
                            <div id="pjqgridQueueList"></div>
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
        $("#btnSearch").click(function(){          
            $("#wid-id-1").hide();
            Search();
        });
        
        $("#btnAddCorporate").click(function(){
            location.href = '#/AddNewCorporate';
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
            
        var grid = $("#jqgridQueueList"),
            gridPager = "#p" + grid.selector.toString().substring(1),
            conDiv = $("#c" + grid.selector.toString().substring(1)),
            defaultColName =  ['INDEX','PATIENT_INDEX','Status','Patient Name','Patient IC','Time In','Time Out','Action'],
            defaultColMol = [                    
                //{name: 'details', index: 'details', formatter: viewDetail,  search: false, sortable: false, width: 80, align:'center',must: true, hidedlg: true},
                {name: 'qu_id', index: 'qu_id', hidden:true},
                {name: 'pt_id', index: 'pt_id', hidden:true},
                {name: 'qu_status', index: 'qu_status', sortable: true, must: true, hidedlg: true, width: 100, formatter: formatColor},
                {name: 'pt_name', index: 'pt_name', sortable: true, must: true, hidedlg: true, width: 200},
                {name: 'pt_icno', index: 'pt_icno', sortable: true, width: 120},
                {name: 'qu_timein', index: 'qu_timein', sortable: true, width: 100},
                {name: 'qu_timeout', index: 'qu_timeout', sortable: true, width: 100},
                {name: 'action', index: 'action', formatter: ActionButton, search: false, sortable: false, width: 80, align:'center',must: true, hidedlg: true}
            ],

            mainGridName = grid.selector.toString().substring(1),
            temp = readSettings({settingArray:"admin", defaultColName: defaultColName, defaultColMol: defaultColMol, settingName: mainGridName}),
          currentColName = temp[0],
          currentColMol = temp[1];

        grid.jqGrid({
            url: '${pageContext.request.contextPath}/Servlet_Queue',
                postData: {
                    SFC: 'GET_QUEUE_LIST'
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
            return"<a style='cursor: pointer;' title='View Details' href='#/CorporateDetail/" + rowObject.cp_id +  "'><i class='fa fa-fw fa-lg fa-list-alt' /></a>";  
        }
        
        function ActionButton(cellvalue, options, rowObject) {
            
            if ((rowObject.qu_status === 'REGISTERED') || (rowObject.qu_status === 'CONSULTATION')) {
                return "<input type='button' id='btnAction' class='btn btn-primary' value='Start Consultation' onclick='ProceedToPage(\"Consultation\",\"" + rowObject.qu_id + "\",\"" + rowObject.pt_id + "\");'/> "; 
            }
            else if (rowObject.qu_status === 'BILLING') {
                return "<input type='button' id='btnAction' class='btn btn-primary' value='Start Billing' onclick='ProceedToPage(\"Billing\",\"" + rowObject.qu_id + "\",\"" + rowObject.pt_id + "\");'/>"; 
            }
            else if (rowObject.qu_status === 'COMPLETED') {
                return "<input type='button' id='btnAction' class='btn btn-default' value='Print Receipt' onclick='ProceedToPage(\"Receipt\",\"" + rowObject.qu_id + "\",\"" + rowObject.pt_id + "\");'/>"; 
            }
            else {
                return "";
            }
        }
        
        function formatColor(val, row) {
            if (val === 'REGISTERED') {
                return '<span style="color:#27D500;"><b>REGISTERED</b><span>';
            }
            else if (val === 'CONSULTATION') {
                return '<span style="color:#FFA027"><b>CONSULTATION</b></span>';
            }
            else if (val === 'BILLING') {
                return '<span style="color:#277FFF;"><b>BILLING</b></span>';
            }
            else if (val === 'COMPLETED') {
                return '<span style="color:#F631FF;"><b>COMPLETED</b></span>';
            }
            else {
                return val;
            }
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
    
    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
        loadScript("js/buttonset.js", function () {
            loadScript("js/excel-export.js", function () {
                pagefunction();
            });
        });
    });
    
    function ProceedToPage(page, qu_id, pt_id) {
        if (page === 'Consultation') {
            location.href = "#/Consultation/"+qu_id+"/"+pt_id;
        }
        else if (page === 'Billing') { 
            location.href = "#/Billing/"+qu_id;
        }
        else if (page === 'Receipt') { 
            LoadPrintPreview(qu_id);
        }
    }
    
    function LoadPrintPreview(qu_id) {
    
        var jasperFile = "Receipt";
        
        loadScript("js/print-preview.js", function () {
            var jObj = {              
                1: "GENERATE_RECEIPT",
                2: qu_id, 
                3: "", 
                4: ""
            };
 
            var param = {};           
//            alert(JSON.stringify(jObj));               
            var object = {};
            object.procParam = jObj;
            object.jasperName = jasperFile;
            object.procString = 'SP_GET_BILLING(?,?,?,?)';
            object.fixParam = param;
            object.format = 'pdf';  //indicate which format is being used
            
            printToPage(object);     
        });      
    };
   
</script>