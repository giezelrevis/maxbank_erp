
<%@ page import="icbs.cif.Code" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme')}" />
		<title>CIF Codes</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-depositInterestScheme" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>          	
                            <div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				            <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <input type="text" name="query" class="form-control" placeholder="Enter Code or Name" value="" id="query" />
		                	<div class="input-group-btn">
		                    	<input type="submit" name="Search" class="btn btn-primary" value="Search" id="Search" />
		                	</div>
				        </div>
				    </div>
                            </div>				
                        </g:form>
                        </br>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>
					
						<th><g:message code="code.type.label" default="Type" /></th>
					
						<g:sortableColumn property="value" title="${message(code: 'code.value.label', default: 'Value')}" />
					
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${codeInstanceList}" status="i" var="codeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${codeInstance.id}">${fieldValue(bean: codeInstance, field: "type.itemValue")}</g:link></td>
					
						<td>${fieldValue(bean: codeInstance, field: "value")}</td>
					
					
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${CodeInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                     <li><g:link class="create" action="create">Create CIF Code</g:link></li>
		</ul>
            </content>
	</body>
</html>