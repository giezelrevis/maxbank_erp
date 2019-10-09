<legend>Installment Schedule</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddInstallment()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Installment</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td class="col-sm-1"><label>No.</label></td>
			<td class="col-sm-3"><label>Installment Date</label></td>
			<td class="col-sm-3"><label>Principal</label></td>
			<td class="col-sm-3"><label>Interest</label></td>
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
		<%--<g:if test="${loanInstance?.loanInstallments}">
			<g:each var="installment" in="${loanInstance?.loanInstallments.sort{it.sequenceNo}}">
				<tr>
					<td>${installment?.sequenceNo}</td>
					<td><g:formatDate format="MM/dd/yyyy" date="${installment?.installmentDate}"/></td>
					<td>${installment?.principalInstallmentAmount}</td>		
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateInstallment('${installment?.id}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteInstallmentAjax('${installment?.id}')">Remove</a>
					</td>		
				</tr>
			</g:each>
		</g:if>--%>
		<g:if test="${session["installments"]}">
			<g:set var="i" value="${0}" />
			<g:each var="installment" in="${session["installments"]}">
				<tr>
					<td>${i + 1}</td>
					<td><g:formatDate format="MM/dd/yyyy" date="${installment?.installmentDate}"/></td>
					<td>${installment?.principalInstallmentAmount}</td>		
					<td>${installment?.interestInstallmentAmount}</td>		
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateInstallment('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteInstallmentAjax('${i}')">Remove</a>
					</td>		
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>		
		</g:if>
	</tbody>
	</table>
</div>

<div class="modal" id="add-installment-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Installment</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addInstallmentAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-installment-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update Installment</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="installmentId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updateInstallmentAjax()">Save</a>
            </div>
        </div>
    </div>
</div>

