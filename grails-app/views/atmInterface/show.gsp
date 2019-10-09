

<!DOCTYPE html>
<html>
	<head>
            <meta name="layout" content="main">
            <title>ATM Terminal Information</title>
	</head>
	<body>
            <content tag="main-content">
                <div id="show-currency" class="content scaffold-show" role="main">
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <ul class="property-list atmTerminal">
                        <g:if test="${atmTerminalInstance?.terminalCode}">
                            <li class="fieldcontain">
                                <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.terminalCode.label" default="ATM Terminal Code" /></span>
                                <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${atmTerminalInstance}" field="terminalCode"/></span>
                            </li>
                        </g:if>
                        <g:if test="${atmTerminalInstance?.remarks}">
                            <li class="fieldcontain">
                                <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.remarks.label" default="Remarks" /></span>
                                <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${atmTerminalInstance}" field="remarks"/></span>
                            </li>
                        </g:if>
                        <g:if test="${atmTerminalInstance?.branch}">
                            <li class="fieldcontain">
                                <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Assigned Branch" /></span>
                                <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${atmTerminalInstance}" field="branch.name"/></span>
                            </li>
                        </g:if>  
                        <g:if test="${atmTerminalInstance?.terminalStatus}">
                            <li class="fieldcontain">
                                <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.terminalStatus.label" default="Terminal Status" /></span>
                                <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${atmTerminalInstance}" field="terminalStatus.description"/></span>
                            </li>
                        </g:if>  
                    </ul>
                </div>
            </content>	

            <content tag="main-actions">
                <ul>
                <li><g:link action="edit" controller="ATMInterface" id="${atmTerminalInstance.id}" >Edit</g:link></li>
                <li><g:link action="detailView" id="${atmTerminalInstance.id}" >Delete/Disable</g:link></li>
                <li><g:link action="atmTerminalView" >List</g:link></li>
            </ul>
            </content>

	</body>
</html>
