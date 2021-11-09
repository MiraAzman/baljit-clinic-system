<%
    String s_bussapp = (String) session.getAttribute("bussapp");
    String s_usercode = (String) session.getAttribute("usercode");
    System.out.println("bussapp123=" + s_bussapp);
    System.out.println("usercode123=" + s_usercode);
%>
<!-- User info -->
<div class="login-info">
    <span> <!-- User image size is adjusted inside CSS, it should stay as is --> 

        <a href="javascript:void(0);" id="show-shortcut" data-action="toggleShortcut">
            <img src="img/avatars/DrKoImg.png" alt="me" class="online" /> 
<!--            <span data-localize="<%= session.getAttribute("bussapp_name")%>">
                <%= session.getAttribute("bussapp_name")%>
            </span>-->
                <span data-localize="<%= session.getAttribute("fullname")%>">
                <%= session.getAttribute("fullname")%>
            </span>
            <i class="fa fa-angle-down"></i>
        </a> 

    </span>


</div>
<!-- end user info -->

<!-- NAVIGATION : This navigation is also responsive

To make this navigation dynamic please make sure to link the node
(the reference to the nav > ul) after page load. Or the navigation
will not initialize.
-->

<navigation>
    <nav:item data-view="/dashboard" data-icon="fa fa-lg fa-fw fa-home" title="Dashboard" />
    <nav:group data-icon="fa fa-lg fa-fw fa-wrench" title="Settings" >
        <nav:item data-view="/EnvironmentSettings" title="System Environment Settings" />
        <nav:item data-view="/CompanyList" title="Company Setup" />
        <nav:item data-view="/LocationList" title="Location Setup" />
        <nav:item data-view="/UserList" title="User Setup" />
        <nav:item data-view="/CodeSetupList" title="Code Setup" />
        <nav:item data-view="/UOMMasterList" title="UOM Setup" />
        <nav:item data-view="/ProductMasterList" title="Product Master" />
        <nav:item data-view="/SupplierMasterList" title="Supplier Master" />
         
    </nav:group>
    
    <nav:group data-icon="fa fa-lg fa-fw fa-shopping-cart"  title="Transaction" >
        <nav:item data-view="/PurchaseOrderList" title="Purchase Order" /> 
        <nav:item data-view="/GRN" title="Goods Receive" />    
        <!--<nav:item data-view="/GRN2" title="Goods Receive Setup" />-->   
        <nav:item data-view="/StockRequestList" title="Stock Request" /> 
        <nav:item data-view="/NewStockTransfer" title="Manage Stock Transfer" />  
        <nav:item data-view="/StockDespatchList" title="Manage Stock Dispatch" />  
        <nav:item data-view="/StockReturnList" title="Manage Stock Return" />  
         
         
    </nav:group>
    
    <nav:group data-icon="fa fa-lg fa-fw fa-wrench" title="Reports" >
        <nav:item data-view="/StockBalanceReport" title="Stock Balance Report" /> 
         <nav:item data-view="/StockMovementReport" title="Stock Movement Report" /> 
        <nav:item data-view="/StockStatusReport" title="Stock Status Report" />
        <nav:item data-view="/StockSalesReport" title="Stock Sales Report" />
        <nav:item data-view="/StockRequestReport" title="Stock Request Report" />
        <nav:item data-view="/StockTransferReport" title="Stock Transfer Report" />
        <nav:item data-view="/StockDespatchReport" title="Stock Dispatch Report" />
    </nav:group>
<!--    <nav:group data-icon="fa fa-lg fa-fw fa-shopping-cart" title="Purchase Order" >
        <nav:item data-view="/PurchaseOrderList" title="Purchase Order History" />        
    </nav:group>

    <nav:group data-icon="fa fa-lg fa-fw fa-shopping-cart" title="Goods Receive" >
        <nav:item data-view="/GRN" title="Goods Receive" />        
    </nav:group>
    <nav:group data-icon="fa fa-lg fa-fw fa-arrows-h" title="Stock Request" >
        <nav:item data-view="/StockRequestList" title="Stock Request List" />        
    </nav:group>

    <nav:group data-icon="fa fa-lg fa-fw fa-shopping-cart" title="Stock Transfer" >
        <nav:item data-view="/NewStockTransfer" title="Manage Stock Transfer" />        
    </nav:group>
    <nav:group data-icon="fa fa-lg fa-fw fa-shopping-cart" title="Stock Despatch" >
        <nav:item data-view="/StockDespatchList" title="Manage Stock Despatch" />        
    </nav:group>-->

</navigation>
<span class="minifyme" data-action="minifyMenu"> <i class="fa fa-arrow-circle-left hit"></i> </span>