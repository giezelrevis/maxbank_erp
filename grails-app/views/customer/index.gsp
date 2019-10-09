
<%@ page import="icbs.cif.Customer" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/branch')}">Branch Maintenance</a>
                <span class="fa fa-chevron-right"></span><span class="current">Branch Information</span>
            </content>
		<a href="#list-customer" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-customer" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="customer.customerAcctTypeId.label" default="Customer Acct Type Id" /></th>
					
						<th><g:message code="customer.genderId.label" default="Gender Id" /></th>
					
						<th><g:message code="customer.customerDosriCodeId.label" default="Customer Dosri Code Id" /></th>
					
						<th><g:message code="customer.customerStatusId.label" default="Customer Status Id" /></th>
					
						<g:sortableColumn property="displayId" title="${message(code: 'customer.displayId.label', default: 'Display Id')}" />
					
						<g:sortableColumn property="firstName" title="${message(code: 'customer.firstName.label', default: 'First Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${customerInstanceList}" status="i" var="customerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            
						<td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "customerAcctTypeId")}</g:link></td>
					
						<td>${fieldValue(bean: customerInstance, field: "genderId")}</td>
					
						<td>${fieldValue(bean: customerInstance, field: "customerDosriCodeId")}</td>
					
						<td>${fieldValue(bean: customerInstance, field: "customerStatusId")}</td>
					
						<td>${fieldValue(bean: customerInstance, field: "displayId")}</td>
					
						<td>${fieldValue(bean: customerInstance, field: "firstName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${customerInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
