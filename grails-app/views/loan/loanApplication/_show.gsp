<%@ page import="icbs.cif.CustomerInfobase" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<div class="fieldcontain form-group" style="display:none">
	<span id="customer-id">${loanApplicationInstance?.customer?.id}</span>
	<span id="product-id">${loanApplicationInstance?.product?.id}</span>
	<span id="loan-amount">${loanApplicationInstance?.amount}</span>
	<span id="loan-term">${loanApplicationInstance?.term}</span>
	<span id="loan-application-date"><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance?.applicationDate}"/></span>
        <span id="loan-application-status">${loanApplicationInstance?.approvalStatus?.description}</span> 
</div>
<table class="table table-bordered table-striped">
    <tr>
        <td style="font-weight:bold" width="30%">Loan Application</td>
        <td width="70%"><span><g:link  controller="loanApplication" action="show" id="${loanApplicationInstance?.id}">${loanApplicationInstance?.id}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Customer Name</td>
        <td width="70%"><span><g:link controller="customer" action="customerInquiry" id="${loanApplicationInstance?.customer?.id}">${loanApplicationInstance?.customer?.displayName}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Date of Birth</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance?.customer?.birthDate}"/></span></td>
    </tr> 
<g:set var="primaryAddress" value="${loanApplicationInstance?.customer?.addresses?.find{it.isPrimary==true}}"/>
<g:if test="${primaryAddress}">
    <g:set var="primaryAddress" value="${primaryAddress?.address1 + ', ' + primaryAddress?.address2 +', ' +primaryAddress?.address3}"/>
</g:if>
<g:else>
    <g:set var="primaryAddress" value=""/>
</g:else>
    <tr>
        <td style="font-weight:bold" width="30%">Address</td>
        <td width="70%"><span>${primaryAddress}</span></td>
    </tr> 
<g:if test="${CustomerInfobase.findAllByCustomerAndStatus(loanApplicationInstance?.customer,ConfigItemStatus.get(2))}">
    
    <tr style="font-weight:bold">
        <td colspan="2">Customer Infobase</td>
    <tr>    
            <g:each in="${CustomerInfobase.findAllByCustomerAndStatus(loanApplicationInstance?.customer,ConfigItemStatus.get(2))}" status="i" var="infobase">
              
              <g:if test="${infobase.status.id==2}">
                <tr>  
                    <td colspan="2" style="background-color: white;">
                      ${fieldValue(bean: infobase, field: "infoMessage")}
                    </td>
                </tr>    
              </g:if>
            </g:each>
                <tr></tr>
</g:if>
    <tr>
        <td style="font-weight:bold" width="30%">Photo</td>
<g:if test="${(loanApplicationInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}">        
        <td width="70%"><span id="photo"><img width="140px" height="140px" src="${createLink(controller:'Attachment', action:'show', id: (loanApplicationInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></span></td>
</g:if>
<g:else>
        <td width="70%"><span></span></td>
</g:else>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Product</td>
        <td width="70%"><span><g:link controller="product" action="show" id="${loanApplicationInstance?.product?.id}">${loanApplicationInstance?.product?.name}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Branch</td>
        <td width="70%"><span><g:link controller="branch" action="show" id="${loanApplicationInstance?.branch?.id}">${loanApplicationInstance?.branch?.name}</g:link></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Currency</td>
        <td width="70%"><span>${loanApplicationInstance?.currency?.name}</span></td>
    </tr> 
    <tr>
        <td style="font-weight:bold" width="30%">Amount</td>
<g:if test="${(loanApplicationInstance)}">
        <td width="70%"><span><g:formatNumber format="###,###,##0.00" number="${loanApplicationInstance.amount}"/></span></td>
</g:if>
<g:else>
        <td width="70%"><span></span></td>
</g:else>
    </tr> 
    <tr>
        <td style="font-weight:bold" width="30%">Term</td>
        <td width="70%"><span><g:fieldValue bean="${loanApplicationInstance}" field="term"/></span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Purpose</td>
        <td width="70%"><span><g:fieldValue bean="${loanApplicationInstance}" field="purpose"/></span></td>
    </tr>  
    <tr>
        <td style="font-weight:bold" width="30%">Account Officer</td>
        <td width="70%"><span><g:fieldValue bean="${loanApplicationInstance}" field="accountOfficer"/></span></td>
    </tr>  
    <tr>
        <td style="font-weight:bold" width="30%">Application Date</td>
        <td width="70%"><span><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance?.applicationDate}"/></span></td>
    </tr> 
    <tr>
        <td style="font-weight:bold" width="30%">Status</td>
        <td width="70%"><span>${loanApplicationInstance?.approvalStatus?.description}</span></td>
    </tr>     
</table>    

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
