<%@ page import="icbs.tellering.TxnLoanPaymentDetails" %>

<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(12),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>
<!--<input type="hidden" id="id_loan" value="">-->
${txnLoanCashRepaymentInstance?.acct}
<fieldset class="form-group">
    <div class="col-sm-10">
        <fieldset class="form-group">
            <g:if test="${!txnLoanCashRepaymentInstance?.acct}">
                <input type="button" href="#" class="btn btn-primary" onclick="initializeLoanAcctSearchModal();modal.show();" value="Search Account"/>
            </g:if>
        </fieldset>
        <g:hiddenField id="loanId" name="loanId"/>
        <g:hiddenField id="test_Loan" name="test_Loan" value="0"/>
            
        <%--<g:render template='/tellering/details/loanDetails' model="[loanInstance:txnLoanCashRepaymentInstance?.acct]"/>--%>
        
        <div class="section-container">
        <fieldset>
        <legend class="section-header">Account Information</legend>
        <div class="infowrap">
        <div class="col-xs-8 col-sm-6 col-md-6">
             <dl class="dl-horizontal">
                <dt>Account Number</dt>
                <dd id="accountNo"></dd>
            </dl>            
            <dl class="dl-horizontal">
                <dt>Account Name</dt>
                <dd id="customer"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Date Opened</dt>
                <dd id="openingDate"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Status</dt>
                <dd id="status"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Principal Balance</dt>
                <dd id="principal1"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Interest Balance</dt>
                <dd id="intrest1"></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Penalty Balance</dt>
                <dd id="penalty1"></dd>
            </dl>            
            <dl class="dl-horizontal">
                <dt>Service Charge Balance</dt>
                <dd id="sc1"></dd>
            </dl>            
            <dl class="dl-horizontal">
                <dt>Tax Balance</dt>
                <dd id="tax1"></dd>
            </dl>          
        </div>
        </div>
        <div class="infowrap">
            <dl class="dl-horizontal">
                <dd id="photo"><g:if test="${(loanInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" style="float:right" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (loanInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></dd>
            </dl>
        </div>
        </fieldset>
        </div>
    </div>
</fieldset>

<div class="fieldcontain form-group ${hasErrors(bean: txnLoanCashRepaymentInstance, field: 'paymentAmt', 'has-error')} required">
    <label class="control-label">Payment Amount</label>
    <div class="col-sm-6">
        <g:textField type="number" name="paymentAmt" required="" value="${txnLoanCashRepaymentInstance?.paymentAmt}"class="form-control truncated" onkeyup="updateBreakdown()"/>
   </div>             
</div>


<div class="container-fluid">
    <div class="col-xs-9">
        <div class="infowrap">
            <table class="table table-bordered table-striped">
                <legend class="section-header"><h4>Payment Breakdown</h4></legend>
                <tr>
                    <td class="info">
                        <label class="control-label" for="principalAmt">
                            <strong>
                                <g:message code="txnLoanCashRepayment.principalAmt.label" default="Principal" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField id="principal" type="number" name="principal" readOnly="true" required="" class="form-control" value="0"/>
                        <g:hiddenField name="principalBalance" value="0"/>
                    </td>
                </tr>
                <tr>
                    <td class="info">
                        <label class="control-label" for="interestAmt">
                            <strong>
                                <g:message code="txnLoanCashRepayment.interestAmt.label" default="Interest" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField id="interest" type="number" name="interest" readOnly="true" required="" class="form-control" value="0"/>
                        <g:hiddenField name="interestBalance" value="0"/>
                    </td>
                </tr>
                <tr>
                    <td class="info">
                        <label class="control-label" for="penaltyAmt">
                            <strong>
                                <g:message code="txnLoanCashRepayment.penaltyAmt.label" default="Penalty" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField id="penalty" type="number" name="penalty" readOnly="true" required="" class="form-control" value="0"/>
                        <g:hiddenField name="penaltyBalance" value="0"/>
                    </td>
                </tr>
                <tr>
                    <td class="info">
                        <label class="control-label" for="serviceChargeAmt">
                            <strong>
                                <g:message code="txnLoanCashRepayment.serviceChargeAmt.label" default="Service Charge" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField id="serviceCharge" type="number" name="serviceCharge" readOnly="true" required="" class="form-control" value="0"/>
                        <g:hiddenField name="chargeBalance" value="0"/>
                    </td>
                </tr>
                <tr>
                    <td class="info">
                        <label class="control-label" for="grtAmt">
                            <strong>
                                <g:message code="txnLoanCashRepayment.grtAmt.label" default="Gross Receipts Tax" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField id="tax" type="number" name="tax" required="" readOnly="true" class="form-control" value="0"/>
                        <g:hiddenField name="taxBalance" value="0"/>
                    </td>
                </tr>
                <tr>
                    <td class="info">
                        <label class="control-label" for="otherAmt">
                            <strong>
                                <g:message code="txnLoanCashRepayment.otherAmt.label" default="Others" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField id="others" type="number" name="others" required="" readOnly="true" class="form-control" value="0"/>
                        <g:hiddenField name="otherBalance" value="0"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnLoanCashRepaymentInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnLoanCashRepayment.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnLoanCashRepaymentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>
<!--<input type="text" id="test_Loan" value="0">
    <input type="text" id="test_Loan1" value="">
    <input type="text" id="test_Loan2" value="">
    <input type="text" id="test_Loan3" value="">
    <input type="text" id="test_Loan4" value="">
    <input type="text" id="test_Loan5" value="">
    <input type="text" id="test_Loan6" value="">-->