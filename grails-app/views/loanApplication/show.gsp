
<%@ page import="icbs.loans.LoanApplication" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loanApplication.label', default: 'LoanApplication')}" />
		<title>Loan Application Information</title>
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
                                                $('#total-released').html($(msg).find('#total-released').html())
                                                $('#total-balance').html($(msg).find('#total-balance').html())
                                                $('#total-count').html($(msg).find('#total-count').html())
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }
            //Override transfer status
            function updateStatusAjax(){
                checkIfAllowed('LON01700', status); // params: policyTemplate.code, form to be saved
            }
            
                            function updateAmount() 
                                {
                               var Amt = accounting.unformat($('#value').val());
                                 if (isNaN(Amt))
                                 Amt = 0;
                                 $('#value').val(Amt);
                                }
   
             //update status
            function status() {
				$.ajax({
				    type: 'POST',
				    data: $('#update-status-form').serialize(),
				    url: "${createLink(controller :'loanApplication', action:'updateStatusAjax')}",
				    success: function(msg){
				    	jQuery('#update-status-modal .modal-body').html(msg);
				    	$('#update-status-modal').on('hidden.bs.modal', function() {
							location.reload(true);
						});
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

        	function showUpdateStatus() {
				modal = new icbs.UI.Modal({id:"update-status-modal", url:"${createLink(controller :'loanApplication', action:'showUpdateStatusAjax', params:[id:loanApplicationInstance.id])}", title:"Update Status"});		    	
                modal.show();
            }        

        	icbs.Dependencies.Ajax.addLoadEvent(function(){
            	updateCustomerInfoAjax({customer2:"${loanApplicationInstance?.customer?.id}"});
            });
            
            
   		</g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-loanApplication" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                 <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);return;
                        });
                </script>
                        </g:if>
			<div class="nav-tab-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_1" data-toggle="tab">Specification</a></li>
                    <li><a href="#tab_2" data-toggle="tab">Financial Details</a></li>
                    <li><a href="#tab_3" data-toggle="tab">Co-Makers</a></li>
                    <li><a href="#tab_4" data-toggle="tab">Collateral</a></li>
                </ul>
            </div>
            <div class="tab-content">
				<div class="tab-pane active fade in" id="tab_1">
					<g:render template="specification/show"/>
				</div>
				<div class="tab-pane" id="tab_2">
					<g:render template="financialDetails/show"/>
				</div>
				<div class="tab-pane" id="tab_3">
					<g:render template="comakers/show"/>
				</div>
				<div class="tab-pane" id="tab_4">
					<g:render template="collateral/show"/>
				</div>
			</div>		

			<div class="modal" id="update-status-modal">
				<div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                    <h4 class="modal-title">Update Status</h4>
		                </div>
		                <div class="modal-body">
		                </div>
		                <div class="modal-footer">
		                    <a href="#" data-dismiss="modal" class="btn">Close</a>
		                    <a href="#" class="btn btn-primary"onclick="updateStatusAjax()">Save</a>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
        </content>
		<content tag="main-actions">
                    <ul>
                        <li><g:link class="list" action="index">Search Loan Application</g:link></li>
                        <li><g:link action="edit" resource="${loanApplicationInstance}">Update Loan Application</g:link></li>
                        <li><a href="#" onclick="genReportLNA001();">Print Loan Application Form</a></li>


                        <li><a href="#" onclick="showUpdateStatus()">Update Status</a></li>
                        <li><g:link controller="creditInvestigation" action="create" params="[id:loanApplicationInstance?.id]">Perform Credit Investigation</g:link></li>
                        <li><g:link controller="loan" action="create" params="[id:loanApplicationInstance?.id]">Create Loan Account</g:link></li>
                        <%--<li><a href="#" onclick="window.print()">Print Details</a></li>--%>
                    </ul>
                        
                    <g:javascript>
                        function genReportLNA001(){
                            reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(16).baseParams}&output=${icbs.admin.Report.get(16).outputParam}";
                            reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(16).reportUnit}";             
                            reportlink = reportlink + "&loan_application_id=${loanApplicationInstance?.id}";
                            reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                            sendtojasperver(reportlink);
                        }       
                    </g:javascript>
		</content>
	</body>
</html>
