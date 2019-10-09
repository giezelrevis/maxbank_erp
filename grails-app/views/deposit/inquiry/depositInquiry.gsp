    <%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.admin.UserMaster" %>
<html>
  <head>
    <title>Deposit Account Information</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main">
    <g:javascript>
        function showSignature(){
            $('#openDepositSignature').modal({show:true})  
        }
    </g:javascript>   
  </head>
  <body>
    <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Deposit Account Information</span>
    </content>
    <content tag="main-content">
    <div id="depositInquiryDiv">
        <g:render template='inquiry/depositInquiryForm'/>
    </div>
    <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                </script>
    </g:if>
     <!-- The Modal for Customer Open Accounts-->
    <div class="modal" id="openDepositSignature">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Deposit Signature</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <g:if test="${(depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id}"> <img width="240px" height="240px"src="${createLink(controller:'Attachment', action:'show', id: (depositInstance?.customer?.attachments?.find{it.isPrimarySig==true})?.id )}"/></g:if>
                       </div>
                    </div>
                     
                </div>
                <div class="modal-footer">
                    <a href="#" data-dismiss="modal" class="btn">Close</a>
                </div>
            </div>
        </div>
    </div>
    </content>
    <content tag="main-actions">
      <ul>
        <li><g:link action="depositSearch">Search Deposits</g:link></li>
        <g:if test="${!params?.module}">
    
            <g:if test="${depositInstance}">
              <li><g:link action="depositViewMoreInformation" id="${depositInstance.id}">View More Information</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">View More Information</button></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><g:link class="edit" action="edit" resource="${depositInstance}">Account Ammendment</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Account Ammendment</button></li>
            </g:else>
            <g:if test="${depositInstance?.type?.id == 2}">
              <li><g:link action="viewCheckbook" id="${depositInstance.id}">Checkbook Maintenance</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Checkbook Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance}">
                <g:if test="${depositInstance?.branch?.id == UserMaster?.get(session.user_id)?.branch?.id}">
                    <li><g:link action="viewPassbook" id="${depositInstance.id}">Passbook Maintenance</g:link></li>
                </g:if>
                <g:else>
                    <li><button disabled="disabled">Passbook Maintenance</button></li>
                </g:else>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Passbook Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance?.type?.id==3}">
              <li><g:link action="viewCTD" id="${depositInstance.id}">CTD Maintenance</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">CTD Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><g:link action="viewHold" id="${depositInstance.id}">Deposit Hold Maintenance</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Deposit Hold Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance}">
                <!--
                <li><g:link action="viewStandingOrder" id="${depositInstance.id}">Standing Order Maintenance</g:link></li>
                -->
                <li><button disabled="disabled">Standing Order Maintenance</button></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Standing Order Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><g:link action="viewMemo" id="${depositInstance.id}">Memo Transactions</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Memo Transactions</button></li>
            </g:else>
    
            <g:if test="${depositInstance?.product?.productType.id!=1 && depositInstance?.product?.productType.id!=3}">
              <li><g:link action="viewStopPaymentOrder" id="${depositInstance.id}">Stop Payment Order Maintenance</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Stop Payment Order Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance}">
               <g:if test="${depositInstance?.status?.id!=7}">
                    <li><g:link action="viewDepositStatus" id="${depositInstance.id}">Close Deposit Account</g:link></li>
               </g:if>
               <g:else>
                   <li><g:link action="viewDepositStatus" id="${depositInstance.id}">Reopen Deposit Account</g:link></li>
               </g:else>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Close Deposit Account</button></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><g:link action="viewInterestRateMaintenance" id="${depositInstance.id}">Deposit Interest Rate Maintenance</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Deposit Interest Rate Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><g:link action="viewSweep" id="${depositInstance.id}">ATA Sweep Maintenance</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">ATA Sweep Maintenance</button></li>
            </g:else>
            <g:if test="${depositInstance?.status?.id == 6}">
              <li><button disabled="disabled">Fund Transfer</button></li>
            </g:if>
            <g:else>
              <li><g:link action="viewFundTransfer" id="${depositInstance.id}">Fund Transfer</g:link></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><g:link action="viewClearChecksManually" id="${depositInstance.id}">Clear Checks Manually</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Clear Checks Manually</button></li>
            </g:else>
            <g:if test="${depositInstance?.type?.id == 3}">
              <li><g:link action="viewManualFdRollover" id="${depositInstance.id}">FD Rollover Options</g:link></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">FD Rollover Options</button></li>
            </g:else>
            <g:if test="${depositInstance}">
              <li><a href="#" onclick="showSignature()">Show Signature</a></li>
            </g:if>
            <g:else>
              <li><button disabled="disabled">Show Signature</button></li>
            </g:else>
        </g:if>
    
        <g:else>
            <g:if test="${depositInstance&&params.module=="edit"}">
              <li><g:link class="edit" action="edit" resource="${depositInstance}">Account Ammendment</g:link></li>
            </g:if>
            
            <g:if test="${depositInstance&&params.module=="checkbook"}">
              <li><g:link action="viewCheckbook" id="${depositInstance.id}">Checkbook Maintenance</g:link></li>
            </g:if>
    
            <g:if test="${depositInstance&&params.module=="passbook"}">
              <li><g:link action="viewPassbook" id="${depositInstance.id}">Passbook Maintenance</g:link></li>
            </g:if>
    
            <g:if test="${depositInstance&&params.module=="ctd"&&depositInstance?.type?.id==3}">
              <li><g:link action="viewCTD" id="${depositInstance.id}">CTD Maintenancee</g:link></li>
            </g:if>
            
            <g:if test="${depositInstance&&params.module=="hold"}">
              <li><g:link action="viewHold" id="${depositInstance.id}">Deposit Hold Maintenance</g:link></li>
            </g:if>
            
            <g:if test="${depositInstance&&params.module=="standingorder"}">
                <!--
                <li><g:link action="viewStandingOrder" id="${depositInstance.id}">Standing Order Maintenance</g:link></li>
                -->
                <li><button disabled="disabled">Standing Order Maintenance</button></li>
            </g:if>
            <g:if test="${depositInstance&&params.module=="memo"}">
              <li><g:link action="viewMemo" id="${depositInstance.id}">Memo Transactions</g:link></li>
            </g:if>
            <g:if test="${depositInstance&&params.module=="spo"}">
              <li><g:link action="viewStopPaymentOrder" id="${depositInstance.id}">Stop Payment Order Maintenance</g:link></li>
            </g:if>
            
            <g:if test="${depositInstance&&params.module=="close"}">
               <g:if test="${depositInstance?.status?.id!=7}">
                    <li><g:link action="viewDepositStatus" id="${depositInstance.id}">Close Deposit Account</g:link></li>
               </g:if>
               <g:else>
                   <li><g:link action="viewDepositStatus" id="${depositInstance.id}">Reopen Deposit Account</g:link></li>
               </g:else>
            </g:if>
            <g:if test="${depositInstance&&params.module=="irm"}">
              <li><g:link action="viewInterestRateMaintenance" id="${depositInstance.id}">Deposit Interest Rate Maintenance</g:link></li>
            </g:if>
            <g:if test="${depositInstance&&params.module=="sweep"}">
              <li><g:link action="viewSweep" id="${depositInstance.id}">ATA Sweep Maintenance</g:link></li>
            </g:if>
            <g:if test="${depositInstance&&params.module=="fundtransfer"}">
              <li><g:link action="viewFundTransfer" id="${depositInstance.id}">Fund Transfer</g:link></li>
            </g:if>
            <g:if test="${depositInstance&&params.module=="clearchecksmanually"}">
              <li><g:link action="viewClearChecksManually" id="${depositInstance.id}">Clear Checks Manually</g:link></li>
            </g:if>
            <g:if test="${depositInstance&&params.module=="manualfdrollover"&&depositInstance?.type?.id==3}">
              <li><g:link action="viewManualFdRollover" id="${depositInstance.id}">FD Rollover Options</g:link></li>
            </g:if>
        </g:else>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
      </ul>
    </content> 
  </body>
</html>