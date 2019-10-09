<%@ page import="icbs.gl.GlAccount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
                <g:javascript>
            
                    var modal;

                        function showSortCodeModalSearch() {
                            modal = new icbs.UI.Modal({id:"glSearchModal", url:"${createLink(controller: 'search', action:'search', params:[searchDomain: "gl-sortcode"])}", title:"Search Gl Sort Codes", onCloseCallback:updateSortCode});
            
                            modal.show(); 
                        }

                        function updateSortCode () {
                            console.log("glSortCode: "+modal.onCloseCallbackParams['glSortCode3']);
                            console.log("glSortCodeHidden: "+modal.onCloseCallbackParams['glSortCode2']);
                            $("#glSortCode").val(modal.onCloseCallbackParams['glSortCode3']);
                            $("#glSortCodeHidden").val(modal.onCloseCallbackParams['glSortCode2']);
                
                        }
                </g:javascript>                
	</head>
	<body>
            <content tag="main-content">
		<div id="edit-glAccount" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${glAccountInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${glAccountInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="edit" url="[resource:glAccountInstance, action:'update']" method="PUT" name="update" >
				<g:hiddenField name="version" value="${glAccountInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="list" action="index">GL Accounts</g:link></li>
                    <li><g:link class="create" action="create">New GL Account</g:link></li>
                    <li><a href="#" onClick="alertOverridefuncedit();">Update</a></li>
                    <script>
                        function alertOverridefuncedit(){
                            checkIfAllowed("GEN00202", editGlAccountAuthCallback);   
                        }
                        function editGlAccountAuthCallback(){
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    // sending form into controller;
                                    document.getElementById("edit").submit();
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
