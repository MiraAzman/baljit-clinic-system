/**
 * Reader for jqGrid Settings
 * @constructor
 * @function {string} title - The title of the book.
 * @param {object} objIn expample of input (must param) name:[array of column name], column:[array of colomn model], settingsname:"string of settingsname", settingarray:${sessionScope.settings}
 */

function readSettings(objIn) {
    var tempArray = objIn.settingArray.gridSetting, defaultColName = objIn.defaultColName, defaultColMol = objIn.defaultColMol, settingsName = objIn.settingName,
            returnObject = [];
    if (!(defaultColMol && defaultColName && settingsName)) {
        alert('"readSetting" Settings Missing.');
        return;
    }
    if (isEmpty(tempArray) || isEmpty(tempArray[settingsName])) {
        returnObject.push(defaultColName);
        returnObject.push(defaultColMol);
        return returnObject;
    } else {
        var finalArray = tempArray[settingsName];

        if (!$.isEmptyObject(tempArray[settingsName])) {
            finalArray = tempArray[settingsName];
        }

        var aryUnique = finalArray,
                length = aryUnique.length,
                gridSettings = [];

        for (var i = 0; i < length; i++) {
            var exists = false;
            var current = aryUnique.splice(0, 1);
            for (var j = 0; j < gridSettings.length; j++) {
                if (current[0] === gridSettings[j]) {
                    exists = true;
                    break;
                }
            }
            if (!exists) {
                gridSettings.push(current[0]);
            }
        }
//        gridSettings = aryUnique;
        for (var i = 0; i < gridSettings.length; i++) {
            if (gridSettings[i] > defaultColName.length || !$.isNumeric(gridSettings[i]) || gridSettings.length > defaultColName.length) {
                returnObject.push(defaultColName);
                returnObject.push(defaultColMol);
                return returnObject;
            }
        }
        var tempColName = [], currentColName = [], currentColMol = [],
                tempColMol = [];
        for (var j = 0; j < gridSettings.length; j++) {
            currentColName.push(defaultColName[gridSettings[j]]);
            currentColMol.push(defaultColMol[gridSettings[j]]);
        }
        for (var index = 0; index < defaultColMol.length; index++) {
            var exsists = false;
            for (var j = 0; j < gridSettings.length; j++) {
                if (index == gridSettings[j]) {
                    exsists = true;
                    break;
                }
            }
            if (!exsists) {
                var tempColNameObj = defaultColName[index],
                        tempColMolObj = defaultColMol[index];
                if (tempColMolObj.must == null || tempColMolObj.must == false) {
                    tempColNameObj.hidden = true;
                    tempColMolObj.hidden = true;
                }
                tempColName.push(tempColNameObj);
                tempColMol.push(tempColMolObj);
            }
        }
        returnObject.push(currentColName.concat(tempColName));
        returnObject.push(currentColMol.concat(tempColMol));
    }
    return returnObject;
}
;

