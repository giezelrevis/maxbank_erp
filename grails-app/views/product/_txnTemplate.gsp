<div class="form-group">
  <label for="category" class="control-label">Transactions</label>
  <div class="col-sm-6">
  
    <g:if test="${newEntry}">
       
        <select id="txnTemplates" name="txnTemplates" optionKey="id" optionValue="description" value="${productInstance?.txnTemplates?.id}" class="many-to-one form-control" multiple=""></select>
        <input type="text" id="test" style="display:none">
    <script>
        
        
        function testsel()
        {
            txnTemplates.value = '';
            var xhttp = new XMLHttpRequest();
                 xhttp.onreadystatechange = function() {
                     if (xhttp.readyState == 4 && xhttp.status == 200) {
                       $.each(JSON.parse(xhttp.responseText),function(key,value){
                        var sl = "<option id="+value.id+">"+value.description
                        $('#txnTemplates').append(sl);
                        
                     });
                        
                        
                     }
                 }
                 xhttp.open('POST', '/icbs/product/templateList?tid='+$("#productType").val(),true);
                 xhttp.send();
                 

        
        }
        
        
        
      
      </script>
    </g:if>
    
    <g:else>
        <g:select id="txnTemplates" name="txnTemplates" from="${tmplist}" optionKey="id" optionValue="description" value="${productInstance?.txnTemplates?.id}" class="many-to-one form-control" multiple="" />

    
    </g:else>
    
  </div>
</div>
                