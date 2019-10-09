<ul class="property-list txnTemplate">
			
	<g:if test="${txnTemplateInstance?.txnModule}">
	<li class="fieldcontain">
		<span id="txnModule-label" class="property-label"><g:message code="txnTemplate.txnModule.label" default="Txn Module" /></span>
		
			<span class="property-value" aria-labelledby="txnModule-label">${txnTemplateInstance?.txnModule?.description}</span>
		
	</li>
	</g:if>

	<g:if test="${txnTemplateInstance?.txnType}">
	<li class="fieldcontain">
		<span id="txnType-label" class="property-label"><g:message code="txnTemplate.txnType.label" default="Txn Type" /></span>
		
			<span class="property-value" aria-labelledby="txnType-label">${txnTemplateInstance?.txnType?.description}</span>
		
	</li>
	</g:if>

	<g:if test="${txnTemplateInstance?.code}">
	<li class="fieldcontain">
		<span id="code-label" class="property-label"><g:message code="txnTemplate.code.label" default="Code" /></span>
		
			<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${txnTemplateInstance}" field="code"/></span>
		
	</li>
	</g:if>

	<g:if test="${txnTemplateInstance?.description}">
	<li class="fieldcontain">
		<span id="description-label" class="property-label"><g:message code="txnTemplate.description.label" default="Description" /></span>
		
			<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${txnTemplateInstance}" field="description"/></span>
		
	</li>
	</g:if>

	<g:if test="${txnTemplateInstance?.shortDescription}">
	<li class="fieldcontain">
		<span id="shortDescription-label" class="property-label"><g:message code="txnTemplate.shortDescription.label" default="Short Description" /></span>
		
			<span class="property-value" aria-labelledby="shortDescription-label"><g:fieldValue bean="${txnTemplateInstance}" field="shortDescription"/></span>
		
	</li>
	</g:if>

</ul>