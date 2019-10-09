
<%@ page import="icbs.admin.UserMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMessage.label', default: 'UserMessage')}" />
		<title>Outbox</title>
                
                 <script>
                    function isToday(x)
                    {
                       // console.log(new Date(x).toDateString());
                        var c = new Date(x);
                       // console.log(c.toDateString());
                        var d = new Date();
                      //  console.log(c.toLocaleTimeString());
                        
            
                        var bool = (d.toDateString() === c.toDateString());
                        if(bool)
                        {
                            var lapse = ((d-c)/1000)/60;
                            if(lapse>60)
                            {
                                document.write("<small>"+Math.floor(lapse/60,2)+" hour(s) ago..</small>");
                            } else {
                                document.write("<small>"+Math.floor((((d-c)/1000)/60),2)+" minute(s) ago..</small>");
                            }
                           // console.log('today');
                           // console.log(Math.floor(((((d-c)/1000)/60)/60),2));
                             //document.write("<small>"+Math.floor((((d-c)/1000)/60),2)+" minute(s) ago..</small>");
                        } else 
                        {
                            document.write("<small>"+c.toDateString()+"</small>");
                           // console.log('not today');
                        }
                    }
                </script>
                
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-userMessage" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                       
                        <%--
			<g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>
                        --%>

		<%-- div class="table-responsive" --%>
                    <table class="table table-striped table-bordered table-hover table-responsive" id="tbloutbox">
                    <thead>

                                            <tr>

                                                    <th><g:message code="userMessage.recipient.label" default="Recipient" /></th>

                                                    <g:sortableColumn property="subject" title="${message(code: 'userMessage.subject.label', default: 'Subject')}" />

                                                    <g:sortableColumn property="body" title="${message(code: 'userMessage.body.label', default: 'Body')}" />

                                                    <g:sortableColumn property="sentAt" title="${message(code: 'userMessage.sentAt.label', default: 'Sent At')}" />

                                            </tr>

                                    </thead>
                                    <tbody>
                                    <g:each in="${userMessageInstanceList}" status="i" var="userMessageInstance">
                                         <g:if test="${userMessageInstance.configItemStatusId==2}">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <%--
                                                    <td>${fieldValue(bean: userMessageInstance, field: "recipient.name")}</td>

                                                    <td><g:link action="show" id="${userMessageInstance.id}">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></td>

                                                    <td>${fieldValue(bean: userMessageInstance, field: "body")}</td>

                                                    <td>${fieldValue(bean: userMessageInstance, field: "sentAt")}</td>
                                                 --%>  

                                                <td width="20%">${fieldValue(bean: userMessageInstance, field: "recipient.name")}</td>
                                                <g:if test="${userMessageInstance.isRead == true}" >
                                                    <td width="20%"><g:link action="show" id="${userMessageInstance.id}">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></td>
                                                </g:if>
                                                <g:else>
                                                    <td width="20%"><strong><g:link action="show" id="${userMessageInstance.id}" class="bold">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></strong></td>
                                                </g:else>
                                                <td width="43%"><input readonly style="border-style:none;background: transparent;width: 90%" type="text" value="${fieldValue(bean: userMessageInstance, field: 'body')}">&nbsp;...
                                                </td>
                                                <td width="25%"><script>isToday('${fieldValue(bean: userMessageInstance, field: "sentAt")}');</script></td>



                                            </tr>
                                        </g:if>
                                    </g:each>
                                    </tbody>
                    </table>
                    <script>
                        $(document).ready(function() {
                            $('#tbloutbox').DataTable();
                        } );
                    </script>
                <%-- /div --%>
			<!-- div class="pagination">
				<g:paginate total="${UserMessageInstanceCount ?: 0}" params="${params}" />
			</div -->
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link action="create">New Message</g:link></li>
                    <li><g:link action="index">Inbox</g:link></li>
				</ul>
            </content>
	</body>
</html>
