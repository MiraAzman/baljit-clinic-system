<%
    String s_bussapp = (String) session.getAttribute("bussapp");
    String s_usercode = (String) session.getAttribute("usercode");
    
%>
<!-- User info -->
<div class="login-info">
    <span> <!-- User image size is adjusted inside CSS, it should stay as is --> 

        <a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
<!--            <img src="img/avatars/tglim.png" alt="me" class="online" /> -->
            <span data-localize="<%= session.getAttribute("fullname")%>">
                <%= session.getAttribute("fullname")%>
            </span>
            <i class="fa fa-angle-down"></i>
        </a> 

    </span>


</div>
<%= session.getAttribute("items") %>

<span class="minifyme" data-action="minifyMenu"> <i class="fa fa-arrow-circle-left hit"></i> </span>
<script type="text/javascript">
pageSetUp();

</script>

