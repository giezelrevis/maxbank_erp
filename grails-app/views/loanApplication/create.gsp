

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanApplication.label', default: 'LoanApplication')}" />
		<title>Create Loan Application</title>		
		<g:javascript>
                            //===================================================
                            function Comma(Num) { //function to add commas to textboxes
                                Num += '';
                                Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
                                Num = Num.replace(',', ''); Num = Num.replace(',', ''); Num = Num.replace(',', '');
                                x = Num.split('.');
                                x1 = x[0];
                                x2 = x.length > 1 ? '.' + x[1] : '';
                                var rgx = /(\d+)(\d{3})/;
                                while (rgx.test(x1))
                                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                                return x1 + x2;
                            }


                            function AddComma()
                            {

                                  $('#value').val(Comma( $('#value').val()));
                            }
                            //===================================================
                           function updateAmount() 
                                {
                                
                                var Amt = accounting.unformat($('#value').val().replace(/([A-Z,a-z],#,@,-,+,=)/g,''));
                                 if (isNaN(Amt))
                                 Amt = 0;
                                 $('#value').val(Amt);
                                }
                           function val() 
                                {
                                var Amt = accounting.formatNumber($('#value').val().replace(/([A-Z,a-z],#,@,-,+,=)/g,''),2, ",",".");
                            
                                if (isNaN(Amt))
                     
                                 $('#value').val(Amt).toDouble();
                                
                                } 
                                
                                
                                
			function updateCustomerInfoAjax(params) {	
				if (params.customer2) {
	                $.ajax({
					    type: 'POST',
					    data: {id:params.customer2},
					    url: "${createLink(controller:'customer', action:'showBasicCustomerInfoAjax')}",
					    success: function(msg){
							$('#customer-name').val($(msg).find('#display-name').html());
                                                        $('#customer-me').val($(msg).find('#display-name').html());
							$('#customer').val(params.customer2);
							$('#birth-date').html($(msg).find('#birth-date').html())
							$('#address').html($(msg).find('#address').html())
							$('#photo').html($(msg).find('#photo').html())
                                                        $('#total-released').html($(msg).find('#total-released').html())
                                                        $('#total-balance').html($(msg).find('#total-balance').html())
                                                        $('#total-count').html($(msg).find('#total-count').html())
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }

        	function showCustomerSearch() {
                modal = new icbs.UI.Modal({id:"customerDetailsModal", url:"${createLink(controller: 'search', action:'search')}", title:"Search Customer", onCloseCallback:updateCustomerInfoAjax});
                modal.show();                   
            }

            function showFinancialDetails() {
				$.ajax({
				    type: 'POST',
				    url: "${createLink(controller:'loanApplication', action:'showFinancialDetailsAjax')}",
				    success: function(msg){				    	
				    	$('#tab_2').html(msg);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});				
            }

            function addFinancialDetailAjax() {
                                
                                var xaaaa = accounting.unformat($('#value').val());
                                
				$.ajax({
				    type: 'POST',
				    data: {description:$('#description').val(), value:$('#value').val(), type:$('#type').val()},
				    url: "${createLink(controller:'loanApplication', action:'addFinancialDetailAjax')}",
				    success: function(msg){
				    	$('#add-financial-detail-modal .modal-body').html(msg);
    	                $('#add-financial-detail-modal').on('hidden.bs.modal', function() {
    	                	showFinancialDetails();
						});						
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});				
            }            

            function showAddFinancialDetail() {
				modal = new icbs.UI.Modal({id:"add-financial-detail-modal", url:"${createLink(controller: 'loanApplication', action:'showAddFinancialDetailAjax')}", title:"Add Financial Detail"});
                modal.show();
            }

            function updateFinancialDetailAjax() {
				$.ajax({
				    type: 'POST',
				    data: {id:$('#financialDetailId').val(), description:$('#description').val(), value:$('#value').val(), type:$('#type').val()},
				    url: "${createLink(controller:'loanApplication', action:'updateFinancialDetailAjax')}",
				    success: function(msg){
				    	$('#update-financial-detail-modal .modal-body').html(msg);
    	                $('#update-financial-detail-modal').on('hidden.bs.modal', function() {
    	                	showFinancialDetails();
						});						
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }            

            function showUpdateFinancialDetail(id) { 
            	$.ajax({
				    type: 'POST',
				    data: {id:id},
				    url: "${createLink(controller:'loanApplication', action:'showUpdateFinancialDetailAjax')}",
				    success: function(msg){
				    	$('#financialDetailId').val(id);
				    	$('#update-financial-detail-modal .modal-body').html(msg);				    	
				    	$('#update-financial-detail-modal').modal({show:true});				    	
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

            function deleteFinancialDetailAjax(id) {
            	if (confirm('Are you sure?')) {
					$.ajax({
					    type: 'POST',
					    data: {id:id},
					    url: "${createLink(controller:'loanApplication', action:'deleteFinancialDetailAjax')}",
					    success: function(msg){
					    	showFinancialDetails();
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }

            function showComakers() {
            	$.ajax({
				    type: 'POST',
				    url: "${createLink(controller:'loanApplication', action:'showComakersAjax')}",
				    success: function(msg){				    	
				    	$('#tab_3').html(msg);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

            function addComakerAjax(params) {
            	if (params.customer2) {
					$.ajax({
					    type: 'POST',
					    data: {id:params.customer2},
					    url: "${createLink(controller:'loanApplication', action:'addComakerAjax')}",
					    success: function(msg){					 
					    	showComakers();
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }

            function showComakerSearch() {  
                modal = new icbs.UI.Modal({id:"customerDetailsModal", url:"${createLink(controller: 'search', action:'search')}", title:"Search Customer", onCloseCallback:addComakerAjax});
                modal.show();
            }

            function deleteComakerAjax(id) {            	
            	if (confirm('Are you sure?')) {
					$.ajax({
					    type: 'POST',
					    data: {id:id},
					    url: "${createLink(controller:'loanApplication', action:'deleteComakerAjax')}",
					    success: function(msg){
					    	showComakers();
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }

            function showCollateral() {
            	$.ajax({
				    type: 'POST',
				    url: "${createLink(controller:'loanApplication', action:'showCollateralAjax')}",
				    success: function(msg){				    	
				    	$('#tab_4').html(msg);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

            function addCollateralAjax(params) {
            	if (params.collateral2) {
					$.ajax({
					    type: 'POST',
					    data: {id:params.collateral2},
					    url: "${createLink(controller:'loanApplication', action:'addCollateralAjax')}",
					    success: function(msg){					 
					    	showCollateral();
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }

            function showCollateralSearch() {  
                modal = new icbs.UI.Modal({id:"collateralDetailsModal", url:"${createLink(controller: 'collateralManagement', action:'search')}", title:"Search Collateral", onCloseCallback:addCollateralAjax});
                modal.show();
            }

            function deleteCollateralAjax(id) {            	
            	if (confirm('Are you sure?')) {
					$.ajax({
					    type: 'POST',
					    data: {id:id},
					    url: "${createLink(controller:'loanApplication', action:'deleteCollateralAjax')}",
					    success: function(msg){
					    	showCollateral();
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }
            
               
            icbs.Dependencies.Ajax.addLoadEvent(function(){
            	updateCustomerInfoAjax({customer2:"${loanApplicationInstance?.customer?.id ?: customer?.id}"});
            });
   		</g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="create-loanApplication" class="content scaffold-create" role="main">
            <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                </script>
            </g:if>
            <g:hasErrors bean="${loanApplicationInstance}">
	            <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                    </script>
            </g:hasErrors>
			<g:form id="loan-application-form" url="[resource:loanApplicationInstance, action:'save']">
				<div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Specification</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Financial Details</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Co-Makers</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Collateral</a></li>
                    </ul>
                </div>
                <div class="tab-content">
					<div class="tab-pane active fade in table-responsive" id="tab_1">
						<g:render template="specification/form"/>
					</div>
					<div class="tab-pane" id="tab_2">
						<g:render template="financialDetails/list"/>						
					</div>
					<div class="tab-pane" id="tab_3">
						<g:render template="comakers/list"/>
					</div>
					<div class="tab-pane" id="tab_4">
						<g:render template="collateral/list"/>
					</div>
				</div>				
			</g:form>					
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:submitButton id="save" name="save" value="Save" onclick="validateFields();"/></li>
                <!--
               <script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#save" ).click(function() {
		             		 checkIfAllowed('LON00201', 'form#loan-application-form', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
		               	});
		            }); 
                </script>
                -->
                <li><g:link class="list" action="index" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
                <script>
                    function validateFields(){
                        var x = 0;
                        //intrestRate/serviceCharge/frequency/guaranteeFacility/preRelease/comments
                        if($('#intrestRate').val()=="" || $('#intrestRate').val()==null){
                            x = 1;
                            notify.message('Interest Rate cannot be null!|error|alert'); 
                        }
                        else if($('#intrestRate').val() < 0){
                            x = 1;
                             notify.message('Interest Rate cannot be Less than Zero (0)!|error|alert'); 
                        }
                        else if($('#serviceCharge').val()=="" || $('#serviceCharge').val()==null){
                            x = 1;
                            notify.message('Service Charge cannot be null!|error|alert'); 
                        }
                        else if($('#serviceCharge').val() < 0){
                             x = 1;
                             notify.message('Service Charge cannot be Less than Zero (0)!|error|alert'); 
                        }                        
                        console.log(""+$('#frequency').val());
                        if(x == 1){
                        
                        }else{
                        
                            alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('LON00201', 'form#loan-application-form', 'Create Loan Application', null);
                                },
                                function(){
                                    return;
                                });
                        }        
                        

                    }
                </script>
                 </ul>
        </content>
	</body>
</html>
