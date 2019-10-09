<%@ page import="icbs.loans.LoanLedger" %>
<%@ page import="icbs.admin.Branch" %>




<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loanLedger.loan.label" default="Loan Account" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="accountNo" value="${loanLedgerInstance?.loan?.accountNo}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanLedgerInstance}" field="loan">
                <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
        </g:hasErrors>
    </div>             

    <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showLoanSearch()" value="Search"/></div>
</div>

<g:hiddenField id="loan" name="loan.id" value="${loanLedgerInstance?.loan?.id}" />

<br/><br/>
<div id="customer-info">
    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Customer</label>
        <span id="customer"></span>
    </div>

    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Granted Amount</label>
        <span id="granted-amount"></span>
    </div>
       
    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Interest Rate</label>
        <span id="interest-rate"></span>
    </div>

    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Maturity Date</label>
        <span id="maturity-date"></span>
    </div>
    
    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Total Net Proceeds</label>
        <span id="total-net-proceeds"></span>
    </div>
    
    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Total Disburse Amount</label>
        <span id="total-disbursement-amount"></span>
    </div>

    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Principal Balance</label>
        <span id="principal-balance"></span>
    </div>
    
    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Overdue Principal Balance</label>
        <span id="overdue-principal-balance"></span>
    </div>
    
    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Interest Balance</label>
        <span id="interest-balance"></span>
    </div>

    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Penalty Balance</label>
        <span id="penalty-balance"></span>
    </div>

    <div class="fieldcontain form-group">
        <label class="control-label col-sm-4">Service Charge Balance</label>
        <span id="service-charge-balance"></span>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'deposit', 'has-error')} ">
    <label class="control-label col-sm-4" for="deposit">
        <g:message code="loanLedger.deposit.label" default="Deposit Account" />
    </label>
    <div class="col-sm-7"><g:field name="depositAccountNo" value="${loanLedgerInstance?.deposit?.acctNo}" class="form-control" readonly="true"/>        

        <g:hasErrors bean="${loanLedgerInstance}" field="deposit">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanLedgerInstance}" field="deposit">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>             

    <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showDepositSearch()" value="Search"/></div>
    <label class="control-label col-sm-4" for="deposit">
        <g:message code="loanLedger.deposit.label" default="Deposit Account Name" />
    </label>
    <div class="col-sm-7"><g:field name="depositAccountName" value="${loanLedgerInstance?.deposit?.customer?.displayName}" class="form-control" readonly="true"/>        
    </div>         
</div>

<g:hiddenField id="deposit" name="deposit.id" value="${loanLedgerInstance?.deposit?.id}" />

<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'txnType', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnType">
        <g:message code="loanLedger.txnType.label" default="Transaction Type" />        
    </label>
    <div class="col-sm-8">

              
                      <g:select id="txnType" name="txnType.id" from="${icbs.lov.MemoTxnType.findAll{id >= 4 && id <= 9}}" optionKey="id" optionValue="description" value="${loanLedgerInstance?.txnType?.id}" class="many-to-one form-control" onchange="updateForm()" />
     
<%--<g:hasErrors bean="${loanLedgerInstance}" field="txnType">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanLedgerInstance}" field="txnType">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>--%>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'txnTemplate', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnTemplate">
        <g:message code="loanLedger.txnTemplate.label" default="Transaction Code" />        
    </label>
    <div class="col-sm-8" id="txn-template">
        <%--<g:hasErrors bean="${loanLedgerInstance}" field="txnTemplate">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanLedgerInstance}" field="txnTemplate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>--%>
    </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'txnRef', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="loanLedger.txnRef.label" default="Transaction Reference" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:textField name="txnRef" value="${loanLedgerInstance?.txnRef}"class="form-control"/>

            <g:hasErrors bean="${loanLedgerInstance}" field="txnRef">
               <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'txnParticulars', 'has-error')} ">
	<label class="control-label col-sm-4" for="txnParticulars">
		<g:message code="loanLedger.txnParticulars.label" default="Transaction Particulars" />
		
	</label>
	<div class="col-sm-8"><g:textField name="txnParticulars" value="${loanLedgerInstance?.txnParticulars}"class="form-control"/>

            <g:hasErrors bean="${loanLedgerInstance}" field="txnParticulars">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="txnParticulars">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'txnDate', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnDate">
        <g:message code="loanLedger.txnDate.label" default="Transaction Date" />
        <span class="required-indicator">*</span>       
    </label>
    <div class="col-sm-8"><g:customDatePicker name="txnDate" readOnly="TRUE" precision="day" class="form-control" format="MM/dd/yyyy" value="${runDate}"/>

            <g:hasErrors bean="${loanLedgerInstance}" field="txnDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="txnDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div id="principal-debit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'principalDebit', 'has-error')} ">
	<label class="control-label col-sm-4" for="principalDebit">
		<g:message code="loanLedger.principalDebit.label" default="Principal Debit" />
		
	</label>
	<div class="col-sm-8"><g:field name="principalDebit" value="${fieldValue(bean: loanLedgerInstance, field: 'principalDebit')}" class="form-control truncated" onchange="updateVar()"/>

            <%--<g:hasErrors bean="${loanLedgerInstance}" field="principalDebit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="principalDebit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<div id="principal-credit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'principalCredit', 'has-error')} ">
	<label class="control-label col-sm-4" for="principalCredit">
		<g:message code="loanLedger.principalCredit.label" default="Principal Credit" />
		
	</label>
	<div class="col-sm-8"><g:field name="principalCredit" value="${fieldValue(bean: loanLedgerInstance, field: 'principalCredit')}" class="form-control truncated" onkeyup="prcr()"/>

           <%-- <g:hasErrors bean="${loanLedgerInstance}" field="principalCredit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="principalCredit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<%--<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'principalBalance', 'has-error')} ">
	<label class="control-label col-sm-4" for="principalBalance">
		<g:message code="loanLedger.principalBalance.label" default="Principal Balance" />
		
	</label>
	<div class="col-sm-8"><g:field name="principalBalance" value="${fieldValue(bean: loanLedgerInstance, field: 'principalBalance')}" class="form-control"/>

            <g:hasErrors bean="${loanLedgerInstance}" field="principalBalance">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="principalBalance">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>--%>


