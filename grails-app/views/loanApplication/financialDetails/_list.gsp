<legend>Financial Details</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddFinancialDetail()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Financial Detail</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>Description</label></td>
			<td><label>Value</label></td>
			<td><label>Type</label></td>		
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
            <g:set var="x" value="${0}" />
            <g:set var="y" value="${0}" />
            <g:set var="z" value="${0}" />
		<g:if test="${loanApplicationInstance?.financialDetails}">
			<g:each var="financialDetail" in="${loanApplicationInstance?.financialDetails.sort{it.description}}">
				<tr>
					<td>${financialDetail?.description}</td>
					<td align="right"><g:formatNumber number="${financialDetail?.value}" format="###,##0.00" /></td>
					<td>${financialDetail?.type?.description}</td>		
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateFinancialDetail('${financialDetail?.id}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteFinancialDetailAjax('${financialDetail?.id}')">Remove</a>
					</td>		
				</tr>
                            <g:if test="${financialDetail?.type?.description=='Expense'}">
                                <g:set var="x" value="${x + financialDetail?.value}" />
                            </g:if>   
                            <g:elseif test="${financialDetail?.type?.description=='Income'}">
                                <g:set var="y" value="${y + financialDetail?.value}" />
                            </g:elseif> 
                            <g:elseif test="${financialDetail?.type?.description=='Others'}">
                                <g:set var="z" value="${z + financialDetail?.value}" />
                            </g:elseif>                                  
			</g:each>  
                </g:if>
		<g:elseif test="${session["financialDetails"]}">
			<g:set var="i" value="${0}" />
			<g:each var="financialDetail" in="${session["financialDetails"]}">
				<tr>
					<td>${financialDetail?.description}</td>
					<td align="right"><g:formatNumber number="${financialDetail?.value}" format="###,##0.00" /></td>
					<td>${financialDetail?.type?.description}</td>		
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateFinancialDetail('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteFinancialDetailAjax('${i}')">Remove</a>
					</td>		
				</tr>
				<g:set var="i" value="${i = i + 1}" />
                                    <g:if test="${financialDetail?.type?.description=='Expense'}">
                                <g:set var="x" value="${x + financialDetail?.value}" />
                                </g:if>   
                                <g:elseif test="${financialDetail?.type?.description=='Income'}">
                                    <g:set var="y" value="${y + financialDetail?.value}" />
                                </g:elseif> 
                                <g:elseif test="${financialDetail?.type?.description=='Others'}">
                                    <g:set var="z" value="${z + financialDetail?.value}" />
                                </g:elseif>  
                            </g:each>
		</g:elseif>
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

<div class="modal" id="add-financial-detail-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Financial Detail</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addFinancialDetailAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-financial-detail-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update Financial Detail</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="financialDetailId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updateFinancialDetailAjax()">Save</a>
            </div>
        </div>
    </div>
</div>

