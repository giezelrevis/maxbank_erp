<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <title>Customer Inquiry</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main">
    <asset:javascript src="customerHelper.js"/>
    <g:javascript>
        /*Javascript function to open more addresses*/
        function openMoreAddresses(){
            $('#addressesModal').modal({show:true})
        }
        function viewAccounts(){
            $('#viewCustomerAcctsModal').modal({show:true})
        }
        function openNewAccount(){
            $('#openCustomerAccountsModal').modal({show:true})
        }
        /*Javascript to update Customer Status Page*/
        function openUpdateCustomerStatus(){
             icbs.Customer.Inquiry.Update.getForm('status',"${createLink(controller : 'customer', action:'getCustomerUpdateStatusFormAjax')}",{id:${customerInstance?.id}});
        }
        /*Javascript function to open more addresses*/
        function openUpdateCustomerCreditLimit(){
            icbs.Customer.Inquiry.Update.getForm('creditLimit',"${createLink(controller : 'customer', action:'getCustomerUpdateCreditLimitFormAjax')}",{id:${customerInstance?.id}});
        }
         /*Javascript function to update customerStatus in customerInquiry*/
        function updateCustomerInquiryForm(){
             icbs.Customer.Inquiry.Update('inquiryForm',"${createLink(controller : 'customer', action:'customerUpdateInquiryFormAjax')}",{id:${customerInstance?.id}});
        }
         
        /*Javascript function to submit customer update status form*/
        function updateCustomerStatusAjaxAuthCallback(){
            icbs.Customer.Inquiry.Update('status',"${createLink(controller : 'customer', action:'customerUpdateStatusAjax')}",jQuery('#customerUpdateStatusForm').serialize());
        }
        //Override for update customer status
        function updateCustomerStatusAjax(){
            checkIfAllowed('CIF00110', updateCustomerStatusAjaxAuthCallback, 'Override Customer Status Update', null); // params: policyTemplate.code, form to be saved
        }
                
        /*Javascript function to submit customer update credit limit form*/
        function updateCustomerCreditLimitAjaxAuthCallback(){
            icbs.Customer.Inquiry.Update('creditLimit',"${createLink(controller : 'customer', action:'customerUpdateCreditLimitAjax')}",jQuery('#tangina').serialize());
        }
        //Override for Update customer credit limit
        function updateCustomerCreditLimitAjax(){
            checkIfAllowed('CIF00120', updateCustomerCreditLimitAjaxAuthCallback, 'Override Customer Credit Limit Update', null); // params: policyTemplate.code, form to be saved
        }
        /*Remove Message inside modals on close and open*/
        /*flash message lives for one redirect request so when opening modals,
            messages from previous transaction will still show*/
        window.onload = function(){
            $('#updateCustomerStatusModal').on('hidden.bs.modal', function () {
                $('#updateStatusError').empty();
                $('#updateStatusMessage').empty();
                /*Dirty check and update customer status value in Customer 
                Inquiry Main Page*/
                updateCustomerInquiryForm();
            })
        }  
    </g:javascript>
  </head>
  <body>
    <content tag="breadcrumbs">
        <span class="fa fa-chevron-right"></span><span class="current">Customer Inquiry</span>
    </content>
    <content tag="main-content">
    <div id="customerInquiryFormDiv">
        <g:render template='inquiry/customerInquiryForm' />
    </div>
    <!-- The Modal for More Addresses-->
    <div class="modal" id="addressesModal">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Addresses</h4>
                </div>
                <div class="modal-body">
                    <g:each var="address" in="${customerInstance?.addresses}" status="i">
                        <g:if test="${address.statusId==2}">
                            <address>
                                <strong>Address ${i}/${address?.type.description}
                                <g:if test="${address?.isPrimary}">(Primary)</g:if></strong><br>
                                    ${address?.address1}<br>
                                    ${address?.address2}<br>
                                    ${address?.town}<br>
                                    ${address?.address3}<br>
                                     <g:if test="${address?.postalCode}"><br>Postal Code:${address?.postalCode}</g:if>
                                <br>
                                <abbr title="Phone">Phone 1:</abbr>
                                <g:if test="${address?.phone1}">
                                    ${address?.phone1}
                                </g:if>
                                <g:else>
                                    N/A
                                </g:else>
                                <br>
                                <abbr title="Phone">Phone 2:</abbr>
                                <g:if test="${address?.phone2}">
                                    ${address?.phone2}
                                </g:if>
                                <g:else>
                                    N/A
                                </g:else>
                                <br>
                                <abbr title="Phone">Fax 1:</abbr>
                                <g:if test="${address?.phone3}">
                                    ${address?.phone3}
                                </g:if>
                                <g:else>
                                    N/A
                                </g:else>
                                <br>
                                <abbr title="Phone">Fax 2:</abbr>
                                <g:if test="${address?.phone4}">
                                    ${address?.phone4}
                                </g:if>
                                <g:else>
                                    N/A
                                </g:else>
                                <br>
                                <ul>
                                    <g:if test="${address?.isMailing}"><li>Mailing</li></g:if>
                                    <g:if test="${address?.isMortaged}"><li>Mortaged</li></g:if>   
                                    <g:if test="${address?.isOwned}"><li>Owned</li></g:if>   
                                </ul>
                            </address> 
                        </g:if>
                    </g:each>
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                </div>
            </div>
        </div>
    </div>
    <!-- The Modal for More Addresses-->
    <div class="modal" id="updateCustomerStatusModal">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Update Customer Status</h4>
                </div>
                <div class="modal-body">
                    <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                    <div id="updateStatusDiv">
                     
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                    <a href="#" class="btn btn-primary" onclick="updateCustomerStatusAjax()">Save changes</a>
                </div>
            </div>
        </div>
    </div>
     <!-- The Modal for Customer CreditLimit-->
    <div class="modal" id="updateCustomerCreditLimitModal">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Update Customer Credit Limit</h4>
                </div>
                <div class="modal-body">
                    <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                    <div id="updateCreditLimitDiv">
                        
                        
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                    <a href="#" class="btn btn-primary"onclick="updateCustomerCreditLimitAjax()">Save changes</a>
                </div>
            </div>
        </div>
    </div>
     <!-- The Modal for Customer Accounts-->
    <div class="modal" id="viewCustomerAcctsModal">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">View Customer Accounts</h4>
                </div>
                <div class="modal-body">
                    <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                    <div class="row col-md-12">
                        <div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
                                    <tr>
					<td>Account Type</td>
                                        <td>Account Number</td>
                                        <td>Status</td>
                                    </tr>
				</thead>
                                <tbody>
                                    <g:each var="deposit" 
                                        in="${customerInstance?.deposits}" status="i">
                                            <tr>
                                            <td>
                                                ${deposit?.product?.name}
                                            </td>
                                            <td>
                                                <g:link action="depositInquiry" controller="deposit" id="${deposit?.id}">${deposit.acctNo}</g:link>
                                            </td>
                                            <td>
                                                ${deposit?.status?.description}
                                            </td>
                                            </tr>
                                    </g:each> 
                                    
                                    
                                    <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
                                    <tr>
					<td>Loan Type</td>
                                        <td>Account Number</td>
                                        <td>Status</td>
                                    </tr>
				</thead>
                                <tbody>
                                    <g:each var="loan" 
                                        in="${customerInstance?.loans}" status="i">
                                            <tr>
                                   
                                            <td>
                                                    ${loan?.product?.name}
                                            </td>
                                            <td>
                                                  <g:link action="show" controller="loan" id="${loan?.id}">${loan.accountNo}</g:link>
                                            </td>
                                            <td>
                                                ${loan?.status?.description}
                                            </td>
                                            </tr>
                                    </g:each> 

		                      
                               
                                    
                                </tbody>
                            </table>
                        
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                    <!--<a href="#" class="btn btn-primary"onclick="updateCustomerCreditLimitAjax()">Save changes</a> -->
                </div>
            </div>
        </div>
    </div>
     <!-- The Modal for Customer Open Accounts-->
    <div class="modal" id="openCustomerAccountsModal">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Open New Account</h4>
                </div>
                <div class="modal-body">
                    <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                    <button><g:link action="create" controller="deposit" params="${[customerFromCIFPage:customerInstance.id]}">Deposit Account</g:link></button>
                    <button><g:link action="create" controller="loanApplication" params="${[cid:customerInstance.id]}">Loan Application</g:link></button>
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                </div>
            </div>
        </div>
    </div>
    </content>
    <content tag="main-actions">
    <div id="actionsDiv">
         <g:render template='inquiry/action/action' />
    </div>
    </content>
  </body>
</html>