<div id="interest-debit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'interestDebit', 'has-error')} ">
	<label class="control-label col-sm-4" for="interestDebit">
		<g:message code="loanLedger.interestDebit.label" default="Interest Debit" />
		
	</label>
	<div class="col-sm-8"><g:field name="interestDebit" value="${fieldValue(bean: loanLedgerInstance, field: 'interestDebit')}" class="form-control truncated" />
            <%--<g:hasErrors bean="${loanLedgerInstance}" field="interestDebit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="interestDebit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<div id="interest-credit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'interestCredit', 'has-error')} ">
	<label class="control-label col-sm-4" for="interestCredit">
		<g:message code="loanLedger.interestCredit.label" default="Interest Credit" />
		
	</label>
	<div class="col-sm-8"><g:field name="interestCredit" value="${fieldValue(bean: loanLedgerInstance, field: 'interestCredit')}" class="form-control truncated" onchange="updateVar()"/>

            <%--<g:hasErrors bean="${loanLedgerInstance}" field="interestCredit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="interestCredit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<%--<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'interestBalance', 'has-error')} ">
	<label class="control-label col-sm-4" for="interestBalance">
		<g:message code="loanLedger.interestBalance.label" default="Interest Balance" />
		
	</label>
	<div class="col-sm-8"><g:field name="interestBalance" value="${fieldValue(bean: loanLedgerInstance, field: 'interestBalance')}" class="form-control"/>

            <g:hasErrors bean="${loanLedgerInstance}" field="interestBalance">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="interestBalance">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>--%>        


<div id="penalty-debit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'penaltyDebit', 'has-error')} ">
	<label class="control-label col-sm-4" for="penaltyDebit">
		<g:message code="loanLedger.penaltyDebit.label" default="Penalty Debit" />
		
	</label>
	<div class="col-sm-8"><g:field name="penaltyDebit" value="${fieldValue(bean: loanLedgerInstance, field: 'penaltyDebit')}" class="form-control truncated" onchange="updateVar()"/>

            <%--<g:hasErrors bean="${loanLedgerInstance}" field="penaltyDebit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="penaltyDebit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<div id="penalty-credit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'penaltyCredit', 'has-error')} ">
	<label class="control-label col-sm-4" for="penaltyCredit">
		<g:message code="loanLedger.penaltyCredit.label" default="Penalty Credit" />
		
	</label>
	<div class="col-sm-8"><g:field name="penaltyCredit" value="${fieldValue(bean: loanLedgerInstance, field: 'penaltyCredit')}" class="form-control truncated" onchange="updateVar()"/>

            <%--<g:hasErrors bean="${loanLedgerInstance}" field="penaltyCredit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="penaltyCredit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<div id="charges-debit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'chargesDebit', 'has-error')} ">
	<label class="control-label col-sm-4" for="chargesDebit">
		<g:message code="loanLedger.chargesDebit.label" default="Charges Debit" />
		
	</label>
	<div class="col-sm-8"><g:field name="chargesDebit" value="${fieldValue(bean: loanLedgerInstance, field: 'chargesDebit')}" class="form-control truncated" onchange="updateVar()"/>

            <%--<g:hasErrors bean="${loanLedgerInstance}" field="chargesDebit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="chargesDebit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<div id="charges-credit-form-group" class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'chargesCredit', 'has-error')} ">
	<label class="control-label col-sm-4" for="chargesCredit">
		<g:message code="loanLedger.chargesCredit.label" default="Charges Credit" />
		
	</label>
	<div class="col-sm-8"><g:field name="chargesCredit" value="${fieldValue(bean: loanLedgerInstance, field: 'chargesCredit')}" class="form-control truncated" onchange="updateVar()"/>

            <%--<g:hasErrors bean="${loanLedgerInstance}" field="chargesCredit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanLedgerInstance}" field="chargesCredit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>--%>
        </div>             
</div>


<div id="total-amount-form-group" class="fieldcontain form-group  ">
    <label class="control-label col-sm-4" for="principalCredit">
	Total Transaction Amount		
    </label>
        <div class="col-sm-8"><input type="null" name="total-amount" value="" class="form-control truncated" onkeyup="prcr()" id="total-amount" disabled="disabled"/>

        </div>             
</div>