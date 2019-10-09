<%@ page import="icbs.tellering.TxnTellerCash" %>

<div class="form-group">
    <label class="control-label">Transaction Reference</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control" onchange="changeview()">
            <option selected="selected" readonly="true">-- Select a transaction reference --</option>
            <g:each in="${sourcetxn}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}">${txnTemplateInstance.txn_ref}</option>
            </g:each>
        </select>
    </div>
</div>

<script>
    
        $('#txnCashTransferForm').on('submit',function(e){
            //notify.info('submit init');
        });
    
        function add_commas(number){
                if(number == null) { number = 0; }
                number = '' + number;
                if (number.length > 3) {
                        var mod = number.length % 3;
                        var output = (mod > 0 ? (number.substring(0,mod)) : '');
                        for (i=0 ; i < Math.floor(number.length / 3); i++) {
                                if ((mod == 0) && (i == 0))
                                        output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
                                else
                                        output+= ',' + number.substring(mod + 3 * i, mod + 3 * i + 3);
                        }
                        return (output);
                }
                else return number;
            }
            
        function ASDASSDFSFG()
        {
            var res2 = $.post('/icbs/tellering/receiveTellerCashJSON',{recid : $('#txnTemplate').val(), txn : 1});
            res2.success(function(data){
                console.log(data);
                var currencyidx = document.getElementsByName('currencyidx'),
                linetotal = document.getElementsByName('linetotal'),
                tblinput = document.getElementsByName('tblinput'),
                totalamt = document.getElementsByName('totalamt'), i, grtotal = 0;
                 console.log(currencyidx.length);
                 

                $.each(JSON.parse(data),function(key,val){
                    //console.log(val.billcount);
                    //console.log(val.currencydetail_id);

                    for(i=0;i<currencyidx.length;i++)
                    {
                        if(currencyidx[i].value == val.currencydetail_id)
                        {
                            console.log(val.currencydetail_id);
                            tblinput[i].value = val.billcount;
                            totalamt[i].value = accounting.toFixed(accounting.unformat(linetotal[i].value) * accounting.unformat(val.billcount),2);
                            grtotal += accounting.unformat(totalamt[i].value);
                            totalamt[i].value = accounting.formatNumber(accounting.unformat(totalamt[i].value),2);
                            console.log(i);
                            break;
                        }
                    }
                    
                    $('#total').val(accounting.formatNumber(accounting.toFixed(grtotal,2),2));

                });
            });
        }
            
        function changeview()
        {
            
            var res = $.post('/icbs/tellering/receiveTellerCashJSON',{recid : $('#txnTemplate').val(), txn : 0});
            
            res.success(function(data){
                console.log('success '+data);
                //console.log('JSON '+JSON.parse(data)[0].id);
                var res = JSON.parse(data);
                $('#txn_type').val(res[0].txn_description);
                $('#txnAmt').val(res[0].txn_amt);
                $('#tellername').val(res[0].fullname);  
                
                
                
                var transtype = res[0].txn_template_id,
                cURL = '/icbs/tellering/getTellerCashFromVaultTxnBreakDown';
   
                $.get(cURL,{recid : transtype},function(data){
 
                    if(data == "[]")
                    {
                        alertify.alert(AppTitle,"No currency breakdown for this type!",function(){return;});
                    }
                    
                    console.log('write table');

                    var dd = '<table id="tbl_total" class="table table-bordered table-striped"><legend class="section-header"><h4>Breakdown</h4> </legend><tbody>';
                    $.each(JSON.parse(data),function(key,value){
                        prtme = JSON.parse(value);
                        dd += '<tr>';
                        dd += '<td>';
                        dd += '<strong>'+prtme.longdesc+'</strong>';
                        dd += '</td>';
                        dd += '<td>';
                        dd += '<input readonly type="number" name="tblinput" id="tblinput" value=0 class="form-control" onchange="myFunction()">';
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
                    
                    setTimeout(function(){ ASDASSDFSFG() },500);
                });
                 
  
            });
            
            res.error(function(data){
                console.log('error '+data);
            });
            
            res.fail(function(data){
                console.log('fail '+data);
            });
            
            var res2 = $.post('/icbs/tellering/receiveTellerCashJSON',{recid : $('#txnTemplate').val(), txn : 1});
                res2.success(function(data){
                    console.log(data);
                    var currencyidx = document.getElementsByName('currencyidx'),
                    linetotal = document.getElementsByName('linetotal'),
                    tblinput = document.getElementsByName('tblinput'),
                    totalamt = document.getElementsByName('totalamt'), i;
                     console.log(currencyidx.length);
                     
                    $.each(JSON.parse(data),function(key,val){
                        //console.log(val.billcount);
                        //console.log(val.currencydetail_id);
                       
                        for(i=0;i<currencyidx.length;i++)
                        {
                            if(currencyidx[i].value == val.currencydetail_id)
                            {
                                console.log(val.currencydetail_id);
                                tblinput[i].value = val.billcount;
                                //totalamt[i].value = parseFloat(linetotal[i].value) * parseInt(val.billcount);
                                console.log(i);
                                break;
                            }
                        }
                    
                    });
                });
           
        }
        
        
</script>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <input type="text" class="form-control" id="txn_type" readonly>
    </div>
</div>

<div class="form-group ">
    <label class="control-label col-sm-4">
        <g:message code="txnCashTransfer.user.label" default="Source Teller" />
    </label>

    <div class="col-sm-6">
        <input type="text" class="form-control" id="tellername" name="tellername" value="" readonly>
        
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCashTransferInstance, field: 'txnAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnAmt">
        <g:message code="txnCashTransfer.txnAmt.label" default="Total Cash Transferred" />
    </label>

    <div class="col-sm-6">
        <input type="text" class="form-control" id="txnAmt" name="txnAmt" value="${txnCashTransferInstance?.txnAmt}" readonly>
        
    </div>             
</div>

<div class="container-fluid">
    <div class="col-xs-9">
        <div class="infowrap">
            <div id="currencyarea">
            </div>
            <input type="hidden" id="txnRef"  name="txnRef" value="${txnCashTransferInstance?.txnRef}" class="form-control"/>
        </div>
    </div>
</div>
