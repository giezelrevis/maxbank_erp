<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/product')}">Product List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create Product</span>
            </content>
        <content tag="main-content">
			<div id="create-product" class="content scaffold-create" role="main">
				<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
				</g:if>
				<g:hasErrors bean="${productInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${productInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
				</g:hasErrors>

				<div class="nav-tab-container">
	              <ul class="nav nav-tabs">
	                <li class="active"><a href="#tab_1" data-toggle="tab">Product Details</a></li>
	                <li><a href="#tab_2" data-toggle="tab">Branches</a></li>
	                <li><a href="#tab_3" data-toggle="tab">Customer Groups</a></li>
	                <!-- <li><a href="#tab_4" data-toggle="tab">Transactions</a></li> -->
	              </ul>
	            </div>

	            <div class="tab-content">

	            	<div class="tab-pane active fade in" id="tab_1">
	            		<g:form id="create" url="[resource:productInstance, action:'save']" >
						<fieldset class="form">
							<g:render template="form" model="['mode':'create']"/>
						</fieldset>
					</div>
					<div class="tab-pane fade in" id="tab_2">
						<h3>Assign Product to Branch</h3>
						<fieldset class="form">
							<g:render template="branch"/>
						</fieldset>	
					</div>
					<div class="tab-pane fade in" id="tab_3">
						<h3>Assign Product to Customer Group</h3>
						<fieldset class="form">
							<g:render template="customerGroup"/>
						</fieldset>	
					</div>
					<!--<div class="tab-pane fade in" id="tab_4">
						<h3>Assign Transactions to Product</h3>
						<fieldset class="form">
							<g:render template="txnTemplate"/>
						</fieldset>	
						</g:form>
					</div> -->
				</div>	
			</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><a href='#' name="create" id="newProduct" onclick="validateOverride();">Create</a></li>
                <li><g:link action="index"><g:message code="default.cancel.label" args="[entityName]" default="Cancel" /></g:link></li>
                <script>
                    function validateOverride(){
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00702', 'form#create', 'Override new Product.', null);                               
                                    },
                                function(){
                                    return;
                                }); 
                    }
                </script>
            </ul>
            <!--
            <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#newProduct" ).click(function() {
                                 checkIfAllowed('CFG00702', 'form#create', 'Override new Product.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
            </script>
            -->
        </content>
	</body>
</html>
