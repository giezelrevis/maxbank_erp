<%@ page contentType="text/html;charset=UTF-8" import="icbs.deposit.Deposit" %>


<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Transaction Approval</title>
        
        <g:javascript>
            function updateTxnAjax(params) {
                $('#txnID').val(params.txnFile2);

                $.ajax({
                    type: 'POST',
                    data: {id:params.txnFile2},
                    url: "${createLink(controller:'tellering', action:'showTxnAjax')}",
                    success: function(msg){
                                $('#txnType').html($(msg).find('#txnType').html());
                                $('#txnDate').html($(msg).find('#txnDate').html());
                                $('#txnAmt').html($(msg).find('#txnAmt').html());
                                $('#sender').html($(msg).find('#sender').html());
                                $('#senderBirthDate').html($(msg).find('#senderBirthDate').html());
                                $('#senderAddress').html($(msg).find('#senderAddress').html());
                                $('#senderPhoto').html($(msg).find('#senderPhoto').html());
                                $('#beneficiary').html($(msg).find('#beneficiary').html());
                                $('#beneficiaryBirthDate').html($(msg).find('#beneficiaryBirthDate').html());
                                $('#beneficiaryAddress').html($(msg).find('#beneficiaryAddress').html());
                                $('#beneficiaryPhoto').html($(msg).find('#beneficiaryPhoto').html());
                                $('#reference').html($(msg).find('#reference').html());
                                $('#particulars').html($(msg).find('#particulars').html());
                                $('#indic').html($(msg).find('#indic').html());
                                $('#status').html($(msg).find('#status').html());
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }
            function showTxnSearch() {				
                modal = new icbs.UI.Modal({id:"txnFileModal", url:"${createLink(controller: 'tellering', action:'search')}", title:"Search Transaction ID", onCloseCallback:updateTxnAjax});
                modal.show();
            }
        </g:javascript>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
          
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-8">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Transaction Details</legend>
                                    <tr>
                                        <td> Transaction Type </td>
                                        <td id="txnType">
                                            ${txnFileInstance.txnType.description}
                                        </td>
                                    </tr>   
                                    <tr>
                                        <td> Account Number </td>
                                        <td id="acctNo">
                                            ${txnTemplateInstance.acctNo}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Branch </td>
                                        <td id="branch">
                                            ${txnTemplateInstance.branch.name}
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td> Transaction Date </td>
                                        <td id="txnDate">
                                            ${txnFileInstance.txnDate}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Amount </td>
                                        <td id="txnAmt">
                                            ${txnFileInstance.txnAmt}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Code </td>
                                        <td id="txnCode">
                                            ${txnFileInstance.txnCode}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Description </td>
                                        <td id="txnTemplateDesc">
                                            ${txnFileInstance.txnTemplate.description}
                                        </td>
                                    </tr>  
                                   
                                    <tr>
                                        <td> Reference </td>
                                        <td id="reference">
                                            ${txnFileInstance.txnRef}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Particulars </td>
                                        <td id="particulars">
                                            ${txnFileInstance.txnParticulars}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Status </td>
                                        <td id="status">
                                            ${txnFileInstance.status.description}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> User </td>
                                        <td id="user">
                                            ${txnFileInstance.user.userName}
                                        </td>
                                    </tr>
                            </table>
                            <!-- <div class="section-container">
                                <fieldset>
                                    <legend class="section-header">Sender Details</legend>
                                    <div class="col-xs-8 col-sm-8 col-md-8">
                                        <div class="infowrap">
                                            <dl class="dl-horizontal">
                                                   <dt>Name</dt>
                                                   <dd id="sender">
                                                        <g:if test="${senderInstance}">
                                                            ${senderInstance.displayName}
                                                        </g:if>
                                                   </dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Date Of Birth</dt>
                                                   <dd id="senderBirthDate">
                                                        <g:if test="${senderInstance}">
                                                            ${senderInstance.birthDate}
                                                        </g:if>
                                                   </dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Address</dt>
                                                   <dd id="senderAddress">
                                                        <g:set var = "address" value="${senderInstance?.addresses?.find{it.isPrimary==true}}"/>
                                                        <g:if test="${address}">
                                                            ${address?.address1}<br>
                                                            ${address?.address2}<br>
                                                            ${address?.address3}<br>
                                                        </g:if>
                                                        <g:else>
                                                            N/A
                                                        </g:else><g:set var = "address" value="${senderInstance?.addresses?.find{it.isPrimary==true}}"/>
                                                        <g:if test="${address}">
                                                            ${address?.address1}<br>
                                                            ${address?.address2}<br>
                                                            ${address?.address3}<br>
                                                        </g:if>
                                                        <g:else>
                                                            N/A
                                                        </g:else>
                                                   </dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="infowrap">
                                        <dl class="dl-horizontal">
                                           <dd id="senderPhoto">
                                                <g:if test="${(senderInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (senderInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if>                                           
                                           </dd>
                                        </dl>
                                    </div>
                                </fieldset>
                            </div> -->
                            <!-- div class="section-container">
                                <fieldset>
                                    <legend class="section-header">Beneficiary Details</legend>
                                    <div class="col-xs-8 col-sm-8 col-md-8">
                                        <div class="infowrap">
                                            <dl class="dl-horizontal">
                                                   <dt>Name</dt>
                                                   <dd id="beneficiary
                                                        <g:if test="${beneficiaryInstance}">
                                                            ${beneficiaryInstance.displayName}
                                                        </g:if>
                                                   </dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Date Of Birth</dt>
                                                   <dd id="beneficiaryBirthDate">
                                                        <g:if test="${beneficiaryInstance}">
                                                            ${beneficiaryInstance.birthDate}
                                                        </g:if>
                                                   </dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Address</dt>
                                                   <dd id="beneficiaryAddress">
                                                        <g:set var = "address" value="${beneficiaryInstance?.addresses?.find{it.isPrimary==true}}"/>
                                                        <g:if test="${address}">
                                                            ${address?.address1}<br>
                                                            ${address?.address2}<br>
                                                            ${address?.address3}<br>
                                                        </g:if>
                                                        <g:else>
                                                            N/A
                                                        </g:else>
                                                   </dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="infowrap">
                                        <dl class="dl-horizontal">
                                            <dd id="beneficiaryPhoto">        
                                                <g:if test="${(beneficiaryInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (beneficiaryInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if>
                                            </dd>
                                        </dl>
                                    </div>
                                </fieldset>
                            </div> -->
                        </div>
                    </div>
                
                    <!-- <div class="col-md-4">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">GL Transaction</legend>
                                    <tr>
                                        <td> Debit </td>
                                        <td> Credit </td>
                                    </tr>
                                    <tr>
                                        <td> N/A </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td> N/A </td>
                                    </tr>
                            </table>
                        </div>
                    </div> -->
                </div>
            </div>
            
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Other Transaction Information</legend>
                                <tr>
                                    <td id="indic">
                                        ${indicator}
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
        </content>
        
        <content tag="main-actions">
            <ul>
                <li><g:link onclick="createReport">Print</g:link></li>
                <li><g:link action="takeAction" params="[isApproved:true, txnFileInstanceId:txnFileInstance.id]" >Approve</g:link></li>
                <li><g:link action="takeAction" params="[isApproved:false]" resource="${txnFileInstance}">Disapprove</g:link></li>
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to tellering index Page?');">Return to Tellering Index Page</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
