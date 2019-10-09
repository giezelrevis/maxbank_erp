
<%@ page import="icbs.loans.LoanApplication" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>View Collateral</title>
		<g:javascript>			
                                function updateAmount() 
                                {
                                var Amt = $('#amount').val().replace(/([A-Z,a-z],#,@,-,+,=)/g,'');
                                $('#amount').val(Amt);
                                }
                           //Override status 1
                         function updateStatusAjax()
                         {
                         checkIfAllowed('LON00303', status); // params: policyTemplate.code, form to be saved
                         }
                    function status() {
				$.ajax({
				    type: 'POST',
				    data: $('#update-status-form').serialize(),
				    url: "${createLink(controller :'collateralManagement', action:'updateStatusAjax')}",
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
				$.ajax({
				    type: 'POST',
				    data: {id:"${collateralInstance.id}"},
				    url: "${createLink(controller :'collateralManagement', action:'showUpdateStatusAjax')}",
				    success: function(msg){
				    	jQuery('#update-status-modal .modal-body').html(msg);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
				
				$('#update-status-modal').modal({show:true});
            }                    	
   		</g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-collateral" class="content scaffold-show" role="main">
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
                    <li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
                    <g:if test="${collateralInstance?.collateralType?.id == 4}">
                    <li><a href="#tab_2" data-toggle="tab" id="pdc-tab">PDCs</a></li>
                    </g:if>
                    <li><a href="#tab_3" data-toggle="tab">Attachments</a></li>
                    <li><a href="#tab_4" data-toggle="tab">Loan Applications</a></li>
                </ul>
            </div>
            <div class="tab-content">
				<div class="tab-pane active fade in table-responsive" id="tab_1">
                    <g:render template="details/show"/>
                </div>
                <g:if test="${collateralInstance?.collateralType?.id == 4}">
                <div class="tab-pane" id="tab_2">
                    <g:render template="pdc/show"/>
                </div>
                </g:if>
                <div class="tab-pane" id="tab_3">
                    <g:render template="attachments/show"/>
                </div>
                <div class="tab-pane" id="tab_4">
                    <g:render template="loanApplications/show"/>
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
                <li><g:link class="list" action="index">Search Collateral</g:link></li>
                <li><g:link controller="collateralManagement" action="edit" id="${collateralInstance?.id}">Update Collateral</g:link></li>
                <li><a href="#" onclick="genReportLNA004()">Print Collateral Details</a></li>
                <g:javascript>
                    function genReportLNA004(){
                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(19).baseParams}&output=${icbs.admin.Report.get(19).outputParam}";
                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(19).reportUnit}";             
                        reportlink = reportlink + "&loan_collateral_id=${collateralInstance?.id}";
                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                        sendtojasperver(reportlink);
                    }       
                </g:javascript>  
                <li><a href="#" onclick="showUpdateStatus()">Update Status</a></li>
			</ul>
		</content>
	</body>
</html>