function sortColumn(objIn) {
    var grid = objIn.grid, defaultColMol = objIn.defaultColMol, settingsName = objIn.settingName, done = objIn.done, relativeColumnOrder = objIn.order, settingsAray = objIn.settingArray;
    if (!(grid && defaultColMol && settingsName && relativeColumnOrder)) {
        alert('"sortColumn" Settings Missing.');
        return;
    }
    var defaultColIndicies = [];
    for (var i = 0; i < defaultColMol.length; i++) {
        defaultColIndicies.push(defaultColMol[i].name);
    }

    if (grid.getGridParam('treeGrid')) {
        // tree grid mode adds 5 extra columns
        defaultColIndicies = defaultColIndicies.concat(['level', 'parent', 'isLeaf', 'expanded', 'loaded']);
    }

    var columnOrder = [];
    var currentColModel = grid.getGridParam('colModel'),
            rownumbers = grid.jqGrid("getGridParam", "rownumbers");
    for (var j = 0; j < relativeColumnOrder.length; j++) {
        if (rownumbers) {
            var checkNumbers = defaultColIndicies.indexOf(currentColModel[j].name);
            if (checkNumbers >= 0 && !currentColModel[j].hidden) {
                columnOrder.push(checkNumbers);
            }
        } else {
            columnOrder.push(defaultColIndicies.indexOf(currentColModel[j].name));
        }
    }

    var checkEqual = false;
    if (settingsAray[settingsName]) {
        var tempArray = settingsAray[settingsName];
        checkEqual = arrayEqual(tempArray, columnOrder);
    }
//    if (!checkEqual) {
//        sessionStorage.setItem(settingsName, JSON.stringify(columnOrder));
//    } else {
//        if (arrayEqual(settingsAray[settingsName], columnOrder)) {
//            sessionStorage.removeItem(settingsName);
//        }
//    }
    if (!checkEqual) {
        var tempObj = sessionStorage.getItem('gridSetting') == null ? {} : JSON.parse(sessionStorage.getItem('gridSetting'));
        tempObj[settingsName] = columnOrder;
        sessionStorage.setItem('gridSetting', JSON.stringify(tempObj));
    } else {
        var tempObj = sessionStorage.getItem('gridSetting') == null ? {} : JSON.parse(sessionStorage.getItem('gridSetting'));
        delete tempObj[settingsName];
        sessionStorage.setItem('gridSetting', JSON.stringify(tempObj));
    }
    if (typeof done == 'function') {
        done();
    }
}

