<%@ page import="icbs.admin.ClearingBank" %>




<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="clearingBank.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" maxlength="50" required="" value="${clearingBankInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="clearingBank.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="100" required="" value="${clearingBankInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'shortName', 'has-error')} required">
	<label class="control-label col-sm-4" for="shortName">
		<g:message code="clearingBank.shortName.label" default="Short Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="shortName" maxlength="50" required="" value="${clearingBankInstance?.shortName}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="shortName">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="shortName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'address', 'has-error')} ">
	<label class="control-label col-sm-4" for="address">
		<g:message code="clearingBank.address.label" default="Address" />
		
	</label>
	<div class="col-sm-8"><g:textArea name="address" cols="40" rows="5" maxlength="255" value="${clearingBankInstance?.address}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="address">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="address">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'contactPerson', 'has-error')} ">
	<label class="control-label col-sm-4" for="contactPerson">
		<g:message code="clearingBank.contactPerson.label" default="Contact Person" />
		
	</label>
	<div class="col-sm-8"><g:textField name="contactPerson" maxlength="50" value="${clearingBankInstance?.contactPerson}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="contactPerson">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="contactPerson">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'contact', 'has-error')} ">
	<label class="control-label col-sm-4" for="contact">
		<g:message code="clearingBank.contact.label" default="Contact" />
		
	</label>
	<div class="col-sm-8"><g:textField name="contact" maxlength="50" value="${clearingBankInstance?.contact}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="contact">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="contact">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'email', 'has-error')} ">
	<label class="control-label col-sm-4" for="email">
		<g:message code="clearingBank.email.label" default="Email" />
		
	</label>
	<div class="col-sm-8"><g:textField name="email" maxlength="50" value="${clearingBankInstance?.email}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="email">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="email">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: clearingBankInstance, field: 'swiftCode', 'has-error')} required">
	<label class="control-label col-sm-4" for="swiftCode">
		<g:message code="clearingBank.swiftCode.label" default="Swift Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="swiftCode" maxlength="10" required="" value="${clearingBankInstance?.swiftCode}"class="form-control"/>

            <g:hasErrors bean="${clearingBankInstance}" field="swiftCode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${clearingBankInstance}" field="swiftCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div><g:hiddenField name="configItemStatus" value="2" /></div>

