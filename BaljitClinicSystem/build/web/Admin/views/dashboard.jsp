<!--
Modification Id     By          Date            Comment
                    Aaron       05Dec2018       removed unwanted widgets on dashboard
button01            Aaron       21Dec2018       remove unwanted button from widget

-->

<%
    String s_loginid = (String) session.getAttribute("loginid");
    String s_loginpwd = (String) session.getAttribute("loginpwd");
    String s_bussapp_code = (String) session.getAttribute("bussapp_code");
    String s_cppcode = (String) session.getAttribute("cppcode");
    String bussapp_name = (String) session.getAttribute("bussapp_name");
    String s_bussapp = (String) session.getAttribute("bussapp");
%> 

<!--<link rel="stylesheet" type="text/css" media="screen" href="css/jquery-ui-1.8.19.custom.css">-->
<article title="" name="dashBoard">
    <div class="row">
        <div class="col-xs-12 col-sm-7 col-md-7 col-lg-4">
            <!--<h1 class="page-title txt-color-blueDark"><i class="fa-fw fa fa-home"></i> Dashboard <span>> My Dashboard</span></h1>-->
<!--            <h1 class="page-title txt-color-blueDark"><span>Account Receivable As of Date</span>
            </h1> -->
            
        </div>
<!--        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
            <ul id="sparks" class="">
                 <li class="sparks-info">
                    <h5> Pending Claims Confirmation <span class="txt-color-blue">$<input type="text" id="lblPendingConfirm" class="tboxreadonlyShort" readonly/></span></h5>
                    <div class="sparkline txt-color-purple hidden-mobile hidden-md hidden-sm">
                            110,150,300,130,400,240,220,310,220,300, 270, 210
                    </div>
                </li>
                
                <li class="sparks-info">
                    <h5> Confirmed Claims <span class="txt-color-blue">$<input type="text" id="lblTotalAR" class="tboxreadonlyShort" readonly/></h5>
                    <div class="sparkline txt-color-blue hidden-mobile hidden-md hidden-sm">
                            1300, 1877, 2500, 2577, 2000, 2100, 3000, 2700, 3631, 2471, 2700, 3631, 2471
                    </div>
                </li>
               
                 <li class="sparks-info">
                    <h5> Submitting Claims (Case) <span class="txt-color-blue">&nbsp;<input type="text" id="lblSubmit" class="tboxreadonlyShort" readonly/></span></h5>
                    <div class="sparkline txt-color-purple hidden-mobile hidden-md hidden-sm">
                            110,150,300,130,400,240,220,310,220,300, 270, 210
                    </div>
                </li>
                
                
               <li class="sparks-info">
                    <h5> YTD Rejected Case <span class="txt-color-blue">&nbsp;<input type="text" id="lblReject" class="tboxreadonlyShort" readonly/></span></h5>
                    <div class="sparkline txt-color-greenDark hidden-mobile hidden-md hidden-sm">
                            110,150,300,130,400,240,220,310,220,300, 270, 210
                    </div>
                </li> 
                <li class="sparks-info">
                    <h5> YTD Denial Case <span class="txt-color-blueLight">&nbsp;<input type="text" id="lblDenial" class="tboxreadonlyShort" readonly/></span></h5>
                    <div class="sparkline txt-color-greenDark hidden-mobile hidden-md hidden-sm">
                            110,150,300,130,400,240,220,310,220,300, 270, 210
                    </div>
                </li>
                <li class="sparks-info">
                    <h5> Evaluation by Payor <span class="txt-color-teal">&nbsp;<input type="text" id="lblAppeal" class="tboxreadonlyShort" readonly/></span></h5>
                    <div class="sparkline txt-color-greenDark hidden-mobile hidden-md hidden-sm">
                            110,150,300,130,400,240,220,310,220,300, 270, 210
                    </div>
                </li> 
            </ul>
        </div>-->
    </div>
    <!-- widget grid -->
    <section id="widget-grid" class="">

        <!-- row -->
        <div class="row">
            <article class="col-sm-12">
                <!-- new widget -->
                <div class="jarviswidget" id="big-wid" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">

                    <header>
                        <span class="widget-icon"></span>


                        <ul class="nav nav-tabs pull-right in" id="myTab">
                            <li class="active">
                                <a data-toggle="tab" href="#s1"><i class="fa fa-money"></i> <span class="hidden-mobile hidden-tablet">Management Dashboard</span></a>
                            </li>