function quickSetupChooser(objIn) {
    var $grid = objIn.grid, defaultColMol = objIn.defaultColMol, settingsName = objIn.settingName, done = objIn.done, settingsAray = objIn.settingArray;
    if (!($grid && defaultColMol && settingsName)) {
        alert('"quickSetupChooser" Settings Missing.');
        return;
    }
    var pagerID = $grid.jqGrid('getGridParam', 'pager'),
            initNavGrid = $grid.jqGrid('getGridParam', 'navGrid');
    if (initNavGrid) {
        return;
    }
    $grid.jqGrid('navGrid', pagerID, {search: false, refresh: false, add: false, edit: false, del: false});
    $.extend(true, $.ui.multiselect, {
        locale: {
            addAll: 'Make all visible',
            removeAll: 'Hide All',
            itemsCount: 'Avalialble Columns'
        }
    });//
    $grid.jqGrid('navButtonAdd', pagerID, {
        caption: "",
        buttonicon: "ui-icon-calculator",
        title: "Choose columns",
        onClickButton: function () {
            $(this).jqGrid('columnChooser', {
                width: 700,
                height: 280,
                classname: "column-chooser",
                modal: true,
                done: function (perm) {
                    var grid = jQuery(this);
                    if (perm) {
                        var defaultColIndicies = [];
                        for (var i = 0; i < defaultColMol.length; i++) {
                            defaultColIndicies.push(defaultColMol[i].name);
                        }

                        if (grid.getGridParam('treeGrid')) {
                            defaultColIndicies = defaultColIndicies.concat(['level', 'parent', 'isLeaf', 'expanded', 'loaded']);
                        }

                        var columnOrder = [];
                        var currentColModel = grid.getGridParam('colModel'),
                                rownumbers = grid.jqGrid("getGridParam", "rownumbers");

                        var array = $.grep(currentColModel, function (object, index) {
                            return object.hidden == false && (object.hidedlg == false || object.hidedlg == null || object.must == true);
                        });
                        $.each(array, function (index, object) {
                            if (rownumbers) {
                                var checkNumbers = defaultColIndicies.indexOf(object.name);
                                if (checkNumbers >= 0) {
                                    columnOrder.push(checkNumbers);
                                }
                            } else {
                                columnOrder.push(defaultColIndicies.indexOf(object.name));
                            }
                        });
                        var checkEqual = false;
                        if (settingsAray[settingsName]) {
                            var tempArray = settingsAray[settingsName];
                            checkEqual = arrayEqual(tempArray, columnOrder);
                        }
                        if (!checkEqual) {
                            var tempObj = sessionStorage.getItem('gridSetting') == null ? {} : JSON.parse(sessionStorage.getItem('gridSetting'));
                            tempObj[settingsName] = columnOrder;
                            sessionStorage.setItem('gridSetting', JSON.stringify(tempObj));
                        } else {
                            var tempObj = sessionStorage.getItem('gridSetting') == null ? {} : JSON.parse(sessionStorage.getItem('gridSetting'));
                            delete tempObj[settingsName];
                            sessionStorage.setItem('gridSetting', JSON.stringify(tempObj));
//                            if (arrayEqual(settingsAray[settingsName], columnOrder)) {
//                                sessionStorage.removeItem('gridSetting')[settingsName];
//                            }
                        }
                        if (typeof done == 'function') {
                            done();
                        }
                    }
                    // here you can do some additional actions
                },
                msel_opts: {//multiselect options
                    autoOpen: true,
                    header: true,
                    height: 500,
                    classes: "column-chooser",
                    dividerLocation: 0.5,
                    beforeclose: function () {
                        return false;
                    } //keep multiselect drop down open  
                }
            });
        }
    });

    $grid.jqGrid('navButtonAdd', pagerID, {
        caption: "",
//        buttonicon: "ui-icon-arrowrefresh-1-e",
        title: "Reset to default",
        position: "Reset",
        onClickButton: function () {
            $.SmartMessageBox({
                title: "<i class='fa fa-refresh' style='color:green'></i> Reset Column Layout",
                content: "Would you like to RESET the Column Layout ?<br>(Page will be refresh.)",
                buttons: '[No][Yes]'
            }, function (ButtonPressed) {
                if (ButtonPressed === "Yes") {
                    var tempObj = sessionStorage.getItem('gridSetting') == null ? {} : JSON.parse(sessionStorage.getItem('gridSetting'));
                    var defaultColumn = [];
                    for (var i = 0; i < defaultColMol.length; i++) {
                        defaultColumn.push(i);
                    }
                    tempObj[settingsName] = defaultColumn;
                    sessionStorage.setItem('gridSetting', JSON.stringify(tempObj));
//                    if (!$.isEmptyObject(sessionStorage.getItem(settingsName))) {
//                        sessionStorage.removeItem(settingsName);
//                    }
//                    if (!$.isEmptyObject(settingsAray[settingsName])) {
//                        sessionStorage.setItem(settingsName, JSON.stringify({}));
//                    }
                    location.reload();
                }
            });
//            alert("Please refresh page to Reset the column settings.");
        }
    });
}

function resizeWidth(objIn) {
    var grid = objIn.grid,
            griddiv = objIn.gridDiv, columnModel = grid.getGridParam('colModel'), visibleWidth = 0;
    if (!(grid && griddiv)) {
        alert('"resizeWidth" Settings Missing.');
        return;
    }
    for (var i = 0; i < columnModel.length; i++) {
        if (typeof columnModel[i].hidden === undefined || !columnModel[i].hidden) {
            visibleWidth += columnModel[i].widthOrg;
        }
    }
    if (visibleWidth < griddiv.width()) {
        grid.jqGrid('setGridParam', {
            autowidth: true,
            shrinkToFit: true
        }).trigger("reloadGrid");
    } else {
        grid.jqGrid('setGridParam', {
            autowidth: false,
            shrinkToFit: false
        });
        for (var i = 0; i < columnModel.length; i++) {
            if (typeof columnModel[i].hidden === undefined || !columnModel[i].hidden) {
//                alert(columnModel[i].widthOrg);
                grid.jqGrid('setColProp', columnModel[i].name, {width: columnModel[i].widthOrg});
            }
        }
//           alert(JSON.stringify(grid.getGridParam('colModel')));
        var gw = grid.jqGrid('getGridParam', 'width');
        grid.jqGrid('setGridWidth', gw);
    }
    grid.jqGrid('setGridWidth', griddiv.width());
//    alert('Resize ' + grid.attr('id'));
}

