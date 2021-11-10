<script type="text/javascript">

    function showDrug(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Provider Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchProviderCode' class='searchbox-text' type='text' placeholder='Search Provider Code'></td><td><input id='txtSearchProviderName' type='text' class='searchbox-text' placeholder='Search Provider Name'></td><td>" +
                "<a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                    PRVCODE: $(myWindows.document).find('#txtSearchProviderCode').val(),
                    PRVNAME: $(myWindows.document).find('#txtSearchProviderName').val(),
                    CPPCODE: '${sessionScope.cppcode}'
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_Drug2',
            postData: {SFC: "Get_DrugItem_List"},
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Drug Code', 'Drug List Code', 'Drug Name', 'Drug Dosage', 'Drug Freq', 'Drug Price'],
            colModel: [
                {name: 'DI_DGCODE', index: 'DI_DGCODE', sortable: true, searchoptions: {sopt: ['cn']}, formatter: formateadorLink},
                {name: 'DI_DGLSTCODE', index: 'DI_DGLSTCODE', sortable: true, searchoptions: {sopt: ['cn']}},
                {name: 'DI_DGNAME', index: 'DI_DGNAME', sortable: true, stype: 'select'},
                {name: 'DI_DGDOSAGE', index: 'DI_DGDOSAGE', sortable: true, search: false},
                {name: 'DI_DGFREQ', index: 'DI_DGFREQ', sortable: false, search: false},
                {name: 'DI_DGPRICE', index: 'DI_DGPRICE', sortable: false, search: false}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'DI_DGNAME',
            viewrecords: true,
            sortorder: "desc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };
        function formateadorLink(cellvalue, options, rowObject) {
            //return "<a target=_blank href=../../ProviderPortal/Prov_Patient_Detail.jsp?PMemNRIC="+ cellvalue + ">" + cellvalue + "</a>";
            // return "<a target=_self href=../NewDesign/views/PatientDetail.jsp?PMemNRIC="+ cellvalue + ">" + cellvalue + "</a>";
            //return "<nav:item data-view=/PatientDetail  title=Patient Detail >" + cellvalue + "</nav>";
            // return "<a target=_self href=#/PatientDetail/" + cellvalue + ">" + cellvalue + "</a>";
            return '<a target="_self" style="text-decoration: none; cursor:pointer;" onclick="getDrugDetail(\'' + cellvalue + '\',\'' + rowObject.DI_DGNAME + '\',\'' + rowObject.DI_DGDOSAGE + '\',\'' + rowObject.DI_DGFREQ + '\',\'' + rowObject.DI_DGPRICE + '\');">' + cellvalue + '</a>';


            // return  "<a href=# id=modal_link class=btn bg-color-purple txt-color-white>" + cellvalue + "</a>";
        }
        return sReturn;

    }

    function showMedicine(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-medkit fa-2x"></i> ' +
                'Medicine Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtName' type='text' class='searchbox-text' placeholder='Search Medicine Name'></td>" +
                "<td><a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                    NAME:  $(myWindows.document).find('#txtName').val()                   
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_Medicine',
            postData: {SFC: "GET_MEDICINE_LIST"},
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Action','Medicine Name','Unit of Measurement','Unit Cost','Price','Expiry Date','Qty','INDEX'],
            colModel: [
                {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                {name: 'md_name', index: 'md_name', sortable: true, must: true, hidedlg: true, width: 200},
                {name: 'md_uom', index: 'md_uom', sortable: true, must: true, hidedlg: true, width: 100},
                {name: 'md_unitcost', index: 'md_unitcost', sortable: true, must: true, hidedlg: true, width: 100},
                {name: 'md_price', index: 'md_price', sortable: true, must: true, hidedlg: true, width: 100},
                {name: 'md_expirydate', index: 'md_expirydate', sortable: true, width: 100},
                {name: 'md_qty', index: 'md_qty', sortable: true, width: 80},
                {name: 'md_id', index: 'md_id', hidden:true}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: '',
            viewrecords: true,
            sortorder: "desc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };
       
        return sReturn;

    }

    function showProduct(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Product Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchStockCode' class='searchbox-text' type='text' placeholder='Search Stock Code'></td><td><input id='txtSearchStockName' type='text' class='searchbox-text' placeholder='Search Stock Name'></td><td>" +
                "<a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                PRDCODE: $(myWindows.document).find('#txtSearchStockCode').val(),
                PRDNAME:  $(myWindows.document).find('#txtSearchStockName').val()                   
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_Stock',
            postData: {SFC: "GET_PRODUCT_LIST"},
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Action','Product Code', 'Product Desc', 'Category', 'Group', 'Type', 'UOM', 'GST Pur Code', 'Tax Rate', 'cost', 'StockIdx'],
            colModel: [
                 {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                {name: 'stk_stockcode', index: 'stk_stockcode', sortable: true, must: true, hidedlg: true, width: 120},
                {name: 'stk_desc', index: 'stk_desc', sortable: true, must: true, hidedlg: true, width: 220},
                {name: 'stk_consumable', index: 'stk_consumable', sortable: true, width: 120},
                {name: 'stk_groupcode', index: 'stk_groupcode', sortable: true, width: 120},
                {name: 'stk_typecode', index: 'stk_typecode', sortable: true, width: 120},
                {name: 'stk_baseuomcode', index: 'stk_baseuomcode', sortable: true, width: 120},
                {name: 'stk_gstpurcode', index: 'stk_gstpurcode', sortable: true, width: 120},
                {name: 'gst_taxrate', index: 'gst_taxrate', sortable: true, width: 120},
                {name: 'stk_unitcost', index:'stk_unitcost', hidden: true},
                {name: 'stk_stockidx', index:'stk_stockidx', hidden: true}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'stk_stockcode',
            viewrecords: true,
            sortorder: "desc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };
       
        return sReturn;

    }
    
    function showProductGrp(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Product Group Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchStockGrpCode' class='searchbox-text' type='text' placeholder='Search Product Group Code'></td>" +
                "<td><input id='txtSearchStockGrpDesc' type='text' class='searchbox-text' placeholder='Search Product Group Desc'></td><td>" +
                "<a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                    TYPE: "STKGRP",
                    CODE: $(myWindows.document).find('#txtSearchStockGrpCode').val(),
                    DESC: $(myWindows.document).find('#txtSearchStockGrpDesc').val() 
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_Stock',
            postData: {
                SFC: "GET_STOCKCODE_LIST",
                TYPE: "STKGRP",
                CODE: $(myWindows.document).find('#txtSearchStockGrpCode').val(),
                DESC: $(myWindows.document).find('#txtSearchStockGrpDesc').val()
            },
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Action','Product Group Code', 'Product Group Desc', 'Status'],
            colModel: [
                {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                {name: 'cd_cdcode', index: 'cd_cdcode', sortable: true, must: true, hidedlg: true, width: 200},
                {name: 'cd_cddesc', index: 'cd_cddesc', sortable: true, must: true, hidedlg: true, width: 270},
                {name: 'recstatus', index: 'recstatus', sortable: true, width: 150, formatter: formatColor}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'cd_cddesc',
            viewrecords: true,
            sortorder: "asc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };
        function formatColor(val, row) {
            if (val === '1') { 
                return '<span style="color:#008000;"><b>Active</b><span>'; 
            }
            else if (val === '0') {
                return '<span style="color:#000099;"><b>Inactive</b></span>';
            }
            else {
                return val;
            }
        }
        return sReturn;
    }
    
    function showProductType(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Product Type Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchStockTypeCode' class='searchbox-text' type='text' placeholder='Search Product Type Code'></td>" +
                "<td><input id='txtSearchStockTypeDesc' type='text' class='searchbox-text' placeholder='Search Product Type Desc'></td><td>" +
                "<a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                    TYPE: "STKTYP",
                    CODE: $(myWindows.document).find('#txtSearchStockTypeCode').val(),
                    DESC: $(myWindows.document).find('#txtSearchStockTypeDesc').val() 
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_Stock',
            postData: {
                SFC: "GET_STOCKCODE_LIST",
                TYPE: "STKTYP",
                CODE: $(myWindows.document).find('#txtSearchStockTypeCode').val(),
                DESC: $(myWindows.document).find('#txtSearchStockTypeDesc').val()
            },
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Action','Product Type Code', 'Product Type Desc', 'Status'],
            colModel: [
                {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                {name: 'cd_cdcode', index: 'cd_cdcode', sortable: true, must: true, hidedlg: true, width: 200},
                {name: 'cd_cddesc', index: 'cd_cddesc', sortable: true, must: true, hidedlg: true, width: 270},
                {name: 'recstatus', index: 'recstatus', sortable: true, width: 150, formatter: formatColor}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'cd_cddesc',
            viewrecords: true,
            sortorder: "asc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };
        function formatColor(val, row) {
            if (val === '1') { 
                return '<span style="color:#008000;"><b>Active</b><span>'; 
            }
            else if (val === '0') {
                return '<span style="color:#000099;"><b>Inactive</b></span>';
            }
            else {
                return val;
            }
        }
        return sReturn;
    }
    
    function showCHGItemHIS(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Item Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchCHGCode' class='searchbox-text' type='text' placeholder='Search Item Code'></td>" +
                "<td><input id='txtSearchCHGName' type='text' class='searchbox-text' placeholder='Search Item Name'></td><td>" +
                "<a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                CHGCODE: $(myWindows.document).find('#txtSearchCHGCode').val(),
                CHGDESC:  $(myWindows.document).find('#txtSearchCHGName').val()                   
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_ChargeItem',
            postData: {SFC: "GET_CHGITEM_HIS"},
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Action','Item Code', 'Item Desc', 'Category', 'UOM', 'Charge Group'],
            colModel: [
                 {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                {name: 'bld_chgcode', index: 'bld_chgcode', sortable: true, must: true, hidedlg: true, width: 150},
                {name: 'bld_chgdesc', index: 'bld_chgdesc', sortable: true, must: true, hidedlg: true, width: 250},
                {name: 'bld_category', index: 'bld_category', sortable: true, width: 120},
                {name: 'bld_uom', index: 'bld_uom', sortable: true, width: 120},
                {name: 'bld_chggrp', index: 'bld_chggrp', sortable: true, width: 120}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'bld_chgdesc',
            viewrecords: true,
            sortorder: "asc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };      
        return sReturn;
    }
    
    function showCHGGroupHIS(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Charge Group Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchCHGGrpCode' class='searchbox-text' type='text' placeholder='Search Charge Group Code'></td>" +
                "<td><input id='txtSearchCHGGrpDesc' type='text' class='searchbox-text' placeholder='Search Charge Group Name'></td>" +
                "<td><a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";
        myWindows.reload = function () {
            myWindows.refresh({
                postData: {
                CHGGROUPCODE: $(myWindows.document).find('#txtSearchCHGGrpCode').val(),
                CHGGROUPDESC: $(myWindows.document).find('#txtSearchCHGGrpDesc').val()
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_ChargeItem',
            postData: {SFC: "GET_CHGGROUP_HIS"},
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Action','Charge Group Code', 'Charge Group Desc'],
            colModel: [
                {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                {name: 'bld_chggrp', index: 'bld_chggrp', sortable: true, must: true, hidedlg: true, width: 150},
                {name: 'cd_cddesc', index: 'cd_cddesc', sortable: true, must: true, hidedlg: true, width: 250}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'cd_cddesc',
            viewrecords: true,
            sortorder: "asc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };      
        return sReturn;
    }
    
     function showSupplier(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'Supplier Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td><input id='txtSearchSuppCode' class='searchbox-text' type='text' placeholder='Search Supplier Code'></td><td><input id='txtSearchSuppName' type='text' class='searchbox-text' placeholder='Search Supplier Name'></td><td>" +
                "<a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                postData: {                            
                    SUPCODE: $(myWindows.document).find('#txtSearchSuppCode').val(),
                    SUPNAME: $(myWindows.document).find('#txtSearchSuppName').val()                
                }
            });
        };
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_Supplier',
            postData: {SFC: "GET_SUPPLIER_LIST"},
            datatype: 'json',
            mtype: 'POST',
            colNames: [ 'Action', 'Supplier Code','Supplier Desc','Category','State', 'Country', 'Status' ],
            colModel: [
                 {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                
                {name: 'sup_code', index: 'sup_code', sortable: true, must: true, hidedlg: true, width: 120},
                {name: 'sup_name', index: 'sup_name', sortable: true, must: true, hidedlg: true, width: 220},
                {name: 'sup_productgroupcode', index: 'sup_productgroupcode', sortable: true, width: 120},
                {name: 'sup_statecode', index: 'sup_statecode', sortable: true, width: 120},
                {name: 'sup_countrycode', index: 'sup_countrycode', sortable: true, width: 120},
                {name: 'sup_isactive', index: 'sup_isactive', sortable: true, width: 120}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'sup_code',
            viewrecords: true,
            sortorder: "desc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };
       
        return sReturn;

    }

    function showGRN(objIn) {
        var sReturn = $.Deferred(), windowsSize = "width=" + objIn.width + ", height=" + objIn.height,
                myWindows = window.open("${pageContext.request.contextPath}/includes/PopUpWindows.jsp", "", windowsSize);
        myWindows.header = '<div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">' +
                '<h1 class="page-title txt-color-blueDark">' +
                '<i onclick="" class="fa-fw fa fa-user-md fa-2x"></i> ' +
                'GRN Selection' +
                '</h1>' +
                '</div>';
        myWindows.selection = "<table class='selection-criteria'><tr><td colspan='2'><input id='txtSearchGRN' class='searchbox-text' type='text' placeholder='Search GRN Number'></td></tr> " + 
                "<tr><td width='35%'><input id='txtSearchGRNDateFr' name='txtSearchGRNDateFr' type='text' class='searchbox-date' placeholder='Search GRN Date From (yy-mm-dd)' style='margin-right:20px;'>" +
                "<input id='txtSearchGRNDateTo' type='text' class='searchbox-date' placeholder='Search GRN Date To (yy-mm-dd)'></td></tr>" +
                "<tr><td colspan='2'><a class='btn btn-default bg-color-blueDark txt-color-white' onclick='reload()'>Search</a></td>" +
                "</tr></table>";

        myWindows.reload = function () {
            myWindows.refresh({
                //alert("refresh");
                postData: {
                    GRNNUM: $(myWindows.document).find('#txtSearchGRN').val(),
                    GRNDATEFR: $(myWindows.document).find('#txtSearchGRNDateFr').val(),
                    GRNDATETO: $(myWindows.document).find('#txtSearchGRNDateTo').val(),
                    METHOD: "HEADER"
                } 
            });
        };
        
        myWindows.object2 = "#txtSearchGRNDateFr,#txtSearchGRNDateTo"; //LLT 2016-05-25
        
        myWindows.object = {
            url: '${pageContext.request.contextPath}/Servlet_GRN',
            postData: {SFC: "GET_GRN_LIST", METHOD: "HEADER", COMP: '<%= session.getAttribute("CompCode")%>'}, //LLT 2016-05-24
            datatype: 'json',
            mtype: 'POST',
            colNames: [ 'Action','GRN No.','Supplier Code','Supplier Desc','Company','GRN Date','Status','id','Location','Ref No','Ref Date',
                        'Inv No','Inv Date','DO No','DO Date','Remark','GST Inc','Intersupplier'],
            colModel: [
                 {name: 'select', formatter: function (val, row) {
                        return "<a style='cursor:pointer;' id='select'>Select</a>";
                    }
                },
                
                {name: 'GRN_No', index: 'GRN_No', sortable: true, must: true, hidedlg: true, width: 120},
                {name: 'GRN_SupCode', index: 'GRN_SupCode', sortable: true, must: true, hidedlg: true, width: 120},
                {name: 'GRN_SupDesc', index: 'GRN_SupDesc', sortable: true, width: 220},
                {name: 'GRN_Company', index: 'GRN_Company', sortable: true, width: 120},
                {name: 'GRN_Date', index: 'GRN_Date', sortable: true, width: 120},
                {name: 'GRN_Status', index: 'GRN_Status', sortable: true, width: 120},
                {name: 'sgrh_grnhdridx', index: 'sgrh_grnhdridx', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_location', index: 'sgrh_location', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_refno', index: 'sgrh_refno', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_refdate', index: 'sgrh_refdate', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_invno', index: 'sgrh_invno', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_invdate', index: 'sgrh_invdate', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_dono', index: 'sgrh_dono', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_dodate', index: 'sgrh_dodate', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_remark', index: 'sgrh_remark', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_isgstinclusive', index: 'sgrh_isgstinclusive', sortable: true, width: 120, hidden: true},
                {name: 'sgrh_intersupplier', index: 'sgrh_intersupplier', sortable: true, width: 120, hidden: true}
            ],
            rowNum: 20,
            rowList: [10, 20, 30, 50, 100],
            pager: '#pjqgrid',
            sortname: 'GRN_No',
            viewrecords: true,
            sortorder: "desc",
            toolbarfilter: true,
            autowidth: true,
            shrinkToFit: true,
            loadonce: false,
            height: 'auto',
            beforeSelectRow: function (rowid, e) {
                var rowData = $(this).jqGrid('getRowData', rowid);
                sReturn.resolve(rowData);
                myWindows.close();
            }
        };        
       
        return sReturn;

    }


</script>