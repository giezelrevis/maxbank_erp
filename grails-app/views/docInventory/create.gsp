<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'docInventory.label', default: 'DocInventory')}" />
		<title> Create Document Inventory</title>
	</head>
	<body>
            <content tag="main-content">
		<div id="create-docInventory" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                        notify.message(x);
                                });
                            </script>
			</g:if>
			<g:hasErrors bean="${docInventoryInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${docInventoryInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="docInventoryForm" url="[resource:docInventoryInstance, action:'save']" >
                           
				<fieldset class="form">
					<g:render template="form" model="[readonly:'false']"/>
				</fieldset>
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a href="#" onclick="
                        if( $('#seriesStart').val() == '' )
                        {
                            notify.message('Empty Series Start not allowed!|error|alert');return;
                        }
                        if( $('#seriesEnd').val() == '' )
                        {
                            notify.message('Empty Series End not allowed!|error|alert');return;
                        }
                        if( accounting.unformat($('#seriesStart').val()) > accounting.unformat($('#seriesEnd').val()) )
                        {
                            notify.message('Starting Series is greater than the Ending Series is not allowed!|error|alert');return;
                        }
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                        function(){
                            $('#docInventoryForm').submit();
                            },
                        function(){
                            return;
                        });                        
                        ">Create </a></li>
                    <li><g:link class="list" action="index">Back to List</g:link></li>
                    
                </ul>
            </content>
	</body>
</html>
