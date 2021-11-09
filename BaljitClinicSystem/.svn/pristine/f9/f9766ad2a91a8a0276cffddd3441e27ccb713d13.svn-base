<%-- 
    Document   : yes-no
    Created on : May 26, 2015, 8:48:17 AM
    Author     : N0531
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style type="text/css">
    /*    #confirmation.modal,#confirmation.modal-backdrop {
            position: absolute;
        }*/
    .myClass {
        position: absolute;
        display: block;
        top: 0;
        overflow: hidden;
    }
</style>
<div id="confirmation-default-location"></div>
<div class="ui-widget-overlay" id="confirmation_overlay" style="display: none;"></div>
<div id="confirmation" class="modal fade"></div>

<script type="text/javascript">
    var localIsModal = true, callBack;
    function showYesNo(objIn) {
        $("#confirmation").removeClass().addClass("modal fade").css("z-index", "").css("left", "").css("top", "").append('<div class="modal-dialog"><div class="modal-content">' +
                '<div class="modal-header" style="cursor: default"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>' +
                '<h4 class="modal-title" id="myModalLabel">Confirmation</h4></div><div class="modal-body"><div class="error-div"></div>' +
                '<div class="row" style="padding-left: 10px;"><p class="padding-10" id="myModalMessage">Confirmation for current Process...</p></div></div>' +
                '<div class="modal-footer"><button type="button" class="btn btn-default" id="cancel">No</button>' +
                '<button type="button" class="btn btn-primary" id="confirm">Yes</button></div></div></div>');
        if (typeof objIn.title === "string") {
            $("#myModalLabel").html(objIn.title);
        }
        if (typeof objIn.width === "number") {
            $("#confirmation div.modal-dialog").css("width", objIn.width);
        }
        if (typeof objIn._HtmlBody === 'undefined') {
            if (typeof objIn.message === "string") {
                var text = objIn.message, divs = $('#confirmation div.modal-content div.modal-body');
                divs.empty();
                if (typeof objIn.font === 'object') {
                    var appendText = "<font ";
                    if (typeof objIn.font.size === "string") {
                        appendText += "size='" + objIn.font.size + "' ";
                    }
                    if (typeof objIn.font.color === "string") {
                        appendText += "color='" + objIn.font.color + "' ";
                    }
                    appendText += ">" + text + " </font>";
                    text = appendText;
                }
                divs.append(text);
            } else if (typeof objIn.body === 'object') {
                if (Array.isArray(objIn.body)) {
                    var length = objIn.body.length, object = objIn.body;
                    var divs = $('#confirmation div.modal-content div.modal-body');
                    divs.empty();
                    for (var i = 0; i < length; i++) {
                        var tempObj = object[i];
                        if (!isEmpty(tempObj)) {
                            divs.append("<div class='row' style='padding-left: 20px;'>" + tempObj + "</div>");
                        }
                    }
                }
            }
        } else {
            var divs = $('#confirmation div.modal-content div.modal-body');
            divs.empty();
            divs.append(objIn._HtmlBody);
        }
        $('#confirm').off('click');
        $('#cancel').off('click');
        if (typeof objIn.Yes === 'boolean' && !objIn.Yes) {
            var divs = $('#confirm');
            divs.remove();
        } else if (typeof objIn.Yes === "function") {
            $('#confirm').click(objIn.Yes);
        } else if (typeof objIn.Yes === "object") {
            if (typeof objIn.Yes.text === "string") {
                $('#confirm').text(objIn.Yes.text);
            }
            if (typeof objIn.Yes.opt === "function") {
                $('#confirm').click(objIn.Yes.opt);
            }
        }
        if (typeof objIn.No === 'boolean' && !objIn.No) {
            var divs = $('#cancel');
            divs.remove();
        } else if (typeof objIn.No === "function") {
            $('#cancel').click(objIn.No);
        } else if (typeof objIn.No === "object") {
            if (typeof objIn.No.text === "string") {
                $('#cancel').text(objIn.No.text);
            }
            if (typeof objIn.No.opt === "function") {
                $('#cancel').click(objIn.No.opt);
            }
        }
        if (typeof objIn.show === "function") {
            var fn = objIn.show;
            fn();
        }
        if (typeof objIn.noClose === "boolean" && objIn.noClose) {
            $("#confirmation").find('.close').remove();
        }
        typeof objIn.isStatic === "boolean" ? $("#confirmation").attr('data-backdrop', 'static') : "";
        //appending modal background inside the bigform-content 
        if (typeof objIn.isModal === "boolean" && !objIn.isModal) {
            var topPadding = 0;
            if (typeof objIn.paddingTop === "number") {
                topPadding = objIn.paddingTop;
            }
            if (typeof objIn.appendTo === "string") {
                $(objIn.appendTo).css("position", 'relative');
                $("#confirmation_overlay").appendTo(objIn.appendTo);
                $('#confirmation').zIndex($('#confirmation_overlay').zIndex()).appendTo(objIn.appendTo);
            }
            $("#confirmation").find('.close').remove();
            $('#confirmation').removeClass('modal').removeClass('fade').addClass('myClass');
            $("#confirmation").find('.modal-header').addClass('padding-5');
            $("#confirmation").find('.modal-body').addClass('padding-5');
            $("#confirmation").find('.modal-footer').addClass('padding-10');
            var x_axis = ($(objIn.appendTo).width() - $("#confirmation").width()) / 2;
            var y_axis = ($(objIn.appendTo).height() - $("#confirmation").height()) / 3;
            $("#confirmation_overlay").css('display', 'block');
            $("#confirmation").css('left', x_axis).css('top', y_axis + topPadding).show();
            localIsModal = false;
        } else {
            localIsModal = true;
            $("#confirmation-default-location").append($('#confirmation'));
            $("#confirmation-default-location").append($("#confirmation_overlay"));
            $('#confirmation').modal('show');
        }
    }

    function hideYesNo(callBackIn) {
        callBack = callBackIn;
        if (localIsModal) {
            $('#confirmation').modal('hide');
        } else {
            $("#confirmation_overlay").css('display', 'none');
            $('#confirmation').hide("fade", "fast", function () {
                $("#confirmation").empty();
            });
        }
    }

    $("#confirmation").on('hidden.bs.modal', function () {
//        if (localIsModal) {
        $("#confirmation").empty();
        if (typeof callBack === "function") {
            callBack();
            callBack = null;
        }
//        }
    });

    $.fn.multiline = function (text) {
        this.html(text);
        this.html(this.html().replace(/\n/g, '<br/>'));
        return this;
    };

    function isEmpty(obj) {
        var hasOwnProperty = Object.prototype.hasOwnProperty;
        if (obj == null) {
            return true;
        }
        if (obj.length > 0) {
            return false;
        }
        if (obj.length === 0) {
            return true;
        }
        for (var key in obj) {
            if (hasOwnProperty.call(obj, key))
                return false;
        }
        return true;
    }
</script>
