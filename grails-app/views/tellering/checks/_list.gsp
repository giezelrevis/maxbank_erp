<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<input type="hidden" id="test_check" value="">
<input type="hidden" id="test_checkAmt" >
<div class="table-responsive" id="check_table">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <table id="tblcheck" class="table table-hover table-condensed table-bordered table-striped">
    <thead>
        <tr>
            <td><label>Check Type</label></td>
            <td><label>Bank</label></td>
            <td><label>Account Number</label></td>
            <td><label>Check Date</label></td>
            <td><label>Check Number</label></td>
            <td><label>Check Amount</label></td>
            <td class="col-sm-2"><label>Actions</label></td>		
	</tr>
    </thead>
    <tbody>
        <g:if test="${txnCheckDepositInstance?.checks}">
            <g:each var="check" in="${txnCheckDepositInstance?.checks.sort{it.description}}">
                <tr>
                    <td>${check?.checkType?.description}</td>
                    <td>${check?.bank?.name}</td>
                    <td>${check?.acctNo}</td>
                    <td>${check?.checkDate}</td>
                    <td>${check?.checkNo}</td>
                    <td>${check?.checkAmt}</td>
                    <td>
                        <a href="#" class="btn btn-secondary" onclick="deleteCheckAjax('${check?.id}')">Remove</a>
                    </td>		
                </tr>
            </g:each>
        </g:if>
        <g:elseif test="${session["checks"]}">
            <g:set var="i" value="${0}" />
            <g:each var="check" in="${session["checks"]}">
                <tr>
                    <td>${check?.checkType?.description}</td>
                    <td>${check?.bank?.name}</td>
                    <td>${check?.acctNo}</td>
                    <td>${check?.checkDate?.format("MM/dd/yyyy")}</td>
                    <td>${check?.checkNo}</td>
                    <td align="right"><g:formatNumber format="###,###,##0.00" number="${check?.checkAmt}"/></td>
                    <td>
                        <a href="#" class="btn btn-secondary" onclick="deleteCheckAjax('${i}')">Remove</a>
                    </td>		
                </tr>
                <g:set var="i" value="${i = i + 1}" />
            </g:each>
        </g:elseif>
    </tbody>
    </table>
</div>
<script>
    testlength = document.getElementById('tblcheck').getElementsByTagName('tbody')[0].getElementsByTagName('tr').length;
    $('#test_check').val(testlength);
    
    var x = 0;
    var y = 0;
    for (var i = 1; i < document.getElementById("tblcheck").rows.length; i++) 
    { 
        //x += accounting.unformat(nFix(document.getElementById("tblcheck").rows[i].cells[5].innerHTML)); 
        y += accounting.unformat(document.getElementById("tblcheck").rows[i].cells[5].innerHTML); 
//        x += parseFloat(document.getElementById("tblcheck").rows[i].cells[5].innerHTML); 
    } 
    console.log("AMMMMMMMMMMMMMMMMM");
    y = accounting.toFixed(y, 2);
    console.log("y:   "+y);
    document.getElementById("test_checkAmt").value = y;
    Check_Control = accounting.unformat($('#test_checkAmt').val());
    Check_Control_Total = accounting.toFixed(Check_Control, 2);
    $('#Check_Control_Total').val(addCommas(Check_Control_Total));

    function addCommas(nStr)
        {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }

</script>
