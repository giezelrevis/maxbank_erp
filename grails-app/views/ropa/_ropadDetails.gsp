<div class="panel-heading">
    <h4>${ropaInstance?.loanAcctNo} - ${ropaInstance?.customerDisplayName}</h4>
</div>
<div class = "panel-body">
<table class="table table-bordered table-rounded table-striped table-hover">
    <tbody>
        <tr>
            <td style="width:30%"><label>Branch</label></td>
            <td style="width:70%">${ropaInstance?.branch?.name}</td> 
        </tr>    
        <tr>
            <td style="width:30%"><label>ROPA Date</label></td>
            <td style="width:70%"><g:formatDate  format="MM/dd/yyyy" date="${ropaInstance?.ropaDate}" /></td> 
        </tr>                             
    </tbody>
</table>
</div>


