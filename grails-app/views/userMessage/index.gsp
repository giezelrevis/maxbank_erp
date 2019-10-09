
<%@ page import="icbs.admin.UserMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMessage.label', default: 'UserMessage')}" />
		<title>Inbox</title>
                
                <script>
                    function isToday(x)
                    {
                        console.log(new Date(x).toDateString());
                        var c = new Date(x);
                        console.log(c.toDateString());
                         console.log(c.toLocaleTimeString());
                        var d = new Date();
                        console.log(d.toDateString());
                        console.log(d.toLocaleTimeString());
                        console.log(((d-c)/1000)/60);
            
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
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
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
            <table class="table table-hover table-striped" id="tblinbox">
                <thead>
					
                                         <tr>
					
						<th style="width:20%"><g:message code="userMessage.sender.label" default="Sender" /></th>
					
						<g:sortableColumn property="subject" title="${message(code: 'userMessage.subject.label', default: 'Subject')}" />
					
						<g:sortableColumn property="body" title="${message(code: 'userMessage.body.label', default: 'Body')}" />
					
						<g:sortableColumn property="sentAt" title="${message(code: 'userMessage.sentAt.label', default: 'Sent At')}" />
					
					</tr>
                                        
                                      
				</thead>
				<tbody>
				<g:each in="${userMessageInstanceList}" status="i" var="userMessageInstance">
                                    <g:if test="${userMessageInstance.configItemStatusId==2}">
					<tr>
                                               
                                            <!-- td width="2%"  style="display:none"><input type="checkbox" name="checkbox" id="checkbox"></td -->
                                            <td width="20%">${fieldValue(bean: userMessageInstance, field: "sender.name")}</td>
                                            <g:if test="${userMessageInstance.isRead == true}" >
                                                <td width="20%"><g:link action="show" id="${userMessageInstance.id}">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></td>
                                            </g:if>
                                            <g:else>
                                                <td width="20%"><strong><g:link action="show" id="${userMessageInstance.id}" class="bold">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></strong></td>
                                            </g:else>
                                            <td width="43%"><input readonly style="border-style:none;background: transparent;width: 90%" type="text" value="${fieldValue(bean: userMessageInstance, field: 'body')}">&nbsp;...
                                            </td>
                                            <td width="25%"><script>isToday('${fieldValue(bean: userMessageInstance, field: "sentAt")}');</script></td>
                                                
                                                
                                        <%--
                                                <td>
                                                    <div class="col-md-10">
                                                    <h5>${fieldValue(bean: userMessageInstance, field: "sender.name")}</h5>
                                                    <g:if test="${userMessageInstance.isRead == true}" >
							<g:link action="show" id="${userMessageInstance.id}">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link>
                                                    </g:if>
                                                    <g:else>
                                                        <strong><g:link action="show" id="${userMessageInstance.id}" class="bold">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></strong>
                                                    </g:else>
                                                    - <span style="color:gray">${fieldValue(bean: userMessageInstance, field: "body")}</span>
                                                    </div>
                                                    <div class="col-md-2">
                                                       ${fieldValue(bean: userMessageInstance, field: "sentAt")} 
                                                        
                                                    </div>
                                      
                                                        
                                                </td>
                                                <td style="width:10%">
                                                     ${fieldValue(bean: userMessageInstance, field: "sentAt")}
                                                     <script>
                                                         isToday('${fieldValue(bean: userMessageInstance, field: "sentAt")}');
                                                     </script>
                                                </td>
                                           --%>
					
					</tr>
                                    </g:if>
				</g:each>
				</tbody>
			</table>
                         <script>
                            $(document).ready(function() {
                                $('#tblinbox').DataTable();
                            } );
                        </script>
                    
                     <%-- /div --%>
			<%-- div class="pagination">
				<g:paginate total="${UserMessageInstanceCount ?: 0}" params="${params}" />
			</div --%>
		</div>
            </content>
          
            <content tag="main-actions">
                <ul>
                    <li><g:link action="create">New Message</g:link></li>
                    
                    <li><g:link action="outbox">Outbox</g:link></li>
				</ul>
            </content>
         
	</body>
</html>
