
<legend>Loan Specification</legend>
<div class="section-container">
    <legend class="section-header">Information</legend>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
	    <tbody>
                <tr>
                    <td style="font-weight:bold" width="30%">Application ID</td>
                    <td width="70%"><g:formatNumber format="#" groupingUsed="true" number="${fieldValue(bean: loanApplicationInstance, field: "id")}" /></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Status</td>
                    <td width="70%">${loanApplicationInstance?.approvalStatus?.description}</td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Customer</td>
                    <td width="70%"><g:link controller="customer" action="customerInquiry" id="${loanApplicationInstance?.customer?.id}">${loanApplicationInstance?.customer?.displayName}</g:link></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Date of Birth</td>
                    <td width="70%"><span id="birth-date"></span></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Address</td>
                    <td width="70%"><span id="address"></span></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Photo</td>
                    <td width="70%"><span id="photo"></span></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Total Released</td>
                    <td width="70%"><span id="total-released"></span></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Total Outstanding Principal Balance</td>
                    <td width="70%"><span id="total-balance"></span></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Number of Outstanding Loans</td>
                    <td width="70%"><span id="total-count"></span></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Product</td>
                    <td width="70%"><g:link controller="product" action="show" id="${loanApplicationInstance?.product?.id}">${loanApplicationInstance?.product?.name}</g:link></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Branch</td>
                    <td width="70%"><g:link controller="branch" action="show" id="${loanApplicationInstance?.branch?.id}">${loanApplicationInstance?.branch?.name}</g:link></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Currency</td>
                    <td width="70%">${loanApplicationInstance?.currency?.name}</td>
                </tr>     
                <tr>
                    <td style="font-weight:bold" width="30%">Amount</td>
                    <td width="70%"><g:formatNumber format="###,##0.00" number="${loanApplicationInstance?.amount}" /></td>
                </tr>  
                <tr>
                    <td style="font-weight:bold" width="30%">Term</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationInstance}" field="term"/></td>
                </tr>  
                <tr>
                    <td style="font-weight:bold" width="30%">Purpose</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationInstance}" field="purpose"/></td>
                </tr>  
                <tr>
                    <td style="font-weight:bold" width="30%">Account Officer</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationInstance}" field="accountOfficer"/></td>
                </tr>  
                <tr>
                    <td style="font-weight:bold" width="30%">Application Date</td>
                
                    <td width="70%"><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance.applicationDate}"/></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<g:if test="${loanApplicationSpecAdd?.id}">
<legend>Other Information</legend>
<div class="section-container">
    <legend class="section-header">Details</legend>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
	    <tbody>
                <tr>
                    <td style="font-weight:bold" width="30%">Interest Rate</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationSpecAdd}" field="interestRate"/></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Service Charge</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationSpecAdd}" field="serviceCharge"/></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Repayment Frequency</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationSpecAdd?.frequency}" field="description"/></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Guarantee Facility</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationSpecAdd?.guaranteeFacility}" field="description"/></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Pre Release</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationSpecAdd}" field="preRelease"/></td>
                </tr>
                <tr>
                    <td style="font-weight:bold" width="30%">Comments</td>
                    <td width="70%"><g:fieldValue bean="${loanApplicationSpecAdd}" field="comments"/></td>
                </tr> 
            </tbody>
        </table>
    </div>
</div>

</g:if>     
<!-- Comakers -->
<g:if test="${comakers}">       
<legend>Co-Makers</legend>
<div class="table-responsive">
	<table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>ID</label></td>
				<td><label>Name</label></td>
                                <td><label>Birthdate</label></td>
				<td class="col-sm-2"><label>Action</label></td>
			</tr>
		</tbody>
		<tbody>
                    
			<g:each var="comaker" in="${comakers}">
			<tr>
				<td>${comaker?.customer?.id}</td>
				<td>${comaker?.customer?.displayName}</td>
                                <td><g:formatDate format="MM/dd/yyyy" date="${comaker?.customer?.birthDate}"></g:formatDate></td>
				<td><g:link class="btn btn-secondary" controller="customer" action="customerInquiry" id="${comaker?.customer?.id}">View</g:link> 
			</tr>
			</g:each>
                    
		</tbody>
	</table>
</div>        
</g:if>

