<%@ page import="icbs.admin.UserMessage" %>



<div class="fieldcontain form-group ${hasErrors(bean: userMessageInstance, field: 'recipient', 'has-error')} required">
	<label class="control-label col-sm-4" for="recipient">
		<g:message code="userMessage.recipient.label" default="Recipient" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="recipient" name="recipient.id" from="${icbs.admin.UserMaster.list(sort: "username")}" optionKey="id" optionValue="name" required="true" value="${userMessageInstance?.recipient?.id}" class="many-to-one form-control"  noSelection="['': '']"/>

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
	<div class="col-sm-8"><g:textField name="subject" required="" value="${userMessageInstance?.subject}"class="form-control"/>

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
	<div class="col-sm-8"><g:textArea name="body" id="body" value="${userMessageInstance?.body}" class="form-control textarea" rows="10"/>
            <script>
                 $(function(){
                     var txtarea = $('.textarea');
                                                txtarea.wysihtml5({
                                                    "fa" : true,
                                                    "font-styles": true, //Font styling, e.g. h1, h2, etc. Default true
                                                    "emphasis": true, //Italics, bold, etc. Default true
                                                    "lists": true, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
                                                    "html": false, //Button which allows you to edit the generated HTML. Default false
                                                    "link": false, //Button to insert a link. Default true
                                                    "image": false, //Button to insert an image. Default true,
                                                    "color": true //Button to change color of font  
                                                });
                 });
            </script>
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
<div><g:hiddenField name="sentAt" value="${new Date()}" /></div>
<div><g:hiddenField name="isRead" value="${false}" /></div>

