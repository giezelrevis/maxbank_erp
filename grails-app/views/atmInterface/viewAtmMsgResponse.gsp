


<%@ page import="icbs.tellering.TxnFile" %>
<!DOCTYPE html>


<html>
    <head>

	<meta name="layout" content="main">
	<title>ATM Message Response Details</title>
    </head>
    <body>
        
  		
        <content tag="main-content">   
                        
			<g:each in="${AtmMsgResponse}" var="branchInstance">
                           
                           
                         
                      
			<ul class="property-list branch">
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "id")}</span>
                                </li>
				<li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Date Sent" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "dateSent")}</span>
                                </li>
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Destination Ip" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "destinationIp")}</span>
                                </li>  
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Message Content" /></span>
                                    <span class="property-value" aria-labelledby="code-label" style="overflow:scroll;">${fieldValue(bean: branchInstance, field: "msgContent")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Message Length:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "msgLength")}</span>
                                </li> 
                                
                                  </g:each>  
                                  
                                
                        </ul> 
                        
	                             
		</div>
            </content>
           

        <content tag="main-actions">
            <ul>

                    <!--
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    -->
                <li><g:link action="atmTerminalView">View ATM Terminals</g:link></li>
            </ul>
        </content>
    </body>
</html>

