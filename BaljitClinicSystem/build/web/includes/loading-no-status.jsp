<%-- 
    Document   : loading-no-status
    Created on : May 15, 2015, 8:37:09 AM
    Author     : N0531
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    /****DEBUT TRANSFORM****/
    .loading{
        top: 30%;
    }

    .mid{
        margin-left: 43%;
        left: 50%;
    }

    #caseVerteClaire {
        position: relative;
        left: 70px;
        height: 40px;
    }

    #tranform {
        position : absolute;
        top : 85px;
        left : 100px;
    }

    #transform1 {
        height : 20px;
        width : 20px;
        border-radius : 50%; 
        background-color : #444444;
        position : absolute;
        //top : 0;
        left : 15px;
        opacity : 0;
        animation : transform 5s infinite;
        -webkit-animation : transform 5s infinite;
    }

    #transform2 {
        height : 20px;
        width : 20px;
        border-radius : 50%; 
        background-color : #444444;
        position : absolute;
        // top : 85px;
        left : 55px;
        opacity : 0;
        animation : transform 5s infinite;
        -webkit-animation : transform 5s infinite;
        animation-delay : 0.5s;
        -webkit-animation-delay : 0.5s;
    }

    #transform3 {
        height : 20px;
        width : 20px;
        border-radius : 50%; 
        background-color : #444444;
        position : absolute;
        //top : 85px;
        left : 95px;
        opacity : 0;
        animation : transform 5s infinite;
        -webkit-animation : transform 5s infinite;
        animation-delay : 1s;
        -webkit-animation-delay : 1s;
    }

    #transform4 {
        height : 20px;
        width : 20px;
        border-radius : 50%; 
        background-color : #444444;
        position : absolute;
        //top : 85px;
        left : 135px;
        opacity : 0;
        animation : transform 5s infinite;
        -webkit-animation : transform 5s infinite;
        animation-delay : 1.5s;
        -webkit-animation-delay : 1.5s;
    }

    #transform5 {
        height : 20px;
        width : 20px;
        border-radius : 50%; 
        background-color : #444444;
        position : absolute;
        //top : 85px;
        left : 175px;
        opacity : 0;
        animation : transform 5s infinite;
        -webkit-animation : transform 5s infinite;
        animation-delay : 2s;
        -webkit-animation-delay : 2s;
    }

    @-webkit-keyframes transform {
        0% {opacity : 0;}
        25% {opacity : 1;}
        50% {opacity : 0;}
        75% {opacity : 1;}
        100% {opacity : 0;}
    }

    @keyframes transform {
        0% {border-radius : 0px; opacity : 0;}
        20% {border-radius : 0px; opacity : 1;}
        40% {border-radius : 0px; opacity : 0;}
        60% {border-radius : 50%; opacity : 0;}
        80% {border-radius : 50%; opacity : 1;}
        100% {border-radius : 50%; opacity : 0;}
    }
    /****FIN TRANSFORM****/
</style>
<div class="modal fade loading" id="loadingModal" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog centered" style="width: 400px;" >
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    Acquiring Information.
                </h4>
            </div>
            <div class="modal-body">
                <div class="mid">
                    <i class="fa fa-circle-o-notch fa-4x fa-spin"></i>
                </div>
                <!--<div class="bar" style="width: 99%;"></div>-->
                <!--                <div id="caseVerteClaire">
                                    <div id="transform">
                                        <div id="transform1"></div>
                                        <div id="transform2"></div>
                                        <div id="transform3"></div>
                                        <div id="transform4"></div>
                                        <div id="transform5"></div>
                                    </div>
                                </div>-->
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var lastTime;
    $.showLoadingNoStatus = function () {
        var date = new Date();
        lastTime = date.getTime();
        $("#loadingModal").modal('show');
    };

    $.hideLoadingNoStatus = function (objIn, timeIn) {
        var defTime = 750;
        if (timeIn) {
            defTime = timeIn;
        }
        var date = new Date();
        if ((date.getTime() - lastTime) < defTime) {
            setTimeout(function () {
                $("#loadingModal").modal('hide');
                setTimeout(function () {
                    if (typeof objIn === "function") {
                        objIn();
                    }
                }, 500);
            }, defTime);
        } else {
            $("#loadingModal").modal('hide');
            setTimeout(function () {
                if (typeof objIn === "function") {
                    objIn();
                }
            }, 500);
        }
    };

    $.bigBoxSuccess = function (objIn) {
        $.bigBox({
            title: objIn.title,
            content: objIn.content,
            timeout: objIn.timeout,
            color: "#739E73",
            icon: "fa fa-check"
        });
    };

    $.bigBoxWarning = function (objIn) {
        $.bigBox({
            title: objIn.title,
            content: objIn.content,
            timeout: objIn.timeout,
            color: "#C79121",
            icon: "fa fa-warning swing animated"
        });
    };

    $.bigBoxFail = function (objIn) {
        $.bigBox({
            title: objIn.title,
            content: objIn.content,
            color: "#C46A69",
            icon: "fa fa-warning shake animated",
            timeout: objIn.timeout
        });
    };
</script>