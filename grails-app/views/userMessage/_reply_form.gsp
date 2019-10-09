<%@ page import="icbs.admin.UserMessage" %>



<div class="fieldcontain form-group ${hasErrors(bean: userMessageInstance, field: 'recipient', 'has-error')} required">
    <label class="control-label col-sm-4" for="recipient">
        <g:message code="userMessage.recipient.label" default="Recipient" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">${params.parentMessage.sender.name}

            <g:hasErrors bean="${userMessageInstance}" field="recipient">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMessageInstance}" field="recipient">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMessageInstance, field: 'subject', 'has-error')} required">
    <label class="control-label col-sm-4" for="subject">
        <g:message code="userMessage.subject.label" default="Subject" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">RE: ${params.parentMessage.subject}

            <g:hasErrors bean="${userMessageInstance}" field="subject">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMessageInstance}" field="subject">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMessageInstance, field: 'body', 'has-error')} ">
    <label class="control-label col-sm-4" for="body">
        <g:message code="userMessage.body.label" default="Body" />
        
    </label>
    <div class="col-sm-8"><g:textArea name="body" value="${userMessageInstance?.body}"class="form-control" rows="7"/>

            <g:hasErrors bean="${userMessageInstance}" field="body">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMessageInstance}" field="body">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div><g:hiddenField name="configItemStatus" value="2" /></div>
<div><g:hiddenField name="sender" value="${session.user_id}" /></div>
<div><g:hiddenField name="recipient" value="${params.parentMessage.sender.id}" /></div>
<div><g:hiddenField name="subject" value="${params.parentMessage.subject}" /></div>
<div><g:hiddenField name="sentAt" value="${new Date()}" /></div>
<div><g:hiddenField name="isRead" value="${false}" /></div>

