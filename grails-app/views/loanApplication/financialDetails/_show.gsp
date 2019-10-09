
<legend>Financial Details</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
                <tbody>
			<tr>
				<td><label>Description</label></td>
				<td><label>Value</label></td>
				<td><label>Type</label></td>		
			</tr>
		</tbody>
		<tbody>
                    <g:set var="x" value="${0}" />
                    <g:set var="y" value="${0}" />
                    <g:set var="z" value="${0}" />
			<g:each var="financialDetail" in="${loanApplicationInstance?.financialDetails.sort{it.description}}">
			<tr>
				<td>${financialDetail?.description}</td>
				<td align="right"><g:formatNumber number="${financialDetail?.value}" format="###,##0.00" /></td>
				<td>${financialDetail?.type?.description}</td>
                                <g:if test="${financialDetail?.type?.description=='Expense'}">
                                    <g:set var="x" value="${x + financialDetail?.value}" />
                                </g:if>   
                                <g:elseif test="${financialDetail?.type?.description=='Income'}">
                                    <g:set var="y" value="${y + financialDetail?.value}" />
                                </g:elseif> 
                                <g:elseif test="${financialDetail?.type?.description=='Others'}">
                                    <g:set var="z" value="${z + financialDetail?.value}" />
                                </g:elseif>                                 
			</tr>
                        </g:each>                                        
		</tbody>
	</table>
</div>
<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">TOTAL INCOME</label>
    <span><g:formatNumber format="###,##0.00" number="${y}" /></span>
</div>
<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">TOTAL EXPENSE</label>
    <span><g:formatNumber format="###,##0.00" number="${x}" /></span>
</div>
<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">TOTAL OTHERS</label>
    <span><g:formatNumber format="###,##0.00" number="${z}" /></span>
</div>
<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">NET INCOME</label>
    <span><g:formatNumber format="###,##0.00" number="${y-x}" /></span>
</div>