<%@ page import="icbs.gl.CfgAcctGlTemplateDet" %>

<div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glAcct', 'has-error')} ">
	<label class="control-label col-sm-4" for="glAcct">
		<g:message code="cfgAcctGlTemplateDet.glAcct.label" default="Gl Acct ${cfgAcctGlTemplateDetInstance?.glAcct}" />
		
	</label>
	<div class="col-sm-8">
        <g:textField id="glAcct" name="glAcct" required="" value="${cfgAcctGlTemplateDetInstance?.glCode}"class="form-control"/>
        
            <g:hasErrors bean="${cfgAcctGlTemplateDetInstance}" field="glAcct">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${cfgAcctGlTemplateDetInstance}" field="glAcct">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
	<label class="control-label col-sm-4" for="glDescription">
		<g:message code="cfgAcctGlTemplateDet.glDescription.label" default="GL Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="glDescription" required="" value="${cfgAcctGlTemplateDetInstance?.glDescription}"class="form-control"/>

            <g:hasErrors bean="${cfgAcctGlTemplateDetInstance}" field="glDescription">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${cfgAcctGlTemplateDetInstance}" field="glDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glTemplate', 'has-error')} required">
	<label class="control-label col-sm-4" for="glTemplate">
		<g:message code="cfgAcctGlTemplateDet.glTemplate.label" default="Gl Template" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="glTemplate" name="glTemplate.id" from="${icbs.gl.CfgAcctGlTemplate.list()}" optionValue="description" optionKey="id" required="" value="${cfgAcctGlTemplateDetInstance?.glTemplate?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${cfgAcctGlTemplateDetInstance}" field="glTemplate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${cfgAcctGlTemplateDetInstance}" field="glTemplate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

