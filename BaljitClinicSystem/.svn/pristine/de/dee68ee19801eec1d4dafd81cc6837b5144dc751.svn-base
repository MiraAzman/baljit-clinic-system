$('form.provUP_Ajax').on('submit',function(){
        var that = $(this),
        data={};
        
        var code = $('#lblPRVCode').val();
        that.find('[name]').each(function(index, value){
            var that = $(this),
            name = that.attr('name'),
            value = that.val();

            data[name] = value;
        });
        
        var cfmUP = confirm("Are you sure to UPDATE Provider"+code+"?");
        if(cfmUP==true){  
            $.ajax({
                url: "../../Servlet_CorpProviderAdmin_AddEdit",
                type: "post",
                data: data,
                success: function(response){
                    console.log(response.bool);
                    console.log(response.msg);
                    var r = confirm(response.msg+"\nProceed to view details?");
                    if(r==tr$ue){
                        window.location.href = "../Provider/Provider_Detail.jsp?PrvCode="+code;   
                    }else{
                        window.location.href = "../Provider/Provider_Search.jsp?";  
                    }
                },
                dataType: "json"
            });
            return false;
            
        }else{
            alert("NOT updated!");
            return false;
        }  
        return false;
});   
