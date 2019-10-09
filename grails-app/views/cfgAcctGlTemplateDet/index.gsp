
<%@ page import="icbs.gl.CfgAcctGlTemplateDet" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet')}" />
		<title>GL Link Account Entries</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">GL Link Account Entries</span>
            </content>
            <content tag="main-content">   
		<div id="list-cfgAcctGlTemplateDet" class="content scaffold-list" role="main">
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
					
						<g:sortableColumn property="glDescription" title="${message(code: 'cfgAcctGlTemplateDet.glDescription.label', default: 'Name')}" />
						
						<th><g:message code="cfgAcctGlTemplateDet.glAcct.label" default="GL Account Name" /></th>
						<!-- <th>GL Code</th> -->
						<th><g:message code="cfgAcctGlTemplateDet.glTemplate.label" default="GL Link Account Template" />
						</th>
						
					</tr>
				</thead>
				<tbody>
				<g:each in="${cfgAcctGlTemplateDetInstanceList}" status="i" var="cfgAcctGlTemplateDetInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
						<td><g:link action="show" id="${cfgAcctGlTemplateDetInstance.id}">${fieldValue(bean: cfgAcctGlTemplateDetInstance, field: "glDescription")}</g:link></td>
						
						<!-- <td>${fieldValue(bean: cfgAcctGlTemplateDetInstance, field: "glDescription")}</td> -->
						
						<td>${fieldValue(bean: cfgAcctGlTemplateDetInstance, field: "glCode")}</td>
						
						<td>${fieldValue(bean: cfgAcctGlTemplateDetInstance, field: "glDescription")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
		
			<div class="pagination">
				<g:paginate total="${CfgAcctGlTemplateDetInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li> 
                    <li><a class="home" href="${createLink(uri: '/CfgAcctGlTemplate')}">GL Link Account Templates</a></li> 
		</ul>
            </content>
	</body>
</html>
