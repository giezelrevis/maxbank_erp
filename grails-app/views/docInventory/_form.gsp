<%@ page import="icbs.deposit.DocInventory" %>
<%@ page import="icbs.lov.DocInventoryType" %>

<div class="fieldcontain form-group ${hasErrors(bean: docInventoryInstance, field: 'type', 'has-error')} required">
	<label class="control-label col-sm-4" for="type">
		<g:message code="docInventory.type.label" default="Doc Inventory Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select disabled="${readonly}" id="type" name="type.id" from="${icbs.lov.DocInventoryType.list()}" optionKey="id"  optionValue="description" required="" value="${docInventoryInstance?.type?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${docInventoryInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${docInventoryInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: docInventoryInstance, field: 'seriesStart', 'has-error')} required">
	<label class="control-label col-sm-4" for="seriesStart">
		<g:message code="docInventory.seriesStart.label" default="Series Start" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="seriesStart" id="seriesStart" required="" value="${docInventoryInstance?.seriesStart}"class="form-control"/>

            <g:hasErrors bean="${docInventoryInstance}" field="seriesStart">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${docInventoryInstance}" field="seriesStart">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: docInventoryInstance, field: 'seriesEnd', 'has-error')} required">
	<label class="control-label col-sm-4" for="seriesEnd">
		<g:message code="docInventory.seriesEnd.label" default="Series End" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="seriesEnd" id="seriesEnd" required="" value="${docInventoryInstance?.seriesEnd}"class="form-control"/>

            <g:hasErrors bean="${docInventoryInstance}" field="seriesEnd">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${docInventoryInstance}" field="seriesEnd">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: docInventoryInstance, field: 'docParticulars', 'has-error')} required">
	<label class="control-label col-sm-4" for="docParticulars">
		<g:message code="docInventory.docParticulars.label" default="Particulars" />
	</label>
	<div class="col-sm-8"><g:textArea name="docParticulars" id="docParticulars" required="" value="${docInventoryInstance?.docParticulars}" class="form-control" rows="5" cols="40"/>

            <g:hasErrors bean="${docInventoryInstance}" field="docParticulars">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${docInventoryInstance}" field="docParticulars">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: docInventoryInstance, field: 'checkAcctNo', 'has-error')} required">
	<label class="control-label col-sm-4" for="checkAcctNo">
		<g:message code="docInventory.checkAcctNo.label" default="Account Number (for checks)" />
	</label>
	<div class="col-sm-8"><g:textField name="checkAcctNo" id="checkAcctNo" required="" value="${docInventoryInstance?.checkAcctNo}" class="form-control"/>

            <g:hasErrors bean="${docInventoryInstance}" field="checkAcctNo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${docInventoryInstance}" field="checkAcctNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> 