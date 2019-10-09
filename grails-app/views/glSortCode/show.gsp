
<%@ page import="icbs.gl.GlSortCode" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glSortCode.label', default: 'Gl Sort Code')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-glSortCode" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<!-- <div class="message" role="status">${flash.message}</div> -->
                            <script>
                            $(function(){
                                var x = '${flash.message}';
                                    notify.message(x);
                                    //$('#SlipTransaction').hide();
                                    if(x.indexOf('|success') > -1){
                                    //$('#SlipTransaction').show();
                                }
                            });
                            </script>                            
			</g:if>
			<ol class="property-list glSortCode">
			
				<g:if test="${glSortCodeInstance?.sort_code}">
				<li class="fieldcontain">
					<span id="sort_code-label" class="property-label"><g:message code="glSortCode.sort_code.label" default="GL Sort Code" /></span>
					
						<span class="property-value" aria-labelledby="sort_code-label"><g:fieldValue bean="${glSortCodeInstance}" field="sort_code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glSortCodeInstance?.sort_name}">
				<li class="fieldcontain">
					<span id="sort_name-label" class="property-label"><g:message code="glSortCode.sort_name.label" default="Sort Code Name" /></span>
					
						<span class="property-value" aria-labelledby="sort_name-label"><g:fieldValue bean="${glSortCodeInstance}" field="sort_name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${glSortCodeInstance?.parent_id}">
				<li class="fieldcontain">
					<span id="parent_id-label" class="property-label"><g:message code="glSortCode.parent_id.label" default="Parent ID" /></span>
					
						<span class="property-value" aria-labelledby="parent_id-label"><g:link controller="glAcctType" action="show" id="${glSortCodeInstance?.parent_id?.id}">${glSortCodeInstance?.parent_id?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${glSortCodeInstance?.sort_code_status}">
				<li class="fieldcontain">
					<span id="sort_code_status-label" class="property-label"><g:message code="glSortCode.sort_code_status.label" default="Sort Code Status" /></span>
					
						<span class="property-value" aria-labelledby="sort_code_status-label"><g:formatBoolean boolean="${glSortCodeInstance?.sort_code_status}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:glSortCodeInstance, action:'delete']" method="DELETE">
                                <!--
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${glSortCodeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
                                -->
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="edit" action="edit" resource="${glSortCodeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
                    <li><g:form id="deleteSC" url="[resource:glSortCodeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
                                    <a href="#" onClick="alertifyConfirmOverrideFunction();">Delete</a>
				</fieldset>
			</g:form></li> 
                    <script>
                        function alertifyConfirmOverrideFunction(){
                            checkIfAllowed("GEN00206", deleteGlSortCodeAuthCallback);
                        }
                        function deleteGlSortCodeAuthCallback(){
                            alertify.confirm(AppTitle,'Are you sure you want to Delete this Gl Sort Code?',
                                function(){
                                    // sending form into controller;
                                    document.getElementById("deleteSC").submit();
                                },
                                function(){
                                    return;
                                });
                        }
                    </script>
		</ul>
            </content>
	</body>
</html>
