<legend>Post Dated Checks</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddPDC()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add PDC</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>Account No</label></td>
			<td><label>Check No</label></td>
			<td><label>Amount</label></td>		
            <td><label>Bank</label></td>
            <td><label>On Us</label></td>
            <td><label>Date</label></td>
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
        <g:if test="${collateralInstance?.pdcs}">
            <g:each var="pdc" in="${collateralInstance?.pdcs.sort{it.accountNo}}">
                <tr>
                    <td>${pdc?.accountNo}</td>
                    <td>${pdc?.checkNo}</td>
                    <td><g:formatNumber format="###,###,##0.00" number="${pdc?.amount}"/></td>
                    <td>${pdc?.bank}</td>
                    <td><g:formatBoolean boolean="${pdc?.onUs}" /></td>
                    <td><g:formatDate format="MM/dd/yyyy" date="${pdc?.pdcDate}"/></td>
                    <td><a href="#" class="btn btn-secondary" onclick="showUpdatePDC('${pdc?.id}')">Edit</a> 
                    <a href="#" class="btn btn-secondary" onclick="deletePDCAjax('${pdc?.id}')">Remove</a>
                    </td>
                </tr>
                
                
            </g:each>
            <g:each var="tot" in="${collateralInstance?.pdcs.sort{it.accountNo}.sum{it.amount}}">    
            <tr>
                                <td>TOTAL</td>
                                <td></td>
                                <td><label><g:formatNumber format="###,##0.00" number="${tot}" /></label></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                </tr>
            </g:each>
        </g:if>     
		<g:elseif test="${session["pdcs"]}">
			<g:set var="i" value="${0}" />
			<g:each var="pdc" in="${session["pdcs"]}">
                        
				<tr>
					<td>${pdc?.accountNo}</td>
					<td>${pdc?.checkNo}</td>
					<td>${pdc?.amount}</td>
                                        <td>${pdc?.bank}</td>
                                        <td><g:formatBoolean boolean="${pdc?.onUs}" /></td>
                                        <td><g:formatDate format="MM/dd/yyyy" date="${pdc?.pdcDate}"/></td>
					<td><a href="#" class="btn btn-secondary" onclick="showUpdatePDC('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deletePDCAjax('${i}')">Remove</a>
					</td>
				</tr>
                                
                                
                        <g:set var="i" value="${i = i + 1}" />
                        </g:each>  
                        <g:each var="total" in="${session["pdcs"].sum{it.amount}}">
                                <tr>
                                <td><label>TOTAL</label></td>
                                <td></td>
                                <td><label><g:formatNumber format="###,##0.00" number="${total}" /></label></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                </tr>
			
                        </g:each>
		</g:elseif>
	</tbody>
	</table>
</div>

<div class="modal" id="add-pdc-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add PDC</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addPDCAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-pdc-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update PDC</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="pdcId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updatePDCAjax()">Save</a>
            </div>
        </div>
    </div>
</div>

