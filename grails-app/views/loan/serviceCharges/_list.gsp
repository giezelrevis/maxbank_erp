<legend>Other Charges</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddServiceCharge()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Service Charge</button>
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
		<g:if test="${session["serviceCharges"]}">
			<g:set var="i" value="${0}" />
                        <g:set var="x" value="${0}" />
			<g:each var="serviceCharge" in="${session["serviceCharges"]}">
				<tr>
					<g:set var="type" value="${serviceCharge?.scheme?.type.id}" />
					<td>${serviceCharge?.scheme?.name}</td>
					<td>${serviceCharge?.scheme?.type?.description}</td>
					<td align="right"><g:formatNumber format="###,##0.00" number="${serviceCharge?.amount}" /></td>
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateServiceCharge('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteServiceChargeAjax('${i}')">Remove</a>
					</td>
				</tr>
				<g:set var="i" value="${i = i + 1}" />
                                <g:set var="x" value="${x = x + serviceCharge?.amount}" />
			</g:each>
                        <tr>
                        <td><label>TOTAL</label></td>
			<td></td>
			<td align="right"><g:formatNumber format="###,##0.00" number="${x}" /></td>
                        <td></td>
                        </tr>
		</g:if>
	</tbody>
	</table>
</div>

<div class="modal" id="add-service-charge-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Other Charge</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addServiceChargeAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-service-charge-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update Other Charges</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="serviceChargeId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updateServiceChargeAjax()">Save</a>
            </div>
        </div>
    </div>
</div>

