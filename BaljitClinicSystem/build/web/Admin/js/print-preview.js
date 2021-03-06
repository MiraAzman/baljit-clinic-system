/**
 * Reader for getAddress
 * @constructor
 * @param {objectIn} with creditor or debtor code and type :( PROVIDER, PAYER, CPP); Example object.code = "M_0001", object.type = "PROVIDER"
 */
var url = "http://" + contextPath + "/Servlet_Report";

//getAddress = function (objectIn) {
//    if (objectIn.code && objectIn.type) {
//        return $.ajax({
//            type: "POST",
//            url: url,
//            data: {
//                SFC: 'GET_ADDRESS',
//                CODE: objectIn.code,
//                TYPE: objectIn.type
//            },
//            dataType: 'json'
//        });
//    } else {
//        return {};
//    }
//};

printToPage = function (objIn) {
    var heightOffset = typeof objIn.heightOffset === 'string' ? objIn.heightOffset : '600',
            widthOffset = typeof objIn.widthOffset === 'string' ? objIn.widthOffset : '1000';
    var request = $.ajax({
        type: "POST",
        url: url,
        data: {
            SFC: 'ENCRYPT',
            param1: JSON.stringify(objIn.procParam),
            param2: objIn.jasperName, //'Receipt',
            param3: objIn.procString, //'SP_ACCT_TXN_SEARCH(?,?,?,?,?,?,?,?,?,?)',
            param4: JSON.stringify(objIn.fixParam),
            param5: objIn.format //indicate which format user is using
        },
        dataType: 'json'
    });
    request.done(function (response) {
        //perform action according to file format
        if (objIn.format === 'pdf' || objIn.format === undefined){
            window.open("http://" + contextPath + '/PrintPreview/PrintPreview.jsp?param1=' + response.param1 + '&param2=' + response.param2 + '&param3=' + response.param3 + '&param4=' + response.param4, 'Submitted Claims Inquiry', 'height=' + heightOffset + ',width=' + widthOffset + ',left=30,top=0, status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=yes');
        }
        else if (objIn.format === 'xlsx'){
            document.location.href=("http://" + contextPath + '/PrintPreview/ExcelExport.jsp?param1=' + response.param1 + '&param2=' + response.param2 + '&param3=' + response.param3 + '&param4=' + response.param4);
        }
        //window.open("http://" + contextPath + '/PrintPreview/PrintPreview.jsp?param1=' + response.param1 + '&param2=' + response.param2 + '&param3=' + response.param3 + '&param4=' + response.param4, 'Submitted Claims Inquiry', 'height=' + heightOffset + ',width=' + widthOffset + ',left=30,top=0, status=no,toolbar=no,menubar=no,location=no,resizable=no,scrollbars=yes');
    });
};
