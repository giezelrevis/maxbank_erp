<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanLedger.label', default: 'LoanLedger')}" />
		<title>Create Loan Non-Cash Transaction</title>
		<g:javascript>
			function prcr() 
                                {
                                var Amt = $('#principalCredit').val().replace(/([A-Z,a-z],#,@,-,+,=)/g,'');
                                $('#principalCredit').val(Amt);
                                updateVar();
                                }
                    
                    function updateLoanDetailsAjax(params) {
				if (params.loan2) {
					$('#loan').val(params.loan2);

					$.ajax({
					    type: 'POST',
					    data: {id:params.loan2},
					    url: "${createLink(controller:'loan', action:'getLoanDetailsAjax')}",
					    success: function(msg){
                                                    //console.log(msg);
							$('#accountNo').val($(msg).find('#account-no').html());	
							$('#customer').html($(msg).find('#customer').html());
							$('#granted-amount').html($(msg).find('#granted-amount').html());
							$('#interest-rate').html($(msg).find('#interest-rate').html());
                                                        $('#maturity-date').html($(msg).find('#maturity-date').html());
							$('#total-net-proceeds').html($(msg).find('#total-net-proceeds').html());
                                                        $('#total-disbursement-amount').html($(msg).find('#total-disbursement-amount').html());
                                                        $('#overdue-principal-balance').html($(msg).find('#overdue-principal-balance').html());
							$('#principal-balance').html($(msg).find('#principal-balance').html());
							$('#interest-balance').html($(msg).find('#interest-balance').html());
							$('#penalty-balance').html($(msg).find('#penalty-balance').html());
							$('#service-charge-balance').html($(msg).find('#service-charge-balance').html());
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
				}
            }

			function showLoanSearch() {				
				modal = new icbs.UI.Modal({id:"loanModal", url:"${createLink(controller: 'loan', action:'search')}", title:"Search Loan Account", onCloseCallback:updateLoanDetailsAjax});
                modal.show();
			}

			function updateDepositAjax(params){
            	if (params.deposit) {
            		$.ajax({
					    type: 'POST',
					    data: {id:params.deposit},
					    url: "${createLink(controller:'loan', action:'showDepositAccountInfo')}",
					    success: function(msg){				    					    	
					    	$('#depositAccountNo').val($(msg).find('#account-no').html());
                                                $('#depositAccountName').val($(msg).find('#account-name').html());
					    	$('#deposit').val(params.deposit);
					    },
					    error:function(XMLHttpRequest,textStatus,errorThrown){
	                		alert(XMLHttpRequest+textStatus+errorThrown);
	            		}
					});
            	}
            }

            function showDepositSearch(){
                modal = new icbs.UI.Modal({id:"depositModal",url:"${createLink(controller: 'search', action:'search', params:[searchDomain: 'deposit'])}",title:"Search Deposit Account",onCloseCallback:updateDepositAjax});
            	modal.show();
            }

			function updateForm() {				
				var txnType = $('#txnType').val();
                                var disbAmt = accounting.unformat($('#total-net-proceeds').html()) - accounting.unformat($('#total-disbursement-amount').html());
				if (txnType == 4) {  // payment
					document.getElementById('principal-debit-form-group').style.display = 'none';
					document.getElementById('principal-credit-form-group').style.display = 'block';
					document.getElementById('interest-debit-form-group').style.display = 'none';
					document.getElementById('interest-credit-form-group').style.display = 'block';
					document.getElementById('penalty-debit-form-group').style.display = 'none';
					document.getElementById('penalty-credit-form-group').style.display = 'block';
					document.getElementById('charges-debit-form-group').style.display = 'none';
					document.getElementById('charges-credit-form-group').style.display = 'block';
				} else if (txnType == 5) {  // disbursement
					document.getElementById('principal-debit-form-group').style.display = 'block';
					document.getElementById('principal-credit-form-group').style.display = 'none';
					document.getElementById('interest-debit-form-group').style.display = 'none';
					document.getElementById('interest-credit-form-group').style.display = 'none';
					document.getElementById('penalty-debit-form-group').style.display = 'none';
					document.getElementById('penalty-credit-form-group').style.display = 'none';
					document.getElementById('charges-debit-form-group').style.display = 'none';
					document.getElementById('charges-credit-form-group').style.display = 'none';
                                        //alert($('#total-net-proceeds').html());
                                        //document.getElementById('principalDebit').value = $('#total-net-proceeds').html()
                                        document.getElementById('principalDebit').value = disbAmt.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
				} else if (txnType == 6) {  // principal debit
					document.getElementById('principal-debit-form-group').style.display = 'block';
					document.getElementById('principal-credit-form-group').style.display = 'none';
					document.getElementById('interest-debit-form-group').style.display = 'none';
					document.getElementById('interest-credit-form-group').style.display = 'none';
					document.getElementById('penalty-debit-form-group').style.display = 'none';
					document.getElementById('penalty-credit-form-group').style.display = 'none';
					document.getElementById('charges-debit-form-group').style.display = 'none';
					document.getElementById('charges-credit-form-group').style.display = 'none';
				} else if (txnType == 7) {  // principal credit
					document.getElementById('principal-debit-form-group').style.display = 'none';
					document.getElementById('principal-credit-form-group').style.display = 'block';
					document.getElementById('interest-debit-form-group').style.display = 'none';
					document.getElementById('interest-credit-form-group').style.display = 'none';
					document.getElementById('penalty-debit-form-group').style.display = 'none';
					document.getElementById('penalty-credit-form-group').style.display = 'none';
					document.getElementById('charges-debit-form-group').style.display = 'none';
					document.getElementById('charges-credit-form-group').style.display = 'none';
				} else if (txnType == 8) {  // interest debit
					document.getElementById('principal-debit-form-group').style.display = 'none';
					document.getElementById('principal-credit-form-group').style.display = 'none';
					document.getElementById('interest-debit-form-group').style.display = 'block';
					document.getElementById('interest-credit-form-group').style.display = 'none';
					document.getElementById('penalty-debit-form-group').style.display = 'block';
					document.getElementById('penalty-credit-form-group').style.display = 'none';
					document.getElementById('charges-debit-form-group').style.display = 'block';
					document.getElementById('charges-credit-form-group').style.display = 'none';
				} else if (txnType == 9) {  // interest credit
					document.getElementById('principal-debit-form-group').style.display = 'none';
					document.getElementById('principal-credit-form-group').style.display = 'none';
					document.getElementById('interest-debit-form-group').style.display = 'none';
					document.getElementById('interest-credit-form-group').style.display = 'block';
					document.getElementById('penalty-debit-form-group').style.display = 'none';
					document.getElementById('penalty-credit-form-group').style.display = 'block';
					document.getElementById('charges-debit-form-group').style.display = 'none';
					document.getElementById('charges-credit-form-group').style.display = 'block';
				}

				// update transaction templates
				$.ajax({
				    type: 'POST',
				    data: {txnType:txnType},
				    url: "${createLink(controller:'loanAdjustment', action:'getTxnTemplatesAjax')}",
				    success: function(msg){
						$('#txn-template').html($(msg).find('#txn-template').html());
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
			}

			function submitForm() {
				var response = confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');

				if (response)
					jQuery('#loan-adjustment-form').submit();
			}

			icbs.Dependencies.Ajax.addLoadEvent(function(){
				updateLoanDetailsAjax({loan2:"${loanLedgerInstance?.loan?.id}"});
				updateDepositAjax({deposit:"${loanLedgerInstance?.deposit?.id}"});
        		updateForm();        		
            });
            
            function updateVar() {
                
                PRINDR = accounting.unformat($('#principalDebit').val());
                if (isNaN(PRINDR))
                    PRINDR = 0;
                    
                PRINCR = accounting.unformat($('#principalCredit').val());
                if (isNaN(PRINCR))
                    PRINCR = 0;
                    
                INTDR = accounting.unformat($('#interestDebit').val());
                if (isNaN(INTDR))
                    INTDR = 0;
                    
                INTCR = accounting.unformat($('#interestCredit').val());
                if (isNaN(INTCR))
                    INTCR = 0;
                    
                PENDR = accounting.unformat($('#penaltyDebit').val());
                if (isNaN(PENDR))
                    PENDR = 0; 

                PENCR = accounting.unformat($('#penaltyCredit').val());
                if (isNaN(PENCR))
                    PENCR = 0;

                SCDR = accounting.unformat($('#chargesDebit').val());
                if (isNaN(SCDR))
                    SCDR = 0;

                SCCR = accounting.unformat($('#chargesCredit').val());
                if (isNaN(SCCR))
                    SCCR = 0;
                    
                TotBreakdown = accounting.unformat((PRINDR+PRINCR+INTDR+INTCR+PENDR+PENCR+SCDR+SCCR).toFixed(2));
                document.getElementById('total-amount').value = TotBreakdown.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
                //alert(TotBreakdown);
            }
            
        </g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="create-loanLedger" class="content scaffold-create" role="main">
                <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                </script>
                </g:if>
            		<g:hasErrors bean="${loanLedgerInstance}">
	            <div class="box-body">
	                <div class="alert alert-danger alert-dismissable">
	                    <i class="fa fa-ban"></i>
	                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                    <b>Alert!</b> 
	                    <ul class="errors" role="alert">
	                    	<g:if test="${loanLedgerInstance.errors?.allErrors*.code.contains('loanAdjustment.disbursement.excess')}">
	                    	Total disbursement amount cannot exceed total net proceeds
	                    	</g:if>
	                    	<g:elseif test="${loanLedgerInstance.errors?.allErrors*.code.contains('loanAdjustment.principalBalance.excess')}">
	                    	Principal balance amount cannot exceed loan amount
	                    	</g:elseif>
	                    	<g:elseif test="${loanLedgerInstance.errors?.allErrors*.code.contains('loanAdjustment.principalBalance.belowZero')}">
	                    	Principal balance amount cannot be less than zeo
	                    	</g:elseif>
	                    	<g:else>
                    		There are errors
	                    	</g:else>
	                    </ul>            
	                </div>
	            </div>
            </g:hasErrors>
			<g:form id="loan-adjustment-form" url="[controller:loanAdjustment, action:'save']" >
				<div>
					<g:render template="form"/>
				</div>
			</g:form>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:submitButton id="adjust"name="save" value="Save" onclick="
                    alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    checkIfAllowed('LON00900', 'form#loan-adjustment-form', 'Create loan adjustment', null);
                                },
                                function(){
                                    return;
                                });                        
                    "/></li>
                <!--
                 <script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#adjust" ).click(function() {
		             		 checkIfAllowed('LON00900', 'form#loan-adjustment-form', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
		               	});
		            }); 
               </script>
                -->
                <li><g:link class="list" action="index" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
            </ul>
        </content>
	</body>
</html>
