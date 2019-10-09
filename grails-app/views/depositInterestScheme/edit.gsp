<%@ page import="icbs.deposit.DepositInterestScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'depositInterestScheme.label', default: 'DepositInterestScheme')}" />
		<title>Edit Deposit Interest Scheme</title>
                <asset:javascript src="depositHelper.js"/>
                <g:javascript>
                    function isGraduatedChecked(){
                        var e = $("#isGraduated")
                        if ($(e).is(":checked")){
                            $($("#tabs").find("li")[1]).show();
                        }else{
                            $("#graduatedList").empty();
                            $($("#tabs").find("li")[1]).hide();
                        }
                    }
                    function addGraduatedAjax(){
                        icbs.Deposit.DepositInterestScheme.Form.getForm('graduated',"${createLink(controller : 'depositInterestScheme', action:'addGraduatedFormAjax')}");
                    }
                    
                </g:javascript>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/depositInterestScheme')}">Deposit Interest Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">Edit Deposit Interest Scheme</span>
            </content>
            <content tag="main-content">
		<div id="edit-depositInterestScheme" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${depositInterestSchemeInstance}">
			<ul class="errors" role="alert">
                            <!--
				<g:eachError bean="${depositInterestSchemeInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
                            -->    
			</ul>
			</g:hasErrors>
			<g:form id="DepositInterestSchemeForm" url="[resource:depositInterestSchemeInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${depositInterestSchemeInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:submitButton name="create" id="editDepositIntScheme" value="${message(code: 'default.button.update.label', default: 'Update')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG01003', 'form#DepositInterestSchemeForm', 'Override edit Deposit Interest Scheme.', null);
                                },
                                function(){
                                    return;
                                });                             
                        "/></li>
                    <!--<li><a href="#" onclick="$('#DepositInterestSchemeForm').submit()">Update</a></li>-->
                    <li><g:link class="list" action="show" id="${depositInterestSchemeInstance.id}">Back to Show</g:link></li>
	       	</ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#editDepositIntScheme" ).click(function() {
                                 checkIfAllowed('CFG01003', 'form#DepositInterestSchemeForm', 'Override edit Deposit Interest Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
            </content>
	</body>
</html>
