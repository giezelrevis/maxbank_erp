
<g:hiddenField id="loanID" name="loanID" value="${ropaInstance?.loan}" />
<div class="fieldcontain form-group ${hasErrors(bean: loanLedgerInstance, field: 'loan', 'has-error')} ">
	<label class="control-label col-sm-4" for="loan">
		<g:message code="loanLedger.loan.label" default="Loan Account" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="accountNo" value="${ropaInstance?.loan}" class="form-control" readonly="true"/>        

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
<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'loan', 'has-error')} required">
    <label class="control-label col-sm-4" for="loan">Customer Name<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="loanAccountName" maxlength="25" required="" value="${ropaInstance?.loan?.customer?.displayName}"class="form-control" readonly="true"/>
        <g:hasErrors bean="${ropaInstance}" field="loan">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="loan">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<g:hiddenField id="financialYear" name="financialYear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>
<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'glContraLitigationExp', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContraLitigationExp">Litigation Expense GL Account<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField id="glContraLitigationExp" name="glContraLitigationExp" maxlength="25" required="" value="${ropaInstance?.glContraLitigationExp}" onblur="validateGlCode();" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="glContraLitigationExp">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="glContraLitigationExp">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<!-- Gl Account Description -->
<div id="glaccountdescription" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'depcontra', 'has-error')} required">
	<label class="control-label col-sm-4" for="memoTxnType">
		<g:message code="txnTemplate.memoTxnType.label" default="GL Account Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField readonly="true" name="gldescription" id="gldescription" maxlength="100" value="" onblur="validateGlCode();" class="form-control"/>

            <g:hasErrors bean="${ropaInstance}" field="memoTxnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="memoTxnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
    
<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'glContraRopa', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContraRopa">ROPA GL Account<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField id="glContraRopa" name="glContraRopa" maxlength="25" required="" value="${ropaInstance?.glContraRopa}" onblur="validateGlCodeROPA();" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="glContraRopa">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="glContraRopa">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<!-- Gl Account Description -->
<div id="glaccountdescription" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'depcontra', 'has-error')} required">
	<label class="control-label col-sm-4" for="memoTxnType">
		<g:message code="txnTemplate.memoTxnType.label" default="GL Account Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField readonly="true" name="gldescriptionContra" id="gldescriptionContra" maxlength="100" value="" onblur="validateGlCodeROPA();" class="form-control"/>

            <g:hasErrors bean="${ropaInstance}" field="memoTxnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="memoTxnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'ropaDate', 'has-error')}">
	<label class="control-label col-sm-4" for="ropaDate">
		ROPA Date
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="ropaDate" precision="day" 
    class="form-control" value="${ropaInstance?.ropaDate}" />

        <g:hasErrors bean="${ropaInstance}" field="ropaDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="ropaDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'txnType', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnType">Txn Template<span class="required-indicator">*</span></label>
                                    
    <div class="col-sm-8"><g:select id="txnType" name="txnType" from="${icbs.admin.TxnTemplate.findAllByTxnType(icbs.lov.TxnType.read(38))}" optionKey="id" optionValue="description" required="" value="" onchange="getcode();" class="many-to-one form-control"/>
    </div>             
</div>
                                
<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'reference', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContraRopa">Reference<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField id="reference" name="reference" maxlength="25" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="reference">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="reference">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'particulars', 'has-error')} required">
    <label class="control-label col-sm-4" for="glContraRopa">Particulars<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField id="particulars" name="particulars" maxlength="255" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="particulars">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="particulars">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>