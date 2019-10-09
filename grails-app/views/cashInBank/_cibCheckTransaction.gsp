
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'txnType', 'has-error')} required">
    <label class="control-label col-sm-4" for="txnType">Txn Template<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:select id="txnType" name="txnType" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(49),icbs.lov.MemoTxnType.read(1))}"   optionKey="id" optionValue="description" required="" value="" onchange="getcode();" class="many-to-one form-control"/>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'checkNo', 'has-error')} required">
    <label class="control-label col-sm-4" for="checkNo">Check Number<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="checkNo" id="checkNo" maxlength="25" required="" value="${cashInBankCheckbookInstance?.checkNo}"class="form-control"/>
        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="checkNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="checkNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankCheckbookInstance, field: 'reference', 'has-error')} required">
    <label class="control-label col-sm-4" for="reference">Reference<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="reference" maxlength="50" required="" value="${cashInBankCheckbookInstance?.reference}"class="form-control"/>
        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="reference">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="reference">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankCheckbookInstance, field: 'checkVoucherNo', 'has-error')} required">
    <label class="control-label col-sm-4" for="checkVoucherNo">Check Voucher No.</label>
    <div class="col-sm-8"><g:textField name="checkVoucherNo" id="checkVoucherNo" maxlength="50" required="" value="${cashInBankCheckbookInstance?.checkVoucherNo}"class="form-control"/>
        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="checkVoucherNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="checkVoucherNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankCheckbookInstance, field: 'checkDate', 'has-error')}">
	<label class="control-label col-sm-4" for="checkDate">
		Check Date 
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="checkDate" precision="day" 
    class="form-control" value="${cashInBankCheckbookInstance?.openDate}" />

        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="checkDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="checkDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankCheckbookInstance, field: 'payee', 'has-error')} required">
    <label class="control-label col-sm-4" for="payee">Payee<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="payee" maxlength="50" required="" value="${cashInBankCheckbookInstance?.payee}"class="form-control"/>
        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="payee">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="payee">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankCheckbookInstance, field: 'particulars', 'has-error')} required">
    <label class="control-label col-sm-4" for="particulars">Particulars<span class="required-indicator">*</span></label>
    <div class="col-sm-8"><g:textField name="particulars" id="particulars" maxlength="25" required="" value="${cashInBankCheckbookInstance?.particulars}"class="form-control"/>
        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="particulars">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="particulars">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankCheckbookInstance, field: 'checkAmt', 'has-error')} required">
    <label class="control-label col-sm-4" for="checkAmt">Check Amount<span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control truncated"  name="checkAmt" value="${cashInBankCheckbookInstance?.checkAmt}" />
        <g:hasErrors bean="${cashInBankCheckbookInstance}" field="checkAmt">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankCheckbookInstance}" field="checkAmt">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>



<g:hiddenField id="cashInBankInstanceChkT" name="cashInBankInstanceChkT" value="${params.id}" />