<!--                            <li hidden="">
                                <a data-toggle="tab" href="#s2"><i class="fa fa-hospital-o"></i> <span class="hidden-mobile hidden-tablet" >Medical Analysis</span></a>
                            </li>-->
                        </ul>

                    </header>

                    <!-- widget div-->
                    <div class="no-padding">


                        <div class="widget-body">
                            <!-- content -->
                            <div id="myTabContent" class="tab-content">
                                <div class="tab-pane fade active in padding-10 no-padding-bottom" id="s1">

                                    <div class="row no-space">

                                        <!-- NEW WIDGET START -->
                                        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <!-- Widget ID (each widget will need unique ID)-->
                                            <!--button01-->
                                            <div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false" data-widget-deletebutton="false">

                                                <header>
                                                    <span class="widget-icon"> </span>
                                                    <h2>&nbsp;</h2>				

                                                </header>

                                                <!-- widget div-->
                                                <div>

                                                    <!-- widget edit box -->
                                                    <div class="jarviswidget-editbox">
                                                        <!-- This area used as dropdown edit box -->

                                                    </div>
                                                    <!-- end widget edit box -->

                                                    <!-- widget content -->
                                                    <div class="widget-body no-padding">
                                                        <input type="text" id="txtReqDTFrom" class="searchbox-date" style="margin-bottom: 20px;cursor: pointer" readonly=""/>
                                                        <input type="text" id="txtReqDTTo" class="searchbox-date" style="margin-bottom: 20px;cursor: pointer" readonly=""/>
                                                        <!--<div id="bar-chart" class="chart"></div>-->
                                                        <div id="TopRequest" ></div>
                                                        
                                                    </div>
                                                    <!-- end widget content -->

                                                </div>
                                                <!-- end widget div -->

                                            </div>
                                            <!-- end widget -->
                                        </article>
                                    </div>
                                    <!-- remove all unwanted widget on dashboard remains the top 10 request widget -->
                                    <!--<div class="row no-space">

                                        <!-- NEW WIDGET START
                                        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <!-- Widget ID (each widget will need unique ID)
                                            <div class="jarviswidget" id="wid-id-1" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-fullscreenbutton="false">

                                                <header>
                                                    <span class="widget-icon"> </span>
                                                    <h2>&nbsp;</h2>				

                                                </header>

                                                <!-- widget div
                                                <div>

                                                    <!-- widget edit box 
                                                    <div class="jarviswidget-editbox">
                                                        <!-- This area used as dropdown edit box

                                                    </div>
                                                    <!-- end widget edit box

                                                    <!-- widget content
                                                    <div class="widget-body no-padding">

                                                        <!--<div id="bar-chart" class="chart"></div>
                                                        <div id="BarChartAging" ></div>
                                                    </div>
                                                    <!-- end widget content

                                                </div>
                                                <!-- end widget div

                                            </div>
                                            <!-- end widget
                                        </article>
                                    </div>
                                    <!-- WIDGET END
                                    <!-- row
                                    <div class="row">

                                        <article class="col-sm-12 col-md-12 col-lg-6">
                                            <!-- new widget
                                            <div class="jarviswidget" id="wid-id-2" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">


                                                <header>
                                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o txt-color-white"></i> </span>
                                                    <h2>&nbsp;</h2>

                                                </header>

                                                <!-- widget div
                                                <div>


                                                    <div class="widget-body widget-hide-overflow no-padding">
                                                        <div id="PieChartTop10AR" ></div>
                                                    </div>

                                                </div>
                                                <!-- end widget div
                                            </div>
                                            <!-- end widget
                                        </article>
                                        <article class="col-sm-12 col-md-12 col-lg-6">
                                            <!-- new widget
                                            <div class="jarviswidget" id="wid-id-3" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">


                                                <header>
                                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o txt-color-white"></i> </span>
                                                    <h2>&nbsp;</h2>

                                                </header>

                                                <!-- widget div
                                                <div>


                                                    <div class="widget-body widget-hide-overflow no-padding">
                                                        <div id="PieChartReject" ></div>
                                                    </div>

                                                </div>
                                                <!-- end widget div
                                            </div>
                                            <!-- end widget
                                        </article>   
                                        <article class="col-sm-12 col-md-12 col-lg-6">
                                            <!-- new widget
                                            <div class="jarviswidget" id="wid-id-4" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">


                                                <header>
                                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o txt-color-white"></i> </span>
                                                    <h2>&nbsp;</h2>

                                                </header>

                                                <!-- widget div
                                                <div>


                                                    <div class="widget-body widget-hide-overflow no-padding">
                                                        <div id="PieChartDenial" ></div>
                                                    </div>

                                                </div>
                                                <!-- end widget div
                                            </div>
                                            <!-- end widget
                                        </article>
                                        <article class="col-sm-12 col-md-12 col-lg-6">
                                            <!-- new widget
                                            <div class="jarviswidget" id="wid-id-5" data-widget-editbutton="false" data-widget-fullscreenbutton="false" data-widget-colorbutton="false">


                                                <header>
                                                    <span class="widget-icon"> <i class="fa fa-bar-chart-o txt-color-white"></i> </span>
                                                    <h2>&nbsp;</h2>

                                                </header>

                                                <!-- widget div
                                                <div>


                                                    <div class="widget-body widget-hide-overflow no-padding">
                                                        <div id="PieChartAccu" ></div>
                                                    </div>

                                                </div>
                                                <!-- end widget div
                                            </div>
                                            <!-- end widget
                                        </article> 
                                    </div>    
                                    <!-- end row -->


                                </div>
                                <!-- end s1 tab pane -->

                                <div class="tab-pane fade" id="s2">


                                </div>
                                <!-- end s2 tab pane -->


                            </div>

                            <!-- end content -->
                        </div>

                    </div>
                    <!-- end widget div -->
                </div>
                <!-- end widget -->

            </article>
        </div>

        <!-- end row -->






    </section>

