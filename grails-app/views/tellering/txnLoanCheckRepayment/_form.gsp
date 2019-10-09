<%@ page import="icbs.tellering.TxnLoanPaymentDetails" import="icbs.tellering.TxnCOCI" %>


<div class="form-group">
    <label class="control-label">Transaction Type</label>
    <div class="col-sm-6">
        <select id="txnTemplate" name="txnTemplate" class="many-to-one form-control">
            <option selected="selected" disabled="true">-- Select a transaction type --</option>
            <g:each in="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(13),[sort:"code", order:"asc"])}" var="txnTemplateInstance">
                <option value="${txnTemplateInstance.id}" data-code="${txnTemplateInstance.code}">${txnTemplateInstance.codeDescription}</option>
            </g:each>
        </select>
    </div>
</div>

<fieldset class="form-group">
    <div class="col-sm-10">
        <fieldset class="form-group">
            <g:if test="${!txnLoanCheckRepaymentInstance?.acct}">
                <input type="button" href="#" class="btn btn-primary" onclick="initializeLoanAcctSearchModal();modal.show()" value="Search Account"/>
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

<div class="fieldcontain form-group ${hasErrors(bean: txnLoanCheckRepaymentInstance, field: 'paymentAmt', 'has-error')} required">
    <label class="control-label">Payment Amount</label>
    <div class="col-sm-6">
        <g:textField type="number" id="paymentAmt" name="paymentAmt" required="" value="${txnLoanCheckRepaymentInstance?.paymentAmt}"class="form-control truncated" onkeyup="updateBreakdown()"/>
   </div>             
</div>

<div class="form-group form-buttons">
    <button id="add-button" type="button" onclick="showAddChecks()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Check</button>
</div>


<div class="table-responsive" id="check_table">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
        <tr>
            <td><label>Check Type</label></td>
            <td><label>Bank</label></td>
            <td><label>Account Number</label></td>
            <td><label>Check Date</label></td>
            <td><label>Check Number</label></td>
            <td><label>Clearing Date</label></td>
            <td><label>Check Amount</label></td>
            <td class="col-sm-2"><label>Actions</label></td>		
	</tr>
    </tbody>
    <tbody>
        <g:if test="${txnCOCIInstance?.checks}">
            <g:each var="check" in="${txnCOCIInstance?.checks.sort{it.description}}">
                <tr>
                    <td>${check?.checkType?.description}</td>
                    <td>${check?.bank?.name}</td>
                    <td>${check?.acctNo}</td>
                    <td>${check?.checkDate}</td>
                    <td>${check?.checkNo}</td>
                    <td>${check?.clearingDate}</td>
                    <td>${check?.checkAmt}</td>
                    <td>
                        <a href="#" class="btn btn-secondary" onclick="deleteCheckAjax('${check?.id}')">Remove</a>
                    </td>		
                </tr>
            </g:each>
        </g:if>
        <g:elseif test="${session["checks"]}">
            <g:set var="i" value="${0}" />
            <g:each var="check" in="${session["checks"]}">
                <tr>
                    <td>${check?.checkType?.description}</td>
                    <td>${check?.bank?.name}</td>
                    <td>${check?.acctNo}</td>
                    <td>${check?.checkDate}</td>
                    <td>${check?.checkNo}</td>
                    <td>${check?.clearingDate}</td>
                    <td>${check?.checkAmt}</td>
                    <td>
                        <a href="#" class="btn btn-secondary" onclick="deleteCheckAjax('${i}')">Remove</a>
                    </td>		
                </tr>
                <g:set var="i" value="${i = i + 1}" />
            </g:each>		
        </g:elseif>
    </tbody>
    </table>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'txnAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnAmt">
        <g:message code="txnCOCI.txnAmt.label" default="Check Control Total" />
    </label>

    <div class="col-sm-6">
        <g:field id="Check_Control_Total" name="txnAmt" disabled="" value="${fieldValue(bean: txnCOCIInstance, field: 'txnAmt')}" class="form-control"/>
        <g:hiddenField name="totalAmtCheccckPayment" id="totalAmtCheccckPayment" value="" />
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
                                <g:message code="txnLoanCheckRepayment.principalAmt.label" default="Principal" />
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
                                <g:message code="txnLoanCheckRepayment.interestAmt.label" default="Interest" />
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
                                <g:message code="txnLoanCheckRepayment.penaltyAmt.label" default="Penalty" />
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
                                <g:message code="txnLoanCheckRepayment.serviceChargeAmt.label" default="Service Charge" />
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
                                <g:message code="txnLoanCheckRepayment.grtAmt.label" default="Gross Receipts Tax" />
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
                                <g:message code="txnLoanCheckRepayment.otherAmt.label" default="Others" />
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


<div class="fieldcontain form-group ${hasErrors(bean: txnLoanCheckRepaymentInstance, field: 'txnRef', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnLoanCheckRepayment.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textArea name="txnRef" required="" value="${txnLoanCheckRepaymentInstance?.txnRef}"class="form-control"/>
    </div>             
</div>