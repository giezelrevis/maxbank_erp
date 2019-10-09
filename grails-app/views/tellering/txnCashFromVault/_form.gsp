<%@ page import="icbs.tellering.TxnTellerCash" import="icbs.tellering.TxnFile" %>
<%@ defaultCodec="none" %>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" required="true" class="many-to-one form-control" onchange="changetype();">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(1),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
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
                console.log(inp[i].value);
                console.log(oup[i].value);
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
            
            $(function() {
                toCalc = $('.to-calc');
                $(toCalc).add('.txn-amt').change(function() {
                    console.log('change?');
                    $(toCalc).each(function() {
                        denomination = $(this).attr('id');
                        console.log(denomination);
                    });
                });
                
            });
 
            function changetype(){
            
                var transtype = $('#txnTemplate').val(),
                //cURL = (transtype == 1 ? '/icbs/tellering/createPHPbreakdown':'/icbs/tellering/createUSDbreakdown');
                
                // get transtype from json to determine the currency id for the transaction
                // selected transtype(TxnTemplate) --/> JSON process(get currency) --/>generate breakdown
                
                cURL = '/icbs/tellering/getTellerCashFromVaultTxnBreakDown';
                
                
                
                //return;
                
                $.get(cURL,{recid : transtype},function(data){
                    console.log(data);
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
                });
            }
    </script>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashFromVaultInstance, field: 'txnAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnAmt">
        <g:message code="txnCashFromVault.txnAmt.label" default="Total Cash Received" />
    </label>

    <div class="col-sm-6">
        <g:field id="txnAmt" name="txnAmt" required="true" value="${fieldValue(bean: txnCashFromVaultInstance, field: 'txnAmt')}" class="form-control truncated"/>
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

<div class="fieldcontain form-group ${hasErrors(bean: txnCashFromVaultInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnRef">
            <g:message code="txnCashFromVault.txnRef.label" default="Transaction Reference" />
    </label>

    <div class="col-sm-6">
        <g:textArea id="txnRef" name="txnRef" required="true" value="${txnCashFromVaultInstance?.txnRef}"class="form-control"/>
    </div>             
</div>
