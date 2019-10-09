<%@ page import="icbs.tellering.TxnLoanPaymentDetails" %>
<%@ page import="icbs.loans.LoanInstallment" %>


<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(14),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<fieldset class="form-group">
    <div class="col-sm-10">
        <fieldset class="form-group">
            <g:if test="${!txnLoanCashSpecifiedRepaymentInstance?.acct}">
                <input type="button" href="#" class="btn btn-primary" onclick="initializeLoanAcctSearchModal();modal.show()" value="Search Account"/>
            </g:if>
        </fieldset>
        <g:hiddenField id="loanId" name="loanId"/>
        <g:hiddenField id="_prin_" name="_prin_"/>
        <g:hiddenField id="_interest" name="_interest"/>
        <g:hiddenField id="_penalty" name="_penalty"/>
        <g:hiddenField id="_service" name="_service"/>
        <g:hiddenField id="_tax" name="_tax"/>
        <g:hiddenField id="totalBreakdown" name="totalBreakdown"/>
        <g:hiddenField id="test_Loan" name="test_Loan" value="0"/>
        <%--<g:render template='/tellering/details/loanDetails' model="[loanInstance:txnLoanCashSpecifiedRepaymentInstance?.acct]"/>--%>
        
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

<div class="fieldcontain form-group ${hasErrors(bean: txnLoanCashSpecifiedRepaymentInstance, field: 'paymentAmt', 'has-error')} required">
    <label class="control-label">Payment Amount</label>
    <div class="col-sm-6">
        <g:textField type="number" name="paymentAmt" required="" value="${txnLoanCashSpecifiedRepaymentInstance?.paymentAmt}"class="form-control truncated" onchange="updateVar()"/>
   </div>             
</div>

<div class="container-fluid">
    <div class="col-xs-9">
        <div class="infowrap">
            <table class="table table-bordered table-hover table-striped">
                <legend class="section-header"><h4>Payment Breakdown</h4></legend>
                <tr class = "info">
                    <td>
                        <label class="control-label" for="principalAmt">
                            <strong>
                                <g:message code="txnLoanCashSpecifiedRepayment.principalAmt.label" default="Principal" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField type="number" name="principalInstallmentAmount" required="" value="${loanInstallmentInstance?.principalInstallmentAmount}" class="form-control truncated" onchange="updateVar()"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label" for="interestAmt">
                            <strong>
                                <g:message code="txnLoanCashSpecifiedRepayment.interestAmt.label" default="Interest" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField type="number" name="interestInstallmentAmount" required="" value="${loanInstallmentInstance?.interestInstallmentAmount}" class="form-control truncated" onchange="updateVar()"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label" for="penaltyAmt">
                            <strong>
                                <g:message code="txnLoanCashSpecifiedRepayment.penaltyAmt.label" default="Penalty" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField type="number" name="penaltyInstallmentAmount" required="" value="${loanInstallmentInstance?.penaltyInstallmentAmount}" class="form-control truncated" onchange="updateVar()"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label" for="serviceChargeAmt">
                            <strong>
                                <g:message code="txnLoanCashSpecifiedRepayment.serviceChargeAmt.label" default="Service Charge" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField type="number" name="serviceChargeInstallmentAmount" required="" value="${loanInstallmentInstance?.serviceChargeInstallmentAmount}" class="form-control truncated" onchange="updateVar()"/>
                    </td>
                </tr>
                <tr> 
                    <td>
                        <label class="control-label" for="grtAmt">
                            <strong>
                                <g:message code="txnLoanCashSpecifiedRepayment.grtAmt.label" default="Gross Receipts Tax" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField type="number" name="grtAmt" required="" value="${txnLoanCashSpecifiedRepaymentInstance?.grtAmt}" class="form-control truncated" onchange="updateVar()" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="control-label" for="otherAmt">
                            <strong>
                                <g:message code="txnLoanCashSpecifiedRepayment.otherAmt.label" default="Others" />
                            </strong>
                        </label>
                    </td>
                    <td>
                        <g:textField type="number" name="otherAmt" required="" value="${txnLoanCashSpecifiedRepaymentInstance?.otherAmt}" class="form-control truncated" onchange="updateVar()" disabled="disabled"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnLoanCashSpecifiedRepaymentInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnLoanCashSpecifiedRepayment.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnLoanCashSpecifiedRepaymentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>