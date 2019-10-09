
<div class="fieldcontain form-group" style="display:hidden">
	<span id="customer-id">${loanApplicationInstance?.customer?.id}</span>
	<span id="product-id">${loanApplicationInstance?.product?.id}</span>
	<span id="loan-amount">${loanApplicationInstance?.amount}</span>
	<span id="loan-term">${loanApplicationInstance?.term}</span>
	<span id="loan-application-date"><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance?.applicationDate}"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.customer.label" default="Customer" />
	</label>

	<span id="customer-name2">${loanApplicationInstance?.customer?.displayName}</span>
</div>

<div id="customer-info">
    <div class="fieldcontain form-group">
        <span class="control-label col-sm-4">Date of Birth</span>
        <span id="birth-date">${loanApplicationInstance?.customer?.birthDate}</span>
    </div>

    <g:set var="primaryAddress" value="${loanApplicationInstance?.customer?.addresses?.find{it.isPrimary==true}}"/>
    <g:if test="${primaryAddress}">
    	<g:set var="primaryAddress" value="${primaryAddress?.address1 + ', ' + primaryAddress?.address2 +', ' +primaryAddress?.address3}"/>
	</g:if>
	<g:else>
		<g:set var="primaryAddress" value=""/>
	</g:else>
    <div class="fieldcontain form-group">
        <span class="control-label col-sm-4">Address</span>
		<span id="address">${primaryAddress}</span>
    </div>

     
    <div class="fieldcontain form-group">
        <span class="control-label col-sm-4">Photo</span>
        <span id="photo">
    	<g:if test="${(loanApplicationInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> 	
		<img width="140px" height="140px" src="${createLink(controller:'Attachment', action:'show', id: (loanApplicationInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/>
		</g:if>
        </span>
    </div>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.product.label" default="Product" />
	</label>

	<span id="product-name2">${loanApplicationInstance?.product?.name}</span>
</div>

<div class="fieldcontain form-group">	
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.branch.label" default="Branch" />
	</label>

	<span>${loanApplicationInstance?.branch?.name}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.currency.label" default="Currency" />
	</label>

	<span>${loanApplicationInstance?.currency?.name}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.amount.label" default="Amount" />
	</label>

	<span><g:fieldValue bean="${loanApplicationInstance}" field="amount"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.term.label" default="Term" />
	</label>

	<span><g:fieldValue bean="${loanApplicationInstance}" field="term"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.purpose.label" default="Purpose" />
	</label>

	<span><g:fieldValue bean="${loanApplicationInstance}" field="purpose"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.applicationDate.label" default="Application Date" />
	</label>

	<span><g:formatDate format="MM/dd/yyyy" date="${loanApplicationInstance?.applicationDate}"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">
		<g:message code="loanApplication.status.label" default="Status" />
	</label>

	<span>${loanApplicationInstance?.approvalStatus?.description}</span>
</div>