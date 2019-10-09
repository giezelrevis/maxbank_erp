<%@ page import="icbs.tellering.TxnTellerCash" %>



<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control" onchange="changetype();">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(2),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
    <input type="text" id="currency_id" value=0 style="display:none">
    <script>
            var totalcash = 0;

            function testchange()
            {
                 console.log($('#txnTemplate').val());
                 var xhttp = new XMLHttpRequest();
                 xhttp.onreadystatechange = function() {
                     if (xhttp.readyState == 4 && xhttp.status == 200) {
                         //console.log(JSON.parse(xhttp.responseText).currency);
                         currency_id.value = JSON.parse(xhttp.responseText).currency;
                         $.each(JSON.parse(totJSON),function(key,value){
                             if(value.currency_id == currency_id.value)
                             {
                                 totalcash = value.cashin - value.cashout;  
                             }
                         });
                     }
                 }
                 xhttp.open("POST", "getCurrencyOnTemplate?recid="+$('#txnTemplate').val(),true);
                 xhttp.send();
            }
        
        
            function myFunction()
            {
              var inp = document.getElementsByName('tblinput'),
              oup = document.getElementsByName('linetotal'),
              tot = document.getElementsByName('totalamt'),
              cid = document.getElementsByName('currencyidx'),
              total = 0;
              for(i = 0; i < inp.length; i++)
              {
                //outp[0].value;
                //tot[i].value = inp[i].value * oup[i].value;
                cv = inp[i].value * oup[i].value;
                //console.log('? cv ? '+cv);
                tot[i].value = accounting.formatNumber(cv,2);
                total = total + accounting.unformat(tot[i].value);
              }
              //console.log(inp[0].value);
              w = accounting.formatNumber(total,2);
             // alert(w);
          
              $('#total').val(w);
              c =   total;
                
            }
 
             function changetype(){
            
                var transtype = $('#txnTemplate').val(),
                //cURL = (transtype == 1 ? '/icbs/tellering/createPHPbreakdown':'/icbs/tellering/createUSDbreakdown');
                
                // get transtype from json to determine the currency id for the transaction
                // selected transtype(TxnTemplate) --/> JSON process(get currency) --/>generate breakdown
                
                cURL = '/icbs/tellering/getTellerCashFromVaultTxnBreakDown';
                
                
                
                //return;
                
                $.get(cURL,{recid : transtype},function(data){
                    //console.log(data);
                    if(data == "[]")
                    {
                        alertify.alert(AppTitle,"No currency breakdown for this type!",function(){return;});
                    }
                    //document.getElementById('currencyarea').text = data;
                    //$('#currencyarea').html(data);
                    var dd = '<table id="tbl_total" class="table table-bordered table-striped"><legend class="section-header"><h4>Breakdown</h4> </legend><tbody>';
                    $.each(JSON.parse(data),function(key,value){
                        prtme = JSON.parse(value);
                        dd += '<tr>';
                        dd += '<td>';
                        dd += '<strong>'+prtme.longdesc+'</strong>';
                        dd += '</td>';
                        dd += '<td>';
                        dd += '<input type="number" name="tblinput" id="tblinput" value=0 class="form-control" onchange="myFunction()">';
                        dd += '<input type="number" name="linetotal" value='+prtme.value+' style="display:none">';
                        dd += '</td>';
                        dd += '<td>';
                        dd += '<input readonly type="text" name="totalamt" id="totalamt" value=0 class="form-control">';
                        dd += '<input readonly type="number" name="currencyidx" id="currencyidx" value='+prtme.id+' class="form-control" style="display:none">';
                        dd += '</td>';
                        dd += '</tr>';
                       // console.log(JSON.parse(value).index);
                    });
                    dd += '<tr>';
                    dd += '<td>';
                        
                    dd += '</td>';
                    dd += '<td>';
                        
                    dd += '</td>';
                    dd += '<td>';
                    dd += '<input readonly type="text"  name="total" id="total" value="0" class="form-control total">';
                       
                    dd += '</td>';
                    dd += '</tr>';
                    dd += '</tbody></table>';
                    $('#currencyarea').html(dd);
                    testchange();
                });
            }
            var validateAdutoDecimal=0;
            var validateloop = 0;
            function numberFormat(){

                var number1 = document.getElementsByName("txnAmt")[0].value;
               var number
                number = number1.toString();
                number += '';
                number = number.replace(/,/g , "");
               
                x = number.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                
               
                var fieldvalue = x1 + x2;
              
                
                document.getElementsByName("txnAmt")[0].value = fieldvalue;
                 

              }
    </script>
</div>



<div class="fieldcontain form-group ${hasErrors(bean: txnCashTransferInstance, field: 'user', 'has-error')} ">
    <label class="control-label col-sm-4" for="user">
        <g:message code="txnCashTransfer.user.label" default="Destination Teller" />
    </label>

    <div class="col-sm-6">
        <g:select id="user" name="user" from="${jList}" optionKey="id" optionValue="name" value="${txnCashTransferInstance?.user?.id}" class="many-to-one form-control" noSelection="['null': '']" />
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashTransferInstance, field: 'txnAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnAmt">
        <g:message code="txnCashTransfer.txnAmt.label" default="Total Cash Transferred" />
    </label>

    <div class="col-sm-6">
        
        <g:field  type="text" id="txnAmt" name="txnAmt" value="${fieldValue(bean: txnCashTransferInstance, field: 'txnAmt')}" onkeyup="numberFormat();" step="0.001" class="txn-amt form-control"/>
        <!--<input id="txnAmt"  name="txnAmt" required="" value="${fieldValue(bean: txnCashTransferInstance, field: 'txnAmt')}" class="txn-amt form-control truncated" onkeyup="numberFormat();"/>-->
       
    </div>             
</div>

<div class="container-fluid">
    <div class="col-xs-9">
        <div class="infowrap">
            <div id="currencyarea">
            </div>
        </div>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashTransferInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnRef">
            <g:message code="txnCashTransfer.txnRef.label" default="Transaction Reference" />
    </label>

    <div class="col-sm-6">
        <g:textArea name="txnRef" value="${txnCashTransferInstance?.txnRef}"class="form-control"/>
    </div>             
</div>