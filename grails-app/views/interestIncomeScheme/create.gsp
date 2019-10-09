<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'interestIncomeScheme.label', default: 'InterestIncomeScheme')}" />
		<title>Create Interest Income Scheme</title>
		<g:javascript>
			function updateForm() {
				var installmentCalcType = $('#installmentCalcType').val();				
				if (installmentCalcType == 3 || installmentCalcType == 4 || installmentCalcType == 6) {
					// does not have advanced interests
					$('#advInterestType').val(1);
					$('#s2id_advInterestType .select2-chosen').html($('#advInterestType option:selected').text());
					$("#advInterestType").prop('disabled', true);
				} else {
					if (installmentCalcType == 2) {  // remove full advanced interest for declining fixed principal
						$('#advInterestType option[value=2]').remove();
					} else {
						if ($('#advInterestType option[value=2]').length == 0) {  // if full was removed
							$('#advInterestType option[value=3]').remove(); // remove partial also

							// add full and partial again
							$('#advInterestType').append($('<option>', {value: 2, text: 'Full'}));
							$('#advInterestType').append($('<option>', {value: 3, text: 'Partial'}));
						}							
					}
					$("#advInterestType").prop('disabled', false);
				}				
			}

			icbs.Dependencies.Ajax.addLoadEvent(function(){
        		updateForm();
            });
		</g:javascript>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/interestIncomeScheme')}">Interest Income Scheme</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create Interest Income Scheme</span>
            </content>
		<content tag="main-content">
		<div class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<g:hasErrors bean="${interestIncomeSchemeInstance}">
				<div class="box-body">
	                <div class="alert alert-danger alert-dismissable">
	                    <i class="fa fa-ban"></i>
	                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                    <b>Alert!</b> 
	                    <ul class="errors" role="alert">
	                        There are errors
	                    </ul>            
	                </div>
	            </div>
            </g:hasErrors>
			<g:form id="create" url="[resource:interestIncomeSchemeInstance, action:'save']" >
				<div class="nav-tab-container">
              		<ul class="nav nav-tabs">
                		<li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
                		<li><a href="#tab_2" data-toggle="tab">Products</a></li>
              		</ul>
              	</div>
          		<div class="tab-content">
        			<div class="tab-pane active fade in" id="tab_1">
						<div class="container-fluid">
							<g:render template="details"/>
						</div>
        			</div>
					<div class="tab-pane fade in" id="tab_2">							
						<div>
							<g:render template="products" />
						</div>
					</div>
            	</div>				
			</g:form>
		</div>
		</content>
		<content tag="main-actions">
      		<ul>
                    <!--<li><g:submitButton name="save" value="Save" onclick="jQuery('#form').submit()" /></li>-->
                    <li><g:submitButton name="create" id="newInterestIncomeScheme" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('CFG01002', 'form#create', 'Override new Interest Income Scheme.', null)                                 
                                    },
                                function(){
                                    return;
                                });                              
                        "/></li>
                    <li><g:link class="list" action="index" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
	       	</ul>
                <!--
                <script type="text/javascript">
                    $(document).ready(function() {
                        $( "#newInterestIncomeScheme" ).click(function() {
                                 checkIfAllowed('CFG01002', 'form#create', 'Override new Interest Income Scheme.', null); // params: policyTemplate.code, form to be saved
                        });
                    }); 
                </script>
                -->
	    </content>
	</body>
</html>
