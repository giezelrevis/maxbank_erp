<div class="panel-heading">
    <h4>${cashInBankInstance?.bankName} - ${cashInBankInstance?.acctNo}</h4>
</div>
<div class = "panel-body">
<table class="table table-bordered table-rounded table-striped table-hover">
    <tbody>
        <tr>
            <td style="width:30%"><label>Branch</label></td>
            <td style="width:70%">${cashInBankInstance?.bankBranch}</td> 
        </tr>    
        <tr>
            <td style="width:30%"><label>Date Opened</label></td>
            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${cashInBankInstance?.openDate}" /></td> 
        </tr> 
        <tr>
            <td style="width:30%"><label>Balance</label></td>
            <td style="width:70%"><g:formatNumber format="###,###,###,##0.00" number="${cashInBankInstance?.balance}"/></td> 
        </tr>                             
    </tbody>
</table>
</div>