</article>
<input type="hidden" id="hdnDateFrom" >
<input type="hidden" id="hdnAsOfDate" >
<input type="hidden" id="hdnTopRequestDrill" >
<input type="hidden" id="hdnReqFromDate" >
<input type="hidden" id="hdnReqToDate" >

<!-- end widget grid -->

<script type="text/javascript">

    $(document).ready(function () {
        var tempDate = new Date();
        $("#txtReqDTFrom").datepicker({
            numberOfMonths: 2,
            changeMonth: true,
            changeYear: true,
            dateFormat: "yy-mm-dd",
            onSelect: function (selected) {
                $("#txtReqDTTo").datepicker("option", "minDate", selected);
                RequestChart();
            }
        });
        var fromDate = $.datepicker.formatDate('yy-mm-dd', new Date(tempDate.getFullYear(), tempDate.getMonth() - 3, tempDate.getDate()));
        $("#txtReqDTFrom").val(fromDate);
        $("#hdnReqFromDate").val($("#txtReqDTFrom").val());
        $("#txtReqDTTo").datepicker({
            numberOfMonths: 2,
            changeMonth: true,
            changeYear: true,
            dateFormat: "yy-mm-dd",
            onSelect: function (selected) {
                $("#txtReqDTFrom").datepicker("option", "maxDate", selected);
                RequestChart();
            }
        });
        $("#txtReqDTTo").datepicker("option", "minDate", fromDate);
        $("#txtReqDTTo").val($.datepicker.formatDate('yy-mm-dd', tempDate));
        $("#txtReqDTFrom").datepicker("option", "maxDate", tempDate);
        $("#hdnReqToDate").val($("#txtReqDTTo").val());

    });

