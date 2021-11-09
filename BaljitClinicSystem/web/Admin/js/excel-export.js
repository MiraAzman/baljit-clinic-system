function Custom_Export_Excel(objIn) {
    var $tableIn = objIn.exportGrid, $tableRef = objIn.grid, servletURL = objIn.url, paramPostData = objIn.postData, paramColNames = objIn.colName, paramColModel = objIn.colModel, fileName = objIn.fileName;
    var finalColNames = [], finalColModel = [];
    $.showLoadingNoStatus();
//    if ($('#loadingModal').length) {
//        $('#loadingModal').modal('show');
//    } else {
//        alert("#loadingModal is NOT Exists in current page or index.jsp");
//        return;
//    }

    servletURL = $.isEmptyObject(servletURL) ? $tableRef.jqGrid('getGridParam', 'url') : servletURL;
    paramColNames = $.isEmptyObject(paramColNames) ? JSON.parse(JSON.stringify($tableRef.jqGrid('getGridParam', 'colNames'))) : paramColNames;
    paramColModel = $.isEmptyObject(paramColModel) ? JSON.parse(JSON.stringify($tableRef.jqGrid('getGridParam', 'colModel'))) : paramColModel;

    if ($tableRef.jqGrid('getGridParam', 'rownumbers')) {
        paramColNames.splice(0, 1);
        paramColModel.splice(0, 1);
    }
    if ($tableRef.jqGrid('getGridParam', 'multiselect')) {
        paramColNames.splice(0, 1);
        paramColModel.splice(0, 1);
    }
    if ($tableRef.jqGrid('getGridParam', 'subGrid')) {
        paramColNames.splice(0, 1);
        paramColModel.splice(0, 1);
    }
    var aryMolLength = paramColModel.length;
    for (var i = 0; i < aryMolLength; i++) {
        var tempObj = paramColModel[i];
        if ((typeof tempObj.export == 'undefined' || tempObj.export == true) && tempObj.hidden == false) {
            finalColModel.push(tempObj);
            finalColNames.push(paramColNames[i]);
        }
    }
    loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", Bind_Export_Table);
//    $('#loadingModal').modal('hide');
    function Bind_Export_Table() {
        if (!($tableIn[0].grid)) {
            $tableIn.jqGrid({url: servletURL, postData: paramPostData, datatype: "json", mtype: 'POST', colNames: finalColNames, colModel: finalColModel, rowNum: -1, sortname: $tableRef.jqGrid('getGridParam', 'sortname'), viewrecords: true, sortorder: $tableRef.jqGrid('getGridParam', 'sortorder'), shrinkToFit: true, loadonce: false, height: 'auto', loadComplete: function () {
                    if (ExportExcel($tableIn, fileName)) {
                        $.hideLoadingNoStatus(function () {
                        }, 1000);
                    } else {
                        $.hideLoadingNoStatus(function () {
                        }, 1000);
                    }
                }});
//        $tableIn.jqGrid('GridUnload');
        } else {
            $tableIn.jqGrid('setGridParam', {url: servletURL, postData: paramPostData, datatype: "json", mtype: 'POST', colNames: finalColNames, colModel: finalColModel, rowNum: -1, sortname: $tableRef.jqGrid('getGridParam', 'sortname'), viewrecords: true, sortorder: $tableRef.jqGrid('getGridParam', 'sortorder'), shrinkToFit: true, loadonce: false, height: 'auto'}).trigger("reloadGrid");
        }
    }
}
;
function ExportExcel($tableIn, fileName) {
    var html;
    var header = "";
    var trhtml = "";
    var numofRows = $tableIn.getGridParam("reccount");
    var cellObject = $tableIn.jqGrid('getGridParam', 'colModel');
    var colNames = $tableIn.jqGrid('getGridParam', 'colNames');
    colNames.forEach(function (inName) {
        header = header + "<th>" + inName + "</th>";
    });
    for (var r = 1; r <= numofRows; r++) {
        var tdhtml = "";
        cellObject.forEach(function (inName) {
            var color = "";
            tdhtml = tdhtml + "<td style='text-align:" + inName.align + ";color:" + color + ";'>" + $tableIn.jqGrid('getCell', r, inName.name) + "</td>";
        });
        trhtml = trhtml + "<tr>" + tdhtml + "</tr>";
    }
    html = "<table border='1'>" + header + trhtml + "</table>";
    var dt = new Date();
    var day = dt.getDate();
    var month = dt.getMonth() + 1;
    var year = dt.getFullYear();
    var hour = dt.getHours();
    var mins = dt.getMinutes();
    var postfix = year + "_" + month + "_" + day + "_" + hour + "_" + mins;

    var D = document,
            a = D.createElement("a");
    var strMimeType = "application/vnd.ms-excel";
    if (navigator.msSaveBlob) { // IE10
        return navigator.msSaveBlob(new Blob([html], {type: strMimeType}), fileName + postfix + '.xls');
    } /* end if(navigator.msSaveBlob) */

    if ('download' in a) { //html5 A[download]
        a.href = "data:" + strMimeType + "," + encodeURIComponent(html);
        a.setAttribute("download", fileName + postfix + '.xls');
        a.innerHTML = "downloading...";
        D.body.appendChild(a);
        setTimeout(function () {
            a.click();
            D.body.removeChild(a);
        }, 66);
        return true;
    } /* end if('download' in a) */


    //do iframe dataURL download (old ch+FF):
    var f = D.createElement("iframe");
    D.body.appendChild(f);
    f.src = "data:" + strMimeType + "," + encodeURIComponent(html);

    setTimeout(function () {
        D.body.removeChild(f);
    }, 333);
    return true;
}
;