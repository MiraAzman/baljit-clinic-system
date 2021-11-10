<%-- 
    Document   : signout
    Created on : Mar 11, 2016, 4:14:01 PM
    Author     : N3355
--%>
<%
    String s_SiteName = (String) session.getAttribute("SiteName");
    session.removeAttribute("loginid");
    session.removeAttribute("errormsg");
    session.removeAttribute("bussapp");
    session.removeAttribute("loginpwd");
    session.removeAttribute("arraycode");
    session.removeAttribute("arrayname");
    session.removeAttribute("select");
//    session.removeAttribute("SiteName");
//session.invalidate();
//session.setAttribute("SiteName", s_SiteName);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <link href="css/Interacao.css" rel="stylesheet" type="text/css" />
        <link href="css/jq-metro.css" rel="stylesheet" type="text/css" />
        <script src="Script/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="Script/jquery.metro-btn.js" type="text/javascript"></script>
        <script type="text/javascript">
           // $(document).ready(function () {

                //$("#metroaqui_novo").AddMetroSimpleButton('bt1', 'metro-verde', 'img/admin.png', 'Provider', 'window.location = "prov_login.jsp"');
                //$("#metroaqui_novo").AddMetroSimpleButton('bt1', 'metro-verde', 'img/admin.png', 'Corporate / Payor', 'window.location = "corp_login.jsp"');
                //$("#metroaqui_novo").AddMetroSimpleButton('bt1', 'metro-verde', 'img/admin.png', 'Administration', 'window.location = "admin_login.jsp"');
                //$("#metroaqui_novo").AddMetroSimpleButton('bt1', 'metro-verde', 'img/admin.png', 'Personal Health Care', 'window.location = "phr_login.jsp"');
            //});
        </script>

        <!-- FAVICONS -->
        <link rel="shortcut icon" href="img/favicon/favicontemp.png" type="image/x-icon">
        <link rel="icon" href="img/favicon/favicontemp.png" type="image/x-icon">

        <link rel="stylesheet" type="text/css" media="screen" href="css/font-awesome.min.css">

        <style>
            body {
                //background-image: url("img/bg/bg5.jpg");
                //background-color: #cccccc;

            }
            th, td {
                padding: 15spx;
                text-align:center;
                font-size:20px;
                font-family: Open Sans,Arial, Helvetica, sans-serif; 

            }
        </style>

    </head>
    <body>

        <table border="0" style="width:auto"> 
            <tr style="width:100%" >
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td style="width:40%">
                    <table border="0" style="width:100%" > 
                        <tr style="width:100%" >   
                            <td ><div id="time" align="right"></div></td>
                            <td ></td>
                        </tr>
                    </table>      

                </td>
                <td><br><br><br><br><br><br><br><br><br><br></td>
            </tr>    

            <tr>

            </tr>
        </table>  
     <input type="hidden" id="site" value="<%= s_SiteName %>" />
        <div id="metroaqui_novo" class="metro-panel" >


        </div>

    </body>
</html>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<script type="text/javascript">




//     location.href = "${pageContext.request.contextPath}/Admin/Adm_Login.jsp?Site=" + name;
//    alert($("#site").val());
    location.href = "${pageContext.request.contextPath}/Admin/index.jsp?SITE=" + $("#site").val();


//    (function () {
//    function checkTime(i) {
//        return (i < 10) ? "0" + i : i;
//    }
//
//    function startTime() {
//        var today = new Date(),
//            h = checkTime(today.getHours()),
//            m = checkTime(today.getMinutes()),
//            s = checkTime(today.getSeconds());
//        document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
//        t = setTimeout(function () {
//            startTime();
//        }, 500);
//    }
//    startTime();
//})();


</script>  
