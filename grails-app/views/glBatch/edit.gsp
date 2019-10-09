<%@ page import="icbs.gl.GlBatch" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
                 <g:set var="entityName" value="${message(code: 'loan.label', default: 'General Ledger Batch')}" />
                 <g:if test="${session["postedOnOff"]=="postedOn"}">
                    <title>Posted General Ledger Batch Details</title>
                 </g:if>  
                 <g:else>
                      <title>Edit General Ledger Batch</title>
                 </g:else>  				  
		<g:javascript>
		    var getBatchAjaxLink = "${createLink(controller:'glBatch',action:'getBatchByBatchIdAjax')}";
		    var getBatchDetailsAjaxLink = "${createLink(controller:'glBatch',action:'getBatchDetailsAjax')}";
		    var batchId = "${glBatchHdrInstance?.batchId}";
		    var updateBatchTransactionsAjaxLink  = "${createLink(controller:'glBatch',action:'updateBatchGLTransactions')}";
		    var saveBatchTransactionsAjaxLink = "${createLink(controller:'glBatch',action:'saveGLBatchTransactions')}";
		  	
		  	var modal, modal2;
            
            
            function showGlCodesSearchModal() {
               	
               	// Check for the branch
               	
                var branch_id = $("#branch").val() === null ? 1 : $("#branch").val();
                var currency = $("#currency").val();
                const type = $("#transaction").val() === 'null' ? 7 : $("#transaction").val();
                	 
      			var domain;
      		
      			var title = "Search Accounts";

                if ( type == '1' || type == '2' || type == '3' )
                {
                	domain = "gl-deposits";
                }
            
                else if ( type == '4' || type == '5' )
                {
                	domain = "gl-loans";
                }

                else 
                {
					domain = "gl-glcode";
                }
 				

                modal = new icbs.UI.Modal({id:"glSearchModal", url:"${createLink(controller: 'search', action:'search')}",  params:{branch_id: branch_id, searchDomain: domain, currency:currency}, title: title, onCloseCallback:updateGlCode});
                
                modal.show(); 
            }

            function updateGlCode () {

                $("#glCode").val(modal.onCloseCallbackParams['glCode3']);
                $("#glBatchAccountHidden").val(modal.onCloseCallbackParams['glCode3']);
                $("#glName").val(modal.onCloseCallbackParams['glName']);
                document.getElementById('glname').value = $("#glName").val();
            } 
            
            function showLoanSearchModal () {

                var domain = "gl-loans"
            
                var title = "Search Loan Accounts";

                var branch_id = $("#branch").val() === null ? 1 : $("#branch").val();
                
                modal2 = new icbs.UI.Modal({id:"glLoanSearch", url:"${createLink(controller: 'search', action:'search')}",  params:{branch_id: branch_id, searchDomain: domain}, title:title, onCloseCallback:updateGlLoan});
                
                modal2.show(); 



            }

            function updateGlLoan () {
                
                $("#glBatchLoan").val(modal2.onCloseCallbackParams['glCode3']);
                $("#glBatchLoanHidden").val(modal2.onCloseCallbackParams['glCode3']);
            
            }                    
            function passAttachmentAndBatchIdToController(){
                
                console.log("boom");
                var filetopass = $("#file2")[0].files[0];
                var attids = $("#batchID").val();
                var attreferences = $("#reference").val();
                var attparticulars = $("#particulars").val();
                console.log("the batch id: "+attids)
                console.log("the reference: "+attreferences);
                console.log("the particular: "+attparticulars);
                
                var oMyForm = new FormData();
                oMyForm.append("file", filetopass);
                oMyForm.append("idbatch", attids);
                oMyForm.append("attreference", attreferences);
                oMyForm.append("attparticular", attparticulars);
                
                 var url="${createLink(controller:'GlBatch',action:'addAttachment')}";
                  $.ajax({
                  
                        url: url,
                        data: oMyForm,
                        dataType: 'text',
                        processData: false,
                        contentType: false,
                        type: 'POST',
                        
                        success: function(data){
                             console.log("success");
                             $('#tab_3').html(data);
                            
                        }
                 });
                
            }
            function removeAttachment(id){
                var sessionID = id
                var oMyForm = new FormData();
                oMyForm.append("id", sessionID);
                console.log("sessionID: "+sessionID);
                var url="${createLink(controller:'GlBatch',action:'removeAttachment')}";
                        $.ajax({

                              url: url,
                              data: oMyForm,
                              dataType: 'text',
                              processData: false,
                              contentType: false,
                              type: 'POST',

                              success: function(data){
                                   console.log("success");
                                   $('#tab_3').html(data);

                              }

                       });
            }
            

            
		</g:javascript>
	</head>
	<body>
    	<content tag="main-content">
			
    		<div id="batch">
				  
				<div id="edit-glBatch" class="content scaffold-edit" role="main">
					<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
					</g:if>
					<g:hasErrors bean="${glBatchInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${glBatchInstance}" var="error">
						<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
						</g:eachError>
					</ul>
					</g:hasErrors>
					<div class="nav-tab-container">
		              <ul class="nav nav-tabs">
		                <li class="active"><a href="#tab_1" data-toggle="tab">Batch Details</a></li>
		                <li><a href="#tab_2" data-toggle="tab">Transactions</a></li>
						<li><a href="#tab_3" data-toggle="tab">Attachments</a></li>																							
		              </ul>
	            	</div>
					<div class="tab-content">
			        	<div class="tab-pane active fade in" id="tab_1">
							<g:form url="[resource:glBatchInstance, action:'save']" >
								<fieldset class="form">
									<g:render template="form"/>
								</fieldset>
							</g:form>	
						</div>

						<div class="tab-pane fade in" id="tab_2">
							<div class="form-group text-right">
						 <g:if test="${session["postedOnOff"]=="postedOn"}">  
                                                     
                                                 </g:if>
                                                 <g:else>																		  
												 
             					<button type="button" v-on="click: showAddNewTransactionModal"class="btn btn-info"> Add Transaction 
             					</button>
             					<button type="button" class="btn btn-info" v-on="click: saveBatchTransactions" > Save
             					</button>
			   
						</g:else> 										   
          					</div>
							<fieldset class="form">
		        				<g:render template="transactions_table"/>
		        			</fieldset>	
			        	</div>
                                         <div class="tab-pane fade in" id="tab_3">
                                               <g:render template="batch_attachment"/>  
                                        </div>																				  
										
			        </div>
			        <form v-on="submit: addTransaction">
						<g:render template="modal"/>
					</form>
				</div>
			</div>
        </content>
            <content tag="main-actions">
                <ul>
                    <g:if test="${session["postedOnOff"]=="postedOn"}">  
                        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                        <li><g:link class="list" action="index">GL Batch Transactions</g:link></li>
                        <li><g:link class="create" action="create">New Batch Transactions</g:link></li>                   
                    </g:if>
                    <g:else>
                        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                        <li><g:link class="list" action="index">GL Batch Transactions</g:link></li>
                        <li><g:link class="create" action="create">New Batch Transactions</g:link></li>
                        <li><g:link class="approve" action="approve" id="${glBatchHdrInstance?.batchId}" params="['bId': glBatchHdrInstance?.batchId]">Approve Batch Transactions</g:link></li>
                        <li><g:link class="printGlBatch" target="_blank" action="printGlBatch" id="${glBatchHdrInstance?.id}" params="['Bid': glBatchHdrInstance?.id]">Print Batch Transactions</g:link></li>
                        <li><g:link class="voucherDetailsCheck" action="voucherDetailsCheck" id="${glBatchHdrInstance?.id}" params="['Bid': glBatchHdrInstance?.id]">Add Voucher Details</g:link></li>
                        <li><g:link class="printGlBatchVoucher" target="_blank" action="printGlBatchVoucher" id="${glBatchHdrInstance?.id}" params="['Bid': glBatchHdrInstance?.id]">Print Voucher Details</g:link></li>  
                    </g:else>    
				 
                </ul>
            </content>
            
	</body>
</html>
