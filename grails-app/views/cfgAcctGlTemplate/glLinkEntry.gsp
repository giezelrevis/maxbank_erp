<%@ page import="icbs.loans.InterestIncomeScheme" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Create New Gl Link Entry</title>
         
	</head>
     
	<body>
        <content tag="main-content">
         <script>
             function SubmitFormNow(){
                var glDescription = $('#description').val();
                var glLinkType = $('#glLinkEntry').val();
                
                if(glDescription=="" || glLinkType==""){
                    alertify.alert(AppTitle,"Fields Cannot be null !", 
                    function(){ 
                    });
                }else{
                    alertify.confirm(AppTitle,"Are you sure you want to create this?",
                        function(){
                          //alertify.success('New Gl Entry: '+glDescription+' Created!');
                          document.getElementById("myForm").submit();
                        },
                        function(){
                          alertify.error('Canceled');
                        });
                     
                              
                }
                
               
             }
         /*var details = {    
            addInputs: function(){
                console.log("success");
                var obj = {
                    check_no: $('#check_no').val(),
                    payee: $('#payee').val(),
                    approved_by: $('#approved_by').val(),
                    received_by: $('#received_by').val(),
                    
                };
                console.log(JSON.stringify(obj));
                var ajax = icbs.Dependencies.Ajax;
                    ajax.run({url:"${createLink(controller:'GlBatch', 
                                  action:'addVoucherDetails')}", 
                                  params:{check_no: $('#check_no').val(),
                                          payee: $('#payee').val(),
                                          approved_by: $('#approved_by').val(),
                                          received_by: $('#received_by').val(),},
                                          callback:callback});    		    	
                
            },
         
         }*/
         </script>    
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
               <g:form name="myForm" id="myForm" url="[action:'addGlLinkEntry',controller:'CfgAcctGlTemplate']">
                    <div>				
                        <div id="loan-template-form">
                             
                       
                        <legend></legend>
                        <div id="interest-rate-form-group" class="fieldcontain form-group">
                            <label class="control-label col-sm-4" for="interestRate">
                               Description:<span class="required-indicator">*</span>
                            </label>
                            <div class="col-sm-8">
                                <g:field type="text" name="description" id="description" value=""  required="" class="form-control"/>
                            </div>
                        </div>

                        <div id="termOfLoan-form-group"  class="fieldcontain form-group">
                                <label class="control-label col-sm-4" for="amount">
                                Gl Link Entry Type:<span class="required-indicator">*</span>
                                </label>
                                <div class="col-sm-8">
                                   <g:select id="glLinkEntry" name="glLinkEntry"  required="true" noSelection="${['':'']}" from="${icbs.lov.GlLinkEntryType.findAllByStatus(true)}" value="" optionKey="id" optionValue ="description"  class="form-control"/>
                                </div>
                        </div>

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
               <!-- <li><a href="#" onClick="details.addInputs()">Add Voucher Details</a></li>-->
                
                <li><a href="#" onclick="SubmitFormNow();">Create</a></li>
                <li><a href="index" >Cancel</a></li>
               <!-- <li><g:link controller="GlBatch" action="showVoucherDetails" id="${glBatchHdrInstance?.id}" params="['Bid': params.Bid]">Show Voucher Details</g:link></li> -->
            </ul>
        </content>
	</body>
         
</html>
