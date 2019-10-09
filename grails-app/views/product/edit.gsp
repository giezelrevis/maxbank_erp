<%@ page import="icbs.admin.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/product')}">Product List</a>
                <span class="fa fa-chevron-right"></span><span class="current">Edit Product</span>
            </content>
            <content tag="main-content">
	            <div class="nav-tab-container">
	              <ul class="nav nav-tabs">
	                <li class="active"><a href="#tab_1" data-toggle="tab">Product Details</a></li>
	                <li><a href="#tab_2" data-toggle="tab">Branches</a></li>
	                <li><a href="#tab_3" data-toggle="tab">Customer Groups</a></li>
	                <li><a href="#tab_4" data-toggle="tab">Transactions</a></li>
	              </ul>
	            </div>
	            <div class="tab-content">

	            	<div class="tab-pane active fade in" id="tab_1">
	            		<g:form id="edit" url="[resource:productInstance, action:'update']" method="PUT" >
						<fieldset class="form">
							<g:render template="form" model="['mode':'edit']"/>
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
					<div class="tab-pane fade in" id="tab_4">
						<h3>Assign Transactions to Product</h3>
						<fieldset class="form">
							<g:render template="txnTemplate"/>
						</fieldset>	
						</g:form>
					</div>

				</div>
            </content>
            <content tag="main-actions">
            <ul>
                <li><g:submitButton name="edit" id="editProduct" class="btn btn-primary" value="${message(code: 'default.button.save.label', default: 'Update')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG00703', 'form#edit', 'Override edit Product.', null);                            
                                    },
                                function(){
                                    return;
                                });                             
                        "/></li>
                <li><g:link action="show" id="${productInstance.id}">Cancel</g:link></li>
            </ul>
            <!--
            <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#editProduct" ).click(function() {
                                 checkIfAllowed('CFG00703', 'form#edit', 'Override edit Product.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
            </script>
            -->
        </content>
	</body>
</html>
