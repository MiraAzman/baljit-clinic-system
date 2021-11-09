<%-- 
    Document   : loading-status
    Created on : May 15, 2015, 8:43:40 AM
    Author     : N0531
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="modal fade loading" id="progressModal" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog centered" style="width: 400px;" >
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    Creating Payment...
                </h4>
            </div>
            <div class="modal-body">
                <div class="progress">
                    <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                        0%
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $.showLoadingStatus = function (objIn) {
        $('#progressModal .progress-bar').css('width', 0 + '%').attr('aria-valuenow', 0).text(0 + '%');
        $("#progressModal").modal('show');
    };
    
    $.hideLoadingStatus = function () {
        $("#progressModal").modal('hide');
    };

    $.updateProgress = function (progress) {
        $('#progressModal .progress-bar').css('width', progress + '%').attr('aria-valuenow', progress).text(progress + '%');
    };
</script>