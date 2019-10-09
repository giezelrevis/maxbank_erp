<legend>Deductions</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddDeduction()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Deduction</button>
</div>    
   
<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>Scheme</label></td>
			<td><label>Type</label></td>
			<td><label>Amount</label></td>		
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
		<g:if test="${session["deductions"]}">
			<g:set var="i" value="${0}" />
                        <g:set var="x" value="${0}" />
			<g:each var="deduction" in="${session["deductions"]}">
				<tr>
					<g:set var="type" value="${deduction?.scheme?.type.id}" />
					<td>${deduction?.scheme?.name}</td>
					<td>${deduction?.scheme?.type?.description}</td>
					<td align="right"><g:formatNumber format="###,##0.00" number="${deduction?.amount}" /></td>					
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateDeduction('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteDeductionAjax('${i}')">Remove</a>
					</td>
				</tr>
				<g:set var="i" value="${i = i + 1}" />
                                <g:set var="x" value="${x + deduction?.amount}" />
			</g:each>
                        <tr>
                            <td><label>TOTAL DEDUCTION AMOUNT</label>
                            <td><label></label>
                            <td align="right"><label><g:formatNumber format="###,##0.00" number="${x}" /></label></td>
                        </tr>  
		</g:if>
	</tbody>
	</table>
</div>

<div class="modal" id="add-deduction-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Deduction</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addDeductionAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-deduction-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update Deduction</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="deductionId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updateDeductionAjax()">Save</a>
            </div>
        </div>
    </div>
</div>

