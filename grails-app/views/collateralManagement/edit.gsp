<%@ page import="icbs.loans.Collateral" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Edit Collateral</title>
		<g:javascript>   
                             function updateAmount() 
                                {
                                var Amt = $('#amount').val().replace(/([A-Z,a-z],#,@,-,+,=)/g,'');
                                $('#amount').val(Amt);
                                }
                    
             var rem
            var chattel;
            var holdout;
            //var pdc;

			// update form fields based on collateral type
    		updateForm = function() {
    			var collateralType = $('#collateralType').val();

    			if (collateralType == 1) {  // REM
    				document.getElementById('appraised-value-type-form-group').style.display = 'block';

                    if (!chattel)
                        chattel = $('#chattel-form-group').detach();

                    if (!holdout)
                        holdout = $('#holdout-form-group').detach();

                    $('#pdc-tab').hide();
                    /*if (!pdc)                   
                        pdc = $('#pdc-form-group').detach();*/

                    rem.appendTo($('#tab_1'));
                    rem = null;
    			} else if (collateralType == 2) {  // chattel
    				document.getElementById('appraised-value-type-form-group').style.display = 'none';

                    if (!rem)
                        rem = $('#rem-form-group').detach();

                    if (!holdout)
                        holdout = $('#holdout-form-group').detach();

                    $('#pdc-tab').hide();
                    /*if (!pdc)                   
                        pdc = $('#pdc-form-group').detach();*/

                    chattel.appendTo($('#tab_1'));
                    chattel = null;
    			} else if (collateralType == 3) {  // holdout		    		
					document.getElementById('appraised-value-type-form-group').style.display = 'none';

                    if (!rem)
                        rem = $('#rem-form-group').detach();

                    if (!chattel)
                        chattel = $('#chattel-form-group').detach();

                    $('#pdc-tab').hide();
                    /*if (!pdc)                   
                        pdc = $('#pdc-form-group').detach();*/

                    holdout.appendTo($('#tab_1'));
                    holdout = null;
				} else if (collateralType == 4) {  // PDC
					document.getElementById('appraised-value-type-form-group').style.display = 'none';

                    if (!rem)
                        rem = $('#rem-form-group').detach();

                    if (!chattel)
                        chattel = $('#chattel-form-group').detach();

                    if (!holdout)                   
                        holdout = $('#holdout-form-group').detach();

                    $('#pdc-tab').show();
                    /*pdc.appendTo($('#tab_1'));
                    pdc = null;*/
		    	} else {
                    document.getElementById('appraised-value-type-form-group').style.display = 'none';

                    if (!rem)
                        rem = $('#rem-form-group').detach();

                    if (!chattel)
                        chattel = $('#chattel-form-group').detach();

                    if (!holdout)                   
                        holdout = $('#holdout-form-group').detach();

                    $('#pdc-tab').hide();
                    /*if (!pdc)
                        pdc = $('#holdout-form-group').detach();*/
                }
			}; 

			function updateOwnerAjax(params) {	
                $.ajax({
				    type: 'POST',
				    data: {id:params.customer2},
				    url: "${createLink(controller:'customer', action:'showBasicCustomerInfoAjax')}",
				    success: function(msg){				    	
						$('#owner-name').val($(msg).find('#display-name').html());
						$('#owner').val(params.customer2);
				    },
				    error:function(XMLHttpRequest,textStatus,errorThrown){
                		alert(XMLHttpRequest+textStatus+errorThrown);
            		}
				});
            }

        	function showOwnerSearch() {
                modal = new icbs.UI.Modal({id:"customerDetailsModal", url:"${createLink(controller: 'search', action:'search')}", title:"Search Customer", onCloseCallback:updateOwnerAjax});
                modal.show();                   
            }   

            function showPDCs() {
                $.ajax({
                    type: 'POST',
                    data: {id:${collateralInstance?.id}},
                    url: "${createLink(controller:'collateralManagement', action:'showPDCsAjax2')}",
                    success: function(msg){                     
                        $('#tab_2').html(msg);
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function addPDCAjax() {
                $.ajax({
                    type: 'POST',
                    data: {id:${collateralInstance?.id}, accountNo:$('#accountNo').val(), checkNo:$('#checkNo').val(), amount:$('#amount').val(), bank:$('#bank').val(), onUs:$('#onUs').is(":checked"), pdcDate:$('#pdcDate').val()},
                    url: "${createLink(controller:'collateralManagement', action:'addPDCAjax2')}",
                    success: function(msg){
                        $('#add-pdc-modal .modal-body').html(msg);
                        $('#add-pdc-modal').on('hidden.bs.modal', function() {
                            showPDCs();
                        });                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });             
            }

            function showAddPDC() {
               modal = new icbs.UI.Modal({id:"add-pdc-modal", url:"${createLink(controller: 'collateralManagement', action:'showAddPDCAjax')}", title:"Add PDC"});
                modal.show();
            }

            function updatePDCAjax() {
                $.ajax({
                    type: 'POST',
                    data: {id:$('#pdcId').val(), accountNo:$('#accountNo').val(), checkNo:$('#checkNo').val(), amount:$('#amount').val(), bank:$('#bank').val(), onUs:$('#onUs').is(":checked"), pdcDate:$('#pdcDate').val()},
                    url: "${createLink(controller:'collateralManagement', action:'updatePDCAjax2')}",
                    success: function(msg){
                        $('#update-pdc-modal .modal-body').html(msg);
                        $('#update-pdc-modal').on('hidden.bs.modal', function() {
                            showPDCs();
                        });                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }            

            function showUpdatePDC(id) {
                $.ajax({
                    type: 'POST',
                    data: {id:id},
                    url: "${createLink(controller:'collateralManagement', action:'showUpdatePDCAjax2')}",
                    success: function(msg){
                        $('#pdcId').val(id);
                        $('#update-pdc-modal .modal-body').html(msg);     
                        $('#update-pdc-modal').modal({show:true});
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function deletePDCAjax(id) {
                if (confirm('Are you sure?')) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${collateralInstance?.id}, pdcId:id},
                        url: "${createLink(controller:'collateralManagement', action:'deletePDCAjax2')}",
                        success: function(msg){
                            showPDCs();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }

            function showAttachments() {
                $.ajax({
                    type: 'POST',
                    data: {id:${collateralInstance?.id}},
                    url: "${createLink(controller:'collateralManagement', action:'showAttachmentsAjax2')}",
                    success: function(msg){                     
                        $('#tab_3').html(msg);
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function addAttachmentAjax() {
                var file = (document.getElementById("fileData")).files[0];                                

                var data = new FormData(); 
                data.append("id", ${collateralInstance?.id});
                data.append("file", file);
                data.append("description", $('#add-attachment-modal #description').val());
                data.append("type", $('#add-attachment-modal #type').val());

                $.ajax({
                    type: 'POST',
                    data: data,
                    contentType: false,
                    processData: false,
                    url: "${createLink(controller:'collateralManagement', action:'addAttachmentAjax2')}",
                    success: function(msg){
                        $('#add-attachment-modal .modal-body').html(msg);
                        $('#add-attachment-modal').on('hidden.bs.modal', function() {
                            showAttachments();
                        });                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });        
            }            

            function showAddAttachment() {
                modal = new icbs.UI.Modal({id:"add-attachment-modal", url:"${createLink(controller: 'collateralManagement', action:'showAddAttachmentAjax')}", title:"Add Attachment"});
                modal.show();
            }

            function updateAttachmentAjax() {
                var description = $('#update-attachment-modal #description').val();
                var type = $('#update-attachment-modal #type').val();
                
                $.ajax({
                    type: 'POST',
                    data: {id:$('#attachmentId').val(), description:description, type:type},
                    url: "${createLink(controller:'collateralManagement', action:'updateAttachmentAjax2')}",
                    success: function(msg){
                        $('#update-attachment-modal .modal-body').html(msg);
                        $('#update-attachment-modal').on('hidden.bs.modal', function() {                        
                            showAttachments();
                        });                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }            

            function showUpdateAttachment(id) { 
                $.ajax({
                    type: 'POST',
                    data: {id:id},
                    url: "${createLink(controller:'collateralManagement', action:'showUpdateAttachmentAjax2')}",
                    success: function(msg){
                        $('#attachmentId').val(id);
                        $('#update-attachment-modal .modal-body').html(msg);                      
                        $('#update-attachment-modal').modal({show:true});                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function deleteAttachmentAjax(id) {
                if (confirm('Are you sure?')) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${collateralInstance?.id}, attachmentId:id},
                        url: "${createLink(controller:'collateralManagement', action:'deleteAttachmentAjax2')}",
                        success: function(msg){
                            showAttachments();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }	

            function showLoanApplications() {            
                $.ajax({
                    type: 'POST',
                    data: {id:${collateralInstance?.id}},
                    url: "${createLink(controller:'collateralManagement', action:'showLoanApplicationsAjax2')}",
                    success: function(msg){                     
                        $('#tab_4').html(msg);
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function addLoanApplicationAjax(params) {
                if (params.loanApplication2) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${collateralInstance?.id}, loanApplicationId:params.loanApplication2},
                        url: "${createLink(controller:'collateralManagement', action:'addLoanApplicationAjax2')}",
                        success: function(msg){                  
                            showLoanApplications();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }

            function showLoanApplicationSearch() {              
                modal = new icbs.UI.Modal({id:"loanApplicationModal", url:"${createLink(controller: 'loanApplication', action:'search')}", title:"Search Loan Application", onCloseCallback:addLoanApplicationAjax});
                modal.show();
            }

            function deleteLoanApplicationAjax(id) {
                if (confirm('Are you sure?')) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${collateralInstance?.id}, loanApplicationId:id},
                        url: "${createLink(controller:'collateralManagement', action:'deleteLoanApplicationAjax2')}",
                        success: function(msg){
                            showLoanApplications();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }

        	icbs.Dependencies.Ajax.addLoadEvent(function(){
                rem = $('#rem-form-group').detach();
                chattel = $('#chattel-form-group').detach();
                holdout = $('#holdout-form-group').detach();
                pdc = $('#pdc-form-group').detach();

            	updateForm();
            });
        </g:javascript>	
	</head>
	<body>
        <content tag="main-content">
		<div id="edit-collateral" class="content scaffold-edit" role="main">
            <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                </script>
            </g:if>
            <g:hasErrors bean="${collateralInstance}">
	            <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                    </script>
            </g:hasErrors>

			<g:form id="collateral-form" url="[controller:collateralManagement, action:'update', id:collateralInstance?.id]" method="PUT">
				<g:hiddenField name="version" value="${collateralInstance?.version}" />
                <div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
                        <li><a href="#tab_2" data-toggle="tab" id="pdc-tab">PDCs</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Attachments</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Loan Applications</a></li>
                    </ul>
                </div>      
                <div class="tab-content">
                    <div class="tab-pane active fade in table-responsive" id="tab_1">
                        <g:render template="details/form"/>
                    </div>
                    <div class="tab-pane" id="tab_2">
                        <g:render template="pdc/list"/>
                    </div>
                    <div class="tab-pane" id="tab_3">
                        <g:render template="attachments/list"/>
                    </div>
                    <div class="tab-pane" id="tab_4">
                        <g:render template="loanApplications/list"/>
                    </div>
                </div>				
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                 <ul>
	            	<li><g:submitButton id="save" name="save" value="Save" /></li>
	            	 <script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#save" ).click(function() {
                                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                    //jQuery('#txnBillsPaymentForm').submit();
		             		 checkIfAllowed('LON00302', 'form#collateral-form', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
                                },
                                function(){
                                    return;
                                });                                
		               	});
		            }); 
                          </script>
                        <li><g:link class="list" action="show" id="${collateralInstance.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
	            </ul>
            </content>
            
	</body>
</html>
