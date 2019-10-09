<%@ page import="icbs.gl.GlBatchHdr" %>




<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'contraGl', 'has-error')} ">
	<label class="control-label col-sm-4" for="contraGl">
		<g:message code="glBatchHdr.contraGl.label" default="Contra Gl" />
		
	</label>
	<div class="col-sm-8"><g:select id="contraGl" name="contraGl.id" from="${icbs.gl.GlAccount.list()}" optionKey="id" value="${glBatchHdrInstance?.contraGl?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="contraGl">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="contraGl">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'errorGl', 'has-error')} ">
	<label class="control-label col-sm-4" for="errorGl">
		<g:message code="glBatchHdr.errorGl.label" default="Error Gl" />
		
	</label>
	<div class="col-sm-8"><g:select id="errorGl" name="errorGl.id" from="${icbs.gl.GlAccount.list()}" optionKey="id" value="${glBatchHdrInstance?.errorGl?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="errorGl">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="errorGl">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'batchType', 'has-error')} ">
	<label class="control-label col-sm-4" for="batchType">
		<g:message code="glBatchHdr.batchType.label" default="Batch Type" />
		
	</label>
	<div class="col-sm-8"><g:textField name="batchType" value="${glBatchHdrInstance?.batchType}"class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="batchType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="batchType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'batchParticulars', 'has-error')} ">
	<label class="control-label col-sm-4" for="batchParticulars">
		<g:message code="glBatchHdr.batchParticulars.label" default="Batch Particulars" />
		
	</label>
	<div class="col-sm-8"><g:textField name="batchParticulars" value="${glBatchHdrInstance?.batchParticulars}"class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="batchParticulars">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="batchParticulars">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'loanAcct', 'has-error')} ">
	<label class="control-label col-sm-4" for="loanAcct">
		<g:message code="glBatchHdr.loanAcct.label" default="Loan Acct" />
		
	</label>
	<div class="col-sm-8"><g:select id="loanAcct" name="loanAcct.id" from="${icbs.loans.Loan.list()}" optionKey="id" value="${glBatchHdrInstance?.loanAcct?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="loanAcct">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="loanAcct">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'txnType', 'has-error')} ">
	<label class="control-label col-sm-4" for="txnType">
		<g:message code="glBatchHdr.txnType.label" default="Txn Type" />
		
	</label>
	<div class="col-sm-8"><g:textField name="txnType" value="${glBatchHdrInstance?.txnType}"class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="txnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="txnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'batchCurrency', 'has-error')} required">
	<label class="control-label col-sm-4" for="batchCurrency">
		<g:message code="glBatchHdr.batchCurrency.label" default="Batch Currency" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="batchCurrency" name="batchCurrency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" required="" value="${glBatchHdrInstance?.batchCurrency?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="batchCurrency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="batchCurrency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'batchId', 'has-error')} required">
	<label class="control-label col-sm-4" for="batchId">
		<g:message code="glBatchHdr.batchId.label" default="Batch Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="batchId" required="" value="${glBatchHdrInstance?.batchId}"class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="batchId">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="batchId">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'batchName', 'has-error')} required">
	<label class="control-label col-sm-4" for="batchName">
		<g:message code="glBatchHdr.batchName.label" default="Batch Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="batchName" required="" value="${glBatchHdrInstance?.batchName}"class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="batchName">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="batchName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'branch', 'has-error')} required">
	<label class="control-label col-sm-4" for="branch">
		<g:message code="glBatchHdr.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="branch" name="branch.id" from="${icbs.admin.Branch.list()}" optionKey="id" required="" value="${glBatchHdrInstance?.branch?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="branch">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="branch">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'isBalanced', 'has-error')} ">
	<label class="control-label col-sm-4" for="isBalanced">
		<g:message code="glBatchHdr.isBalanced.label" default="Is Balanced" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="isBalanced" class="form-control" value="${glBatchHdrInstance?.isBalanced}" />

            <g:hasErrors bean="${glBatchHdrInstance}" field="isBalanced">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="isBalanced">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'isLocked', 'has-error')} ">
	<label class="control-label col-sm-4" for="isLocked">
		<g:message code="glBatchHdr.isLocked.label" default="Is Locked" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="isLocked" class="form-control" value="${glBatchHdrInstance?.isLocked}" />

            <g:hasErrors bean="${glBatchHdrInstance}" field="isLocked">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="isLocked">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'totalCredit', 'has-error')} required">
	<label class="control-label col-sm-4" for="totalCredit">
		<g:message code="glBatchHdr.totalCredit.label" default="Total Credit" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="totalCredit" value="${fieldValue(bean: glBatchHdrInstance, field: 'totalCredit')}" required="" class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="totalCredit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="totalCredit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glBatchHdrInstance, field: 'totalDebit', 'has-error')} required">
	<label class="control-label col-sm-4" for="totalDebit">
		<g:message code="glBatchHdr.totalDebit.label" default="Total Debit" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="totalDebit" value="${fieldValue(bean: glBatchHdrInstance, field: 'totalDebit')}" required="" class="form-control"/>

            <g:hasErrors bean="${glBatchHdrInstance}" field="totalDebit">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glBatchHdrInstance}" field="totalDebit">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

