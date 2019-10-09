<legend>Sweep Accounts</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddSweepAccount()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Sweep Account</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>Account No.</label></td>			
			<td><label>Fund Limit</label></td>		
			<td><label>Remarks</label></td>
			<td><label>Order</label></td>
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
		<g:if test="${session["sweepAccounts"]}">
			<g:set var="i" value="${0}" />
			<g:each var="sweepAccounts" in="${session["sweepAccounts"]}">
				<tr>
					<td>${sweepAccounts?.depositAccount?.acctNo}</td>
					<td>${sweepAccounts?.rule?.description}</td>
					<td>${sweepAccounts?.remarks} %</td>						
					<td>${sweepAccounts?.ordinalNum}</td>					
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateSweepAccount('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteSweepAccountAjax('${i}')">Remove</a>
					</td>
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>
		</g:if>
	</tbody>
	</table>
</div>

<div class="modal" id="add-sweep-account-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Sweep Account</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addSweepAccountAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-sweep-account-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update Sweep Account</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="sweepAccountId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updateSweepAccountAjax()">Save</a>
            </div>
        </div>
    </div>
</div>

