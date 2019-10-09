
<%@ page import="icbs.admin.UserMessage" %>
<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMessage.label', default: 'UserMessage')}" />
		<title>Message Information</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="show-userMessage" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<script>
                            $(function(){
                            var x = "${flash.message}";
                            notify.message(x);
                            });
                        </script>
			</g:if>
			<ul class="property-list userMessage">
			
				<g:if test="${userMessageInstance?.sender}">
				<li class="fieldcontain">
					<span id="sender-label" class="property-label"><g:message code="userMessage.sender.label" default="Sender" /></span>
					
						<span class="property-value" aria-labelledby="sender-label">${userMessageInstance?.sender?.name1} ${userMessageInstance?.sender?.name2}</span>
					
				</li>
				</g:if>
			
				<g:if test="${userMessageInstance?.recipient}">
				<li class="fieldcontain">
					<span id="recipient-label" class="property-label"><g:message code="userMessage.recipient.label" default="Recipient" /></span>
					
						<span class="property-value" aria-labelledby="recipient-label">${userMessageInstance?.recipient?.name1} ${userMessageInstance?.recipient?.name2}</span>
					
				</li>
				</g:if>
			
				<g:if test="${userMessageInstance?.subject}">
				<li class="fieldcontain">
					<span id="subject-label" class="property-label"><g:message code="userMessage.subject.label" default="Subject" /></span>
					
						<span class="property-value" aria-labelledby="subject-label"><g:fieldValue bean="${userMessageInstance}" field="subject"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${userMessageInstance?.body}">
				<li class="fieldcontain">
					<span id="body-label" class="property-label"><g:message code="userMessage.body.label" default="Body" /></span>
                                        <hr />
                                        <div id="msgdisp"></div>
                                        <hr />
                                        <!-- 
					<textarea class="textarea" cols="80" rows="10"  disabled="" style="border:none; background-color:transparent" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;">${userMessageInstance?.body}</textarea>
                                        --> 
                                        <script>
                                            function decodeHTMLEntities(text) {
                                                var entities = [
                                                    ['apos', '\''],
                                                    ['amp', '&'],
                                                    ['lt', '<'],
                                                    ['gt', '>']
                                                ];

                                                for (var i = 0, max = entities.length; i < max; ++i) 
                                                    text = text.replace(new RegExp('&'+entities[i][0]+';', 'g'), entities[i][1]);

                                                return text;
                                            }
                                            function htmlencode(str) {
                                                    return str.replace(/[&<>"']/g, function($0) {
                                                        return "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";";
                                                    });
                                                }


                                            $(function(){
                                                document.getElementById('msgdisp').innerHTML = decodeHTMLEntities('${userMessageInstance?.body}');
                                                //var txtarea = $('.textarea');
                                                txtarea.wysihtml5({
                                                    "readonly": true,
                                                    "font-styles": false, //Font styling, e.g. h1, h2, etc. Default true
                                                    "emphasis": false, //Italics, bold, etc. Default true
                                                    "lists": false, //(Un)ordered lists, e.g. Bullets, Numbers. Default true
                                                    "html": false, //Button which allows you to edit the generated HTML. Default false
                                                    "link": false, //Button to insert a link. Default true
                                                    "image": false, //Button to insert an image. Default true,
                                                    "color": false //Button to change color of font  
                                                });
                                                txtarea.composer.element.setAttribute('contenteditable', false);
                                                txtarea.toolbar.commandsDisabled = true;
                                                
                                            });
                                        </script>
					
				</li>
				</g:if>
			
				<g:if test="${userMessageInstance?.sentAt}">
				<li class="fieldcontain">
					<span id="sentAt-label" class="property-label"><g:message code="userMessage.sentAt.label" default="Sent At" /></span>
					
						<span class="property-value" aria-labelledby="sentAt-label"><g:fieldValue bean="${userMessageInstance}" field="sentAt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userMessageInstance?.parentMessage}">
				<li class="fieldcontain">
					<span id="parentMessage-label" class="property-label"><g:message code="userMessage.parentMessage.label" default="Parent Message" /></span>
					
						<span class="property-value" aria-labelledby="parentMessage-label"><g:link controller="userMessage" action="show" id="${userMessageInstance?.parentMessage?.id}">${userMessageInstance?.parentMessage?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${userMessageInstance?.configItemStatus}">
				<li class="fieldcontain">
					<span id="configItemStatus-label" class="property-label"><g:message code="userMessage.configItemStatus.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="configItemStatus-label">${userMessageInstance?.configItemStatus?.description}</span>
					
				</li>
				</g:if>
			
			</ul>
			<g:form id="show" url="[resource:userMessageInstance, action:'delete']" method="DELETE">
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                	<g:if test="${userMessageInstance?.recipient == UserMaster.get(session.user_id)}">
                		<li><g:link action="reply" id="${userMessageInstance.id}">Reply</g:link></li>
                	</g:if>	
                    <li><g:link class="create" action="create">New Message</g:link></li>
                    <li><g:actionSubmit form="show" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></li>
				</ul>
            </content>
            
         
        
        
	</body>
        
         
     
        
</html>
