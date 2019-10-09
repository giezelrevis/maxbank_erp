<%@ page import="accounting.bankpayables.Payables" %>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'trnid', 'has-error')} ">
	<label class="control-label col-sm-4" for="trnid">
		<g:message code="payables.trnid.label" default="Transaction Number" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="trnid" value="${fieldValue(bean: payablesInstance, field: 'trnid')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="trnid">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="trnid">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'transdate', 'has-error')} ">
	<label class="control-label col-sm-4" for="transdate">
		<g:message code="payables.transdate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="transdate" value="${fieldValue(bean: payablesInstance, field: 'transdate')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="transdate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="transdate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'clientname', 'has-error')} ">
    <label class="control-label col-sm-4" for="clientname">
        <g:message code="payables.clientname.label" default="Client" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="clientname" value="${fieldValue(bean: payablesInstance, field: 'clientname')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="clientname">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="clientname">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'checkamt', 'has-error')} ">
    <label class="control-label col-sm-4" for="checkamt">
        <g:message code="payables.checkamt.label" default="Amount" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="checkamt" value="${fieldValue(bean: payablesInstance, field: 'checkamt')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="checkamt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="checkamt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'glaccount', 'has-error')} required">
    <label class="control-label col-sm-4" for="creditglacc">
        <g:message code="bankasset.glaccount.label" default="GL Account" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:select id="glaccount" name="glaccount.id" from="${icbs.gl.GlAccount.list(max: 100)}" optionKey="code" optionValue="name" required="" class="many-to-one form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="glaccount">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="glaccount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'duedate', 'has-error')} ">
    <label class="control-label col-sm-4" for="duedate">
        <g:message code="payables.duedate.label" default="Due Date" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="duedate" value="${fieldValue(bean: payablesInstance, field: 'duedate')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="duedate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="duedate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<!-- <div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'trntype', 'has-error')} ">
    <label class="control-label col-sm-4" for="trntype">
        <g:message code="payables.trntype.label" default="Trn. Type" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="trntype" value="${fieldValue(bean: payablesInstance, field: 'trntype')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="trntype">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="trntype">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> -->

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'trntype', 'has-error')} required">
    <label class="control-label col-sm-4" for="trntype">
        <g:message code="bankasset.trntype.label" default="Transaction Type" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:select id="trntype" name="trntype.id" from="${icbs.lov.TxnType.list(max: 100)}" optionKey="code" optionValue="description" required="" class="many-to-one form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="trntype">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="trntype">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'particulars', 'has-error')} ">
    <label class="control-label col-sm-4" for="duedate">
        <g:message code="payables.particulars.label" default="Particulars" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="particulars" value="${fieldValue(bean: payablesInstance, field: 'particulars')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="particulars">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="particulars">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- <div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'acc', 'has-error')} ">
    <label class="control-label col-sm-4" for="acc">
        <g:message code="payables.acc.label" default="Acc" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="acc" value="${fieldValue(bean: payablesInstance, field: 'acc')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="acc">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="acc">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: payablesInstance, field: 'apptype', 'has-error')} ">
    <label class="control-label col-sm-4" for="apptype">
        <g:message code="payables.apptype.label" default="App. Type" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="apptype" value="${fieldValue(bean: payablesInstance, field: 'apptype')}" class="form-control"/>

            <g:hasErrors bean="${payablesInstance}" field="apptype">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${payablesInstance}" field="apptype">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> -->