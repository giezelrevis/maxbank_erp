
<%@ page import="icbs.gl.CfgAcctGlTemplateDet" %>
<%@ page import="icbs.lov.DepositStatus" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet')}" />
		<title>${cfgAcctGlTemplateDetInstance?.glDescription.encodeAsHTML()}</title>
	</head>
	<body>
             <content tag="breadcrumbs">
               <span class="fa fa-chevron-right"></span><span class="current">View Account GL Link Template Information</span>
            </content>
            <content tag="main-content">   
		<div id="show-cfgAcctGlTemplateDet" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list cfgAcctGlTemplateDet">
                            <div class="section-container">
                            <legend class="section-header">Details</legend>
                            <table class="table table-bordered table-rounded table-striped table-hover">
                                <tbody>
                                    <g:if test="${cfgAcctGlTemplateDetInstance?.glAcct}">
                                    <tr>
                                        <td style="width:30%">
                                            <span id="glAcct-label" class="property-label"><g:message code="cfgAcctGlTemplateDet.glAcct.label" default="GL Account" /></span>
                                        </td>
                                        <td style="width:70%">
                                            <span class="property-value" aria-labelledby="glAcct-label"><g:link controller="glAccount" action="show" id="${cfgAcctGlTemplateDetInstance?.glAcct?.id}">${cfgAcctGlTemplateDetInstance?.glAcct?.shortName.encodeAsHTML()} (${cfgAcctGlTemplateDetInstance?.glAcct?.code.encodeAsHTML()})</g:link></span>
                                        </td>
                                    </tr>
                                    </g:if>
                                    <g:if test="${cfgAcctGlTemplateDetInstance?.glDescription}">
                                    <tr>
                                        <td style="width:30%">
                                            <span id="glDescription-label" class="property-label"><g:message code="cfgAcctGlTemplateDet.glDescription.label" default="Description" /></span>
                                        </td>
                                        <td style="width:70%">
                                           <span class="property-value" aria-labelledby="glDescription-label"><g:fieldValue bean="${cfgAcctGlTemplateDetInstance}" field="glDescription"/></span>
                                        </td>
                                    </tr> 
                                    </g:if>
                                    <g:if test="${cfgAcctGlTemplateDetInstance?.glTemplate}">
                                    <tr>
                                        <td style="width:30%">
                                            <span id="glTemplate-label" class="property-label"><g:message code="cfgAcctGlTemplateDet.glTemplate.label" default="Template" /></span>
                                            </td>
                                        <td style="width:70%">
                                           <span class="property-value" aria-labelledby="glTemplate-label"><g:link controller="cfgAcctGlTemplate" action="show" id="${cfgAcctGlTemplateDetInstance?.glTemplate?.id}">${cfgAcctGlTemplateDetInstance?.glTemplate?.description.encodeAsHTML()}</g:link></span>
                                        </td>
                                    </tr> 
                                    </g:if> 
                                    <g:if test="${cfgAcctGlTemplateDetInstance?.glCode}">
                                    <tr>
                                        <td style="width:30%">
                                            <span id="glTemplate-label" class="property-label"><g:message code="cfgAcctGlTemplateDet.glTemplate.label" default="Gl Code" /></span>
                                        </td>
                                        <td style="width:70%">
                                           <span class="property-value" aria-labelledby="glTemplate-label"><g:fieldValue bean="${cfgAcctGlTemplateDetInstance}" field="glCode"/></span>
                                        </td>
                                    </tr> 
                                    </g:if>   
                                    <g:if test="${cfgAcctGlTemplateDetInstance?.ordinalPos}">
                                    <tr>
                                        <td style="width:30%">
                                            <span id="glTemplate-label" class="property-label"><g:message code="cfgAcctGlTemplateDet.glTemplate.label" default="Ordinal Position" /></span>
					</td>
                                        <td style="width:70%">
                                           <span class="property-value" aria-labelledby="glTemplate-label"><g:fieldValue bean="${cfgAcctGlTemplateDetInstance}" field="ordinalPos"/> </span>
					</td>
                                    </tr> 
                                    </g:if> 
                                    <tr>
                                        <td style="width:30%">
                                            <span id="glTemplate-label" class="property-label"><g:message code="cfgAcctGlTemplateDet.glTemplate.label" default="Status" /></span>
                                        </td>
                                        <g:if test="${cfgAcctGlTemplateDetInstance?.glTemplate.type==1 || cfgAcctGlTemplateDetInstance?.glTemplate.type==2 || cfgAcctGlTemplateDetInstance?.glTemplate.type==3}">  	
                                            <td style="width:70%">
                                                <span class="property-value" aria-labelledby="glTemplate-label">${icbs.lov.DepositStatus.findById(cfgAcctGlTemplateDetInstance.status)}</span>
                                            </td>
                                        </g:if>
                                        <g:else>
                                            <td style="width:70%">
                                                <span class="property-value" aria-labelledby="glTemplate-label">${icbs.lov.LoanPerformanceId.findById(cfgAcctGlTemplateDetInstance.status)}</span>
                                            </td>
                                        </g:else> 
                                    </tr> 
                                </tbody>
                            </table>
                            </div>
                       	</ol>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><g:link controller="CfgAcctGlTemplate" action="show" id="${icbs.gl.CfgAcctGlTemplateDet.findById(params.id).glTemplate.id}">Back</g:link></li>
                    <li><g:link controller="CfgAcctGlTemplate" action="glLinkCreateNewEntry" id="${icbs.gl.CfgAcctGlTemplateDet.findById(params.id).glTemplate.id}">Create New</g:link></li>
                    <li><g:link controller="CfgAcctGlTemplateDet" action="updatecfgacctdet" id="${params.id}">Update</g:link></li>
		</ul>
            </content>
	</body>
</html>