function arrayEqual(lhs, rhs) {
    // if the other array is a falsy value, return
    if (!lhs || !rhs) {
        return false;
    }

    // compare lengths - can save a lot of time 
    if (lhs.length != rhs.length) {
        return false;
    }

    for (var i = 0, l = lhs.length; i < l; i++) {
        // Check if we have nested arrays
        if (lhs[i] instanceof Array && rhs[i] instanceof Array) {
            // recurse into the nested arrays
            if (!lhs[i].equals(rhs[i]))
                return false;
        }
        else if (lhs[i] != rhs[i]) {
            // Warning - two different object instances will never be equal: {x:20} != {x:20}
            return false;
        }
    }
    return true;
}

var hasOwnProperty = Object.prototype.hasOwnProperty;

function isEmpty(obj) {

    // null and undefined are "empty"
    if (obj == null)
        return true;

    // Assume if it has a length property with a non-zero value
    // that that property is correct.
    if (obj.length > 0)
        return false;
    if (obj.length === 0)
        return true;

    // Otherwise, does it have any properties of its own?
    // Note that this doesn't handle
    // toString and valueOf enumeration bugs in IE < 9
    for (var key in obj) {
        if (hasOwnProperty.call(obj, key))
            return false;
    }

    return true;
}

//function exportData(e, id) {
//    var gridid = jQuery(id).getDataIDs(); // Get all the ids in array
//    var label = jQuery(id).getRowData(gridid[0]); // Get First row to get the labels
////    var selRowIds = jQuery(id).jqGrid('getGridParam', 'selarrrow');
//    alert(gridid);
//
//    var obj = new Object();
//    obj.count = selRowIds.length;
//
//    if (obj.count) {
//
//        obj.items = new Array();
//
//        for (elem in selRowIds) {
//            obj.items.push(jQuery(id).getRowData(selRowIds[elem]));
//        }
//
//        var json = JSON.stringify(obj);
//
//        JSONToCSVConvertor(json, "csv", 1);
//    }
//}
//function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
//
//    //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
//    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
//    var CSV = '';
//    //This condition will generate the Label/Header
//    if (ShowLabel) {
//        var row = "";
//
//        //This loop will extract the label from 1st index of on array
//        for (var index in arrData.items[0]) {
//            //Now convert each value to string and comma-seprated
//            row += index + ',';
//        }
//        row = row.slice(0, -1);
//        //append Label row with line break
//        CSV += row + '\r\n';
//    }
//
//    //1st loop is to extract each row
//    for (var i = 0; i < arrData.items.length; i++) {
//        var row = "";
//        //2nd loop will extract each column and convert it in string comma-seprated
//        for (var index in arrData.items[i]) {
//            row += '"' + arrData.items[i][index].replace(/(<([^>]+)>)/ig, '') + '",';
//        }
//        row.slice(0, row.length - 1);
//        //add a line break after each row
//        CSV += row + '\r\n';
//    }
//
//    if (CSV == '') {
//        alert("Invalid data");
//        return;
//    }
//
//    /*
//     * 
//     * FORCE DOWNLOAD
//     * 
//     */
//
//
//    //this trick will generate a temp "a" tag
//    var link = document.createElement("a");
//    link.id = "lnkDwnldLnk";
//
//    //this part will append the anchor tag and remove it after automatic click
//    document.body.appendChild(link);
//
//    var csv = CSV;
//    blob = new Blob([csv], {type: 'text/csv'});
//
//    var myURL = window.URL || window.webkitURL;
//
//    var csvUrl = myURL.createObjectURL(blob);
//    var filename = 'UserExport.csv';
//    jQuery("#lnkDwnldLnk")
//            .attr({
//                'download': filename,
//                'href': csvUrl
//            });
//
//    jQuery('#lnkDwnldLnk')[0].click();
//    document.body.removeChild(link);
//
//}