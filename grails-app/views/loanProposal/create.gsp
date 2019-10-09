<%@ page import="icbs.loans.InterestIncomeScheme" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Create Loan Application Template</title>
    	<g:javascript>   
    		// update form fields based on installment calculation type	
    		updateForm = function() {
			    var callback = function(data,params) {			    	
			    	$('#interestRate').val($(data).find('#default-interest-rate').html());


			    	var installmentType = $(data).find('#installment-type').html();
			    	var installmentCalculation = $(data).find('#installment-calculation').html();
			    	
					if ($(data).find('#changeable-interest-rate').html() == 'true') {
						$("#interestRate").prop('readonly', false);
					} else {
						$("#interestRate").prop('readonly', true);
					}

			    	if (installmentCalculation == 1) {  // single payment
			    		//document.getElementById('amount-form-group').style.display = 'block';
						document.getElementById('term-form-group').style.display = 'block';
						document.getElementById('frequency-form-group').style.display = 'none';
						document.getElementById('num-installments-form-group').style.display = 'none';
						document.getElementById('installment-amount-form-group').style.display = 'none';
						document.getElementById('balloon-installments-form-group').style.display = 'none';		
						document.getElementById('interest-start-date-form-group').style.display = 'block';
						document.getElementById('first-installment-date-form-group').style.display = 'block';
						document.getElementById('manual-form-group').style.display = 'none';
			    	} else if (installmentType == 5 || installmentCalculation == 6) {  // manual
			    		//document.getElementById('amount-form-group').style.display = 'none';
			    		document.getElementById('term-form-group').style.display = 'none';	
			    		document.getElementById('frequency-form-group').style.display = 'none';					
						document.getElementById('num-installments-form-group').style.display = 'none';			
						document.getElementById('installment-amount-form-group').style.display = 'none';
						document.getElementById('balloon-installments-form-group').style.display = 'none';		
						document.getElementById('interest-start-date-form-group').style.display = 'none';
						document.getElementById('first-installment-date-form-group').style.display = 'none';
						document.getElementById('manual-form-group').style.display = 'block';
			    	} else {  // others
			    		//document.getElementById('amount-form-group').style.display = 'block';
			    		document.getElementById('term-form-group').style.display = 'none';
						document.getElementById('frequency-form-group').style.display = 'block';
						document.getElementById('num-installments-form-group').style.display = 'block';
						if (installmentCalculation == 3 || installmentCalculation == 7) {  // annuity
							document.getElementById('installment-amount-form-group').style.display = 'block';
						} else {
							document.getElementById('installment-amount-form-group').style.display = 'none';
						}
						// declining fixed principal and straight/flat
						if ((installmentCalculation == 2 || installmentCalculation == 5) && 
							$(data).find('#balloon-mode').html() == 'true') {
							document.getElementById('balloon-installments-form-group').style.display = 'block';
						} else {
							document.getElementById('balloon-installments-form-group').style.display = 'none';
						}
						document.getElementById('interest-start-date-form-group').style.display = 'block';
						document.getElementById('first-installment-date-form-group').style.display = 'block';
						document.getElementById('manual-form-group').style.display = 'none';
			    	}

			    	//$('#numInstallments').val('');
			    	//$('#balloonInstallments').val('');
			    };

			    var sendUpdate = function(){
			        var ajax = icbs.Dependencies.Ajax;
			        ajax.run({url:"${createLink(controller:'loanProposal', 
			                      action:'getInterestIncomeSchemeInfoAjax')}", 
			                      params:{id:$('#interestIncomeScheme').val()},
			                      callback:callback});    		    	
			    };

			    sendUpdate();
			};			

    		validateInputs = function(event) {
    			var showError = function(field, errorMessage) {
						$('#' + field + '-form-group').addClass('has-error');
		    			$('#' + field + '-form-group .col-sm-8').append('<div class="controls"><span class="help-block">' + errorMessage + '<br /></span></div>');
    			}

    			/*var removeError = function(field) {
					$('#' + field + '-form-group').removeClass('has-error');
	    			$('#' + field + '-form-group .col-sm-8 .controls').remove();
    			}*/

			    var callback = function(data,params) {
			    	var hasErrors = false;

			    	var installmentType = $(data).find('#installment-type').html();	
					var installmentCalculation = $(data).find('#installment-calculation').html();

			    	var minInterestRate = parseFloat($(data).find('#min-interest-rate').html());
			    	var maxInterestRate = parseFloat($(data).find('#max-interest-rate').html());

			    	// clear previous errors
			    	$('.controls').remove();
			    	$('.form-group').removeClass('has-error');		    		

		    		// check errors
			    	if ($('#interestRate').val().trim() == '') {
			    		hasErrors = true;
		    			showError('interest-rate', 'Interest rate cannot be null');
			    	} else if (parseFloat($('#interestRate').val()) < minInterestRate) {
		    			hasErrors = true;
		    			showError('interest-rate', 'Interest rate cannot be less than minimum interest rate');
			    	} else if (parseFloat($('#interestRate').val()) > maxInterestRate) {
			    		hasErrors = true;
			    		showError('interest-rate', 'Interest rate cannot be greater than maximum interest rate');
			    	}

			    	if ($('#amount').val().trim() == '') {
		    			hasErrors = true;
		    			notify.message('Amount Cannot be null!|error|alert');return;
		    		}
					
		    		if (installmentCalculation == 1) {  // single payment
						if ($('#term').val().trim() == '') {
			    			hasErrors = true;
		    				showError('term', 'Term cannot be null');
			    		}
			    	} else if (installmentType == 5 || installmentCalculation == 6) {  // manual
			    		var totalAmount = 0;
			    		var dates = [];
		    			$('.multi-field-item').each(function(){
		    				if (!$(this).hasClass('multi-field-template')) {		    					
		    					if ($(this).find('input[name^="installmentDate"]').val().trim() == '') {		
		    						hasErrors = true;
									$(this).find('.installment-date-group').addClass('has-error');			
									$(this).find('.installment-date-group .help-block').html('Installment date cannot be null');
								} else {
									var date = new Date($(this).find('input[name^="installmentDate"]').val().trim());
									
									var laterDate = true;
									for(i = 0; i < dates.length; i++) {
										if (date <= dates[i]) {
											laterDate = false;
											hasErrors = true;
										}
									}

									if (!laterDate) {										
										$(this).find('.installment-date-group').addClass('has-error');			
										$(this).find('.installment-date-group .help-block').html('Must be later than previous installment dates');
									} else {
										$(this).find('.installment-date-group .help-block').html('');
									}

									dates.push(date);									
								}

								if ($(this).find('input[name^="principalAmount"]').val().trim() == '') {
									hasErrors = true;
									$(this).find('.principal-amount-group').addClass('has-error');
									$(this).find('.principal-amount-group .help-block').html('Principal cannot be null');
								} else {
									totalAmount += parseFloat($(this).find('input[name^="principalAmount"]').val().replace(",",""));
									$(this).find('.principal-amount-group .help-block').html('');
								}

								if ($(this).find('input[name^="interestAmount"]').val().trim() == '') {
									hasErrors = true;
									$(this).find('.interest-amount-group').addClass('has-error');
									$(this).find('.interest-amount-group .help-block').html('Interest cannot be null');
								} else {
									$(this).find('.interest-amount-group .help-block').html('');
								}
    						}							
						});

		    			if (totalAmount != parseFloat($('#amount').val().replace(",",""))) {
		    				hasErrors = true;
	    					showError('amount', 'Total principal amount does not match loan amount');
		    			}
			    	} else {  // others
			    		if ($('#numInstallments').val().trim() == '') {
			    			hasErrors = true;
		    				notify.message('Number Installment Cannot be null!|error|alert');return;
			    		}

			    		/*if (installmentCalculation == 3) {  // annuity
			    			if ($('#installmentAmount').val().trim() == '') {
				    			hasErrors = true;
			    				showError('installment-amount', 'Amount per installment cannot be null');
				    		}
			    		}*/

			    		// declining fixed principal and straight/flat
			    		/*if ((installmentCalculation == 2 || installmentCalculation == 5) &&
		    			      $(data).find('#balloon-mode').html() == 'true' && 
		    			      $('#balloonInstallments').val().trim() == '') {
			    			hasErrors = true;
		    				showError('balloon-installments', 'Balloon installments cannot be null');
			    		}*/
			    	}

			    	if ($('#openingDate').val().trim() == '') {
		    			hasErrors = true;
		    			notify.message('Opening Date Cannot be null!|error|alert');return;
		    		}
                                if ($('#firstInstallmentDate').val().trim() == '') {
                                        if (installmentCalculation == 6) {
                                            alert('Manual Installment, recalculating interest');    
                                        } else {
                                            hasErrors = true;
                                            notify.message('First Installment Date Cannot be null!|error|alert');return;
                                        }
		    		}

		    		if (hasErrors) {
		    			document.getElementById('error-notification').style.display = 'block';
		    		} else {
		    			document.getElementById('error-notification').style.display = 'none';
						showInstallmentSchedule();
		    		}
			    };

			    var sendUpdate = function(){
			        var ajax = icbs.Dependencies.Ajax;
			        ajax.run({url:"${createLink(controller:'loanProposal', 
			                      action:'getInterestIncomeSchemeInfoAjax')}", 
			                      params:{id:$('#interestIncomeScheme').val()},
			                      callback:callback});    		    	
			    };

			    sendUpdate();
			};
                function pmt(interestRate, numPeriods, presentValue, futureValue) {
                var presentValueInterestFactor;

                if (!futureValue) 
                        futureValue = 0;

                if (interestRate == 0)
                        return -(presentValue + futureValue) / numPeriods;

                presentValueInterestFactor = Math.pow(1 + interestRate, numPeriods);
                return -interestRate * presentValue * (presentValueInterestFactor + futureValue) / (presentValueInterestFactor - 1)
        }                

	function updateInstallmentAmount() {
        
				var amount = parseFloat($('#amount').val().replace(",",""));				
				var numInstallments = $('#numInstallments').val();
				var interestRate = $('#interestRate').val() * 0.01;
				var frequency = $('#frequency').val();
                                amount = accounting.unformat($('#amount').val());
				var contractualRate = interestRate / 12;

				var compoundingRate
                                if (frequency == 1 || frequency == 2) {
                                    compoundingRate = contractualRate / 30;
                                } else if (frequency == 3) {
                                    compoundingRate = (contractualRate / 30) * 7;
                                } else if (frequency == 4) {
                                    compoundingRate = (contractualRate / 30) * 14;
                                } else if (frequency == 5) {
                                    compoundingRate = (contractualRate / 30) * 15;
                                } else if (frequency == 6 || frequency == 7) {
                                    compoundingRate = contractualRate;
                                } else if (frequency == 8) {
                                    compoundingRate = interestRate / 6;
                                } else if (frequency == 9) {
                                    compoundingRate = interestRate / 4;
                                } else if (frequency == 10) {
                                    compoundingRate = interestRate / 2;
                                } else if (frequency == 11) {
                                    compoundingRate = interestRate;
                                } else {
                                    compoundingRate = contractualRate;
                                }

				if (amount > 0 && numInstallments > 0) {
					var installmentAmount = 0;

                                        if (frequency == 3)
                                        {
                                            var frequencyFactor = 0;

                                            if (frequency == 1 || frequency == 2) {
                                                frequencyFactor = 365;
                                            } else if (frequency == 3) {
                                                frequencyFactor = 52;
                                            } else if (frequency == 4) {
                                                frequencyFactor = 26;
                                            } else if (frequency == 5) {
                                                frequencyFactor = 24;
                                            } else if (frequency == 6 || frequency == 7) {
                                                frequencyFactor = 12;
                                            } else if (frequency == 8) {
                                                frequencyFactor = 6;
                                            } else if (frequency == 9) {
                                                frequencyFactor = 4;
                                            } else if (frequency == 10) {
                                                frequencyFactor = 2;
                                            } else if (frequency == 11) {
                                                frequencyFactor = 1;
                                            } else {
                                                frequencyFactor = 365;
                                            }
                                        
                                           factor = interestRate / frequencyFactor;
                                           installmentAmount = amount * ( factor / ( 1 - ( Math.pow( ( 1 / ( 1 + factor ) ),numInstallments ) ) ) );
                                        }
                                        else
                                      {
					   installmentAmount = pmt(compoundingRate, numInstallments, amount * -1);
					   
					}
                                        installmentAmount = installmentAmount.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
					$('#installmentAmount').val(installmentAmount);
				} else {
					$('#installmentAmount').val('');
				}				
			}

            function showInstallmentSchedule() {   
            	var frequency = $('#frequency').val();         	

				$.ajax({
				    type: 'POST',
				    data: $('form').serialize(),
				    url: "${createLink(controller :'loanProposal', action:'showInstallmentScheduleAjax')}",
				    success: function(msg){
				    	//jQuery('#installment-schedule-modal .modal-body').html(msg);
                                        jQuery('#installment-schedule-modal').html(msg);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});

				$('#installment-schedule-modal').modal({show:true});
            }

        	icbs.Dependencies.Ajax.addLoadEvent(function(){
            	updateForm();            	
            });
        </g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="create-template" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <div id="error-notification" class="box-body" style="display: none">
                <div class="alert alert-danger alert-dismissable">
                    <i class="fa fa-ban"></i>
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <b>Alert!</b> 
                    <ul class="errors" role="alert">
                        There are errors
                    </ul>            
                </div>
            </div>
			<g:form>
			<div>				
                <div id="loan-template-form">
					<g:render template="specification"/>
				</div>

                        <!-- modal for loan installment schedule -->
    			<!-- <div class="modal" id="installment-schedule-modal"> -->
                        <div id="installment-schedule-modal">      
                            <h4 class="modal-title">Loan Installment Schedule</h4>    
                                <!--
    				<div class="modal-dialog">
    					<div class="modal-content">
    						<div class="modal-header">
                    			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    			<h4 class="modal-title">Loan Installment Schedule</h4>
                			</div>
                			<div class="modal-body">

                			</div>
    					</div>
    				</div>
                                -->
    			</div>

				<div class="form-group form-buttons">
					
				</div>
				<!--<div class="form-group form-buttons">
					<g:submitButton name="create" class="btn btn-primary" value="Show Schedule" />
				</div>-->
			</div>
			</g:form>
		</div>		
        </content>
        <content tag="main-actions">
            <ul>                    
                <li><a href="#" onclick="validateInputs();">Show Instalment Schedule</a></li>
			</ul>
        </content>
	</body>
</html>
