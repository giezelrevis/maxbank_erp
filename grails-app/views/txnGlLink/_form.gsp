<%@ page import="icbs.gl.TxnGlLink" %>




<div class="fieldcontain form-group ${hasErrors(bean: txnGlLinkInstance, field: 'status', 'has-error')} required">
	<label class="control-label col-sm-4" for="status">
		<g:message code="txnGlLink.status.label" default="Status" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="status" required="" value="${txnGlLinkInstance?.status}"class="form-control"/>
            <g:hasErrors bean="${txnGlLinkInstance}" field="status">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnGlLinkInstance}" field="status">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnGlLinkInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="txnGlLink.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="description" required="" value="${txnGlLinkInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${txnGlLinkInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnGlLinkInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
