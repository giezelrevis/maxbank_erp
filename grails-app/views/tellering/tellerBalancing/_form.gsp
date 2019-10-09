<%@ page import="icbs.tellering.TxnTellerCash" import="icbs.tellering.TxnFile" %>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" required="true" class="many-to-one form-control" onchange="changetype();">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.Currency.findAllByConfigItemStatus(icbs.lov.ConfigItemStatus.read(2))}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}">${txnTemplateInstance.code + ' - ' + txnTemplateInstance.name}</option>
            </g:each>
        </select>
    </div>
    <script>
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
                cv = inp[i].value * oup[i].value;
               ///  console.log(inp[i].value);
               // console.log(oup[i].value);
              //  console.log('? cv ? '+cv);
                tot[i].value = accounting.formatNumber(cv,2);
                //tot[i].value = inp[i].value * oup[i].value;
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
                // get transtype from json to determine the currency id for the transaction
                // selected transtype(TxnTemplate) --/> JSON process(get currency) --/>generate breakdown   
                cURL = '/icbs/tellering/getTellerCashFromVaultTxnBreakDown';
                $.get(cURL,{recid : transtype, istellerbalance : 1},function(data){
                    //console.log(data);
                    if(data == "[]")
                    {
                        alertify.alert(AppTitle,"No currency breakdown for this type!",function(){$('#currencyarea').html('');return;});
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
                        dd += '<input type="number" name="tblinput" id="tblinput" value=0 class="form-control" onkeyup="myFunction()">';
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
                    dd += '<input readonly type="text"  name="total" id="total" value="0" class="form-control total"><input type="checkbox" id="isNega" name="isNega" style="display:none">';
                       
                    dd += '</td>';
                    dd += '</tr>';
                    dd += '</tbody></table>';
                    $('#currencyarea').html(dd);
                });
            }
    </script>
</div>



<div class="fieldcontain form-group ${hasErrors(bean: tellerBalancingInstance, field: 'txnAmt', 'has-error')}required" >
    <label class="control-label col-sm-4" for="txnAmt">
         <g:message code="tellerBalancing.txnAmt.label" default="Enter Total Cash Amount" />
         </label>

    <div class="col-sm-6">
        <g:field placeholder="Enter Total Cash Amount" name="txnAmt" value= "0" class="txn-amt form-control "/>
    </div>             
</div>

<div class="container-fluid">
    <fieldset class="col-xs-9">
        <div class="infowrap">
            <div id="currencyarea">
            </div>
        </div>
    </fieldset>
</div>
            
        </content>
   