var level = 0;
var CountVal = "";
    var RequestChart = function () {
       
 var myJSON = [];  
       // $(document).ready(function() {  
        var chartCat = new Array();
        var charVal = new Array();
        var drilldowndata = new Array();                       
        var drilljson = "";
        var JSONText = "";
        $.get('${pageContext.request.contextPath}/Servlet_Dashboard', {SFC: "GET_TOP_REQ", DTFROM: $('#txtReqDTFrom').val() , DTTO: $('#txtReqDTTo').val()}, function (data) {  
           // function (data) {
                checkData = data.data;
                var jsonData = JSON.parse(data);
                
                for (var i = 0; i < jsonData.rows.length; i++) {
                    chartCat.push(jsonData.rows[i].LocCode);
                    //['Not Due', 'Current Week', '1 Week', '2 Week', '3 Week', '4 Week', '5 Week', '6 Week', '7 Week', '>8 Week'];
                    charVal.push(parseFloat(jsonData.rows[i].ReqCount));
                    
                }
                    
                 Category = chartCat;
                 CountVal =charVal ;
                   var chart = new Array();
                   
                    var jsonObj = "";
                     for (var j = 0; j < chartCat.length; j++) {
                        // alert(chartCat[j]);
                        jsonObj = {"name": String(chartCat[j]), "y": parseFloat(charVal[j]), "drilldown": String(chartCat[j])};
                         chart.push(jsonObj);
                     }
                    // alert(JSON.stringify(chart));
                        $.ajax({
                                type: "POST",
                                url: "${pageContext.request.contextPath}/Servlet_Dashboard?SFC=GET_TOP_REQ_DRILL",
                                data: {
                                    DTFROM: $('#txtReqDTFrom').val(),
                                    DTTO: $('#txtReqDTTo').val()
                                // LOCCODE: e.point.name                    
                                },
                                dataType: 'json',
                                async:false,
                                beforeSend: function () {
                                //alert('send');
                                 // $.showLoadingNoStatus();
                                },
                                success: function(data) {
                                     jsonsubData = data;
                                      var arr = [];
                                      $.each(jsonsubData, function (key, data) {
                                                // console.log(arr.length);
                                        $.each(data, function (index, data) {
                                            arr.push(data);
                                        });
                                        });
                                        
                                         var drillItem = (arr.reduce(function (result, current) {
                                                result[current.LocCode] = result[current.LocCode] || [];
                                                
                                                result[current.LocCode].push([current.stkName, parseFloat(current.ReqQty)]);
//                                               
                                                JSONText = result;
                                                return result;
                                        }, {}));
                                     
                                      $.each(JSONText , function(key, data) {
                                                        //var id = v[0]; // etc
                                                       // alert(id);
                                                        //console.log("key-->" + JSON.stringify(key));
                                                        
                                                        drilljson = {"id": key, "name": "Request Qty", "data": data };
                                                        drilldowndata.push(drilljson);
                                                   });
                                    // console.log("JSONTEXT-->" + JSON.stringify(JSONText));
                                    // console.log(JSON.stringify(drilldowndata));
                               
                                 }
                            });
          
            // Internationalization    
            Highcharts.setOptions({  
                lang: {  
                    drillUpText: 'Back to {series.name}'  
                }  
            });  
            var options = {  
                chart: {  
                    height: 300,  
                    events: {  
                        drilldown: function(e) {  
                            // alert(e.point.name);
                              
                           
                            
                            generateDrillDownJSON(e, false);  
                        },  
                        drillup: function(e) {  
                            generateDrillDownJSON(e, true);  
                        }  
                    }  
                },  
                title: {  
                    text: 'Top 10 Request Outlet'  
                }, 
                subtitle: {
                        text: 'As ' + $('#txtReqDTFrom').val() + ' To ' + $('#txtReqDTTo').val()
                    },
                xAxis: {  
                    categories: true  
                },  
                    drilldown: {
                    series: drilldowndata
                },
                 tooltip: {
                    shared: true,
                    useHTML: true,
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                            '<td style="color:{series.color};padding:0"><b>{point.y:.0f}</b></td></tr>',
                    footerFormat: '</table>'
                },
 
//legend: {
//                        layout: 'vertical',
//                        align: 'right',
//                        x: 0,
//                        verticalAlign: 'top',
//                        y: 100,
//                        floating: false,
//                        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
//                    },
legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'top',
                    x: 0,
                    y: 60,
                    showInLegend: true,
                    borderWidth: 0,
                    labelFormatter: function () {
                        var words = this.name.split(/[\s]+/);
                        var numWordsPerLine = 2;
                        var str = [];
                        for (var word in words) {
                            if (word > 0 && word % numWordsPerLine === 0)
                                str.push('<br>');
                            str.push(words[word]);
                        }
                        return str.join(' ');
                    }
                },
 plotOptions: {
                    column: {
                        pointPadding: 0,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'gray',
                            fontWeight: 'bold'
                        }
                    }
                },
                 series: [{
                 name: 'Request Count',
                 colorByPoint: true,
                 data: chart
            }],
        yAxis: [{// Primary yAxis
                            labels: {
                                format: '{value}',
                                style: {
                                    color: Highcharts.getOptions().colors[1]
                                }
                            },
                            title: {
                                text: 'Count',
                                style: {
                                    color: Highcharts.getOptions().colors[1]
                                }
                            }
                        }]

            };  
            // Drill Down Chart Implementation    
            options.chart.renderTo = 'TopRequest';  
            options.chart.type = 'column';  
            var chart1 = new Highcharts.Chart(options);  
        });  
  
        function generateDrillDownJSON(e, isDrillUp) {  
           // alert(e.point.name);
            try {  
                if (isDrillUp) {  
                    if (myJSON !== null && myJSON.length > 0) {  
                        removeArrayElementByIndex(myJSON, myJSON.length - 1);  
                    }  
                    sessionStorage.setItem('DrillDownJSON', JSON.stringify(myJSON));  
                   // $("#jsonContent").html('JSON content is: ').append(JSON.stringify(myJSON));  
                } else {  
                    myJSON.push({  
                        name: e.point.name,  
                        level: myJSON.length + 1  
                    });  
                    sessionStorage.setItem('DrillDownJSON', JSON.stringify(myJSON));  
                   // $("#jsonContent").html('JSON content is: ').append(JSON.stringify(myJSON));  
                }  
            } catch (e) {  
                console.log('generateHierarchyJSON :' + e.message);  
            }  
        }  
  
        function removeArrayElementByIndex(myArray, index) {  
            myArray.splice(index, 1);  
        }  
  //}); 
    };

  






    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", function () {
        loadScript("chartjs/highcharts.js", function () {
            loadScript("chartjs/highcharts-3d.js", function () {
                loadScript("chartjs/no-data-to-display.js", function () {
                    loadScript("chartjs/drilldown.js", function () {
                         loadScript("chartjs/data.js", function () {
                            loadScript("chartjs/exporting.js", RequestChart());
                         });
                     });
                });
            });
        });
    });



</script>