
<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>View Loan History</title>
		<g:javascript>
			function updateCustomerInfoAjax(params) {
                $.ajax({
				    type: 'POST',
				    data: {id:params.customer2},
				    url: "${createLink(controller :'customer', action:'showBasicCustomerInfoAjax')}",
				    success: function(msg){						
						$('#customer-name').val($(msg).find('#display-name').html());
						$('#customer').val(params.customer2);
						$('#birth-date').html($(msg).find('#birth-date').html())
						$('#address').html($(msg).find('#address').html())
						$('#photo').html($(msg).find('#photo').html())
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }           

        	window.onload = function(){
        		updateCustomerInfoAjax({customer2:"${loanHistoryInstance?.customer?.id}"});
            }
   		</g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-loan" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>        
            				
			<div class="nav-tab-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_1" data-toggle="tab">Loan Application</a></li>
                    <li><a href="#tab_2" data-toggle="tab">Specification</a></li>                        
                    <li><a href="#tab_3" data-toggle="tab">Classification</a></li>
                    <li><a href="#tab_4" data-toggle="tab">Service Charges</a></li>
                    <li><a href="#tab_5" data-toggle="tab">Deductions</a></li>
                    <li><a href="#tab_6" data-toggle="tab">UID</a></li>
                    <li><a href="#tab_7" data-toggle="tab" id="installment-tab">Installments</a></li>
                    <li><a href="#tab_8" data-toggle="tab">Sweep</a></li>
                </ul>
            </div>
            <div class="tab-content">
				<div class="tab-pane active fade in table-responsive" id="tab_1">
					<legend>Loan Application</legend>
						
					<g:render template="loanApplication/show"/>
				</div>
				<div class="tab-pane" id="tab_2">
					<g:render template="specification/show"/>
				</div>
				<div class="tab-pane" id="tab_3">
					<g:render template="classification/show"/>
				</div>
				<div class="tab-pane" id="tab_4">
					<g:render template="serviceCharges/show"/>
				</div>
				<div class="tab-pane" id="tab_5">
					<g:render template="deductions/show"/>
				</div>
				<div class="tab-pane" id="tab_6">
					<g:render template="advancedInterests/list"/>
				</div>
				<div class="tab-pane" id="tab_7">
					<g:render template="installments/schedule"/>
				</div>
				<div class="tab-pane" id="tab_8">
					<g:render template="sweep/show"/>
				</div>				
			</div>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link action="show" id="${origLoanInstance?.id}">Back to Loan Inquiry</g:link></li>
			</ul>			
        </content>
	</body>
</html>
