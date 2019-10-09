
<%@ page import="icbs.gl.CfgAcctGlTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cfgAcctGlTemplate.label', default: 'CfgAcctGlTemplate')}" />
		<title>Account GL Link Templates</title>
	</head>
	<body>
            <content tag="breadcrumbs">
	            <span class="fa fa-chevron-right"></span><span class="current">Account GL Link Templates</span>
		</content>
            <content tag="main-content">   
		<div id="list-cfgAcctGlTemplate" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        
			<g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 350px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>
			
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<g:sortableColumn property="description" title="${message(code: 'cfgAcctGlTemplate.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'cfgAcctGlTemplate.type.label', default: 'Type')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cfgAcctGlTemplateInstanceList}" status="i" var="cfgAcctGlTemplateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cfgAcctGlTemplateInstance.id}">${fieldValue(bean: cfgAcctGlTemplateInstance, field: "description")}</g:link></td>
                                                <g:if test="${cfgAcctGlTemplateInstance.type==1}">
                                                    <td>Savings Deposit</td>
                                                </g:if>
                                                <g:elseif test="${cfgAcctGlTemplateInstance.type==2}">
                                                    <td>Current Account</td>
                                                </g:elseif>
                                                <g:elseif test="${cfgAcctGlTemplateInstance.type==3}">
                                                    <td>Time Deposit</td>
                                                </g:elseif> 
                                                <g:else>
                                                    <td>Loans</td>    
                                                </g:else>    
                                                <!--
						<td>${fieldValue(bean: cfgAcctGlTemplateInstance, field: "type")}</td>
                                                -->
                                                
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${CfgAcctGlTemplateInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><a class="home" href="${createLink(uri: '/CfgAcctGlTemplateDet')}">GL Link Account Entries</a></li>
                    
                    <li><g:link action="glLinkEntry">Create New GL Link </g:link></li>
            </content>
	</body>
</html>
