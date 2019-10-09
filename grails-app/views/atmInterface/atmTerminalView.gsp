

<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>ATM Terminals View</title>
    </head>
    <body>
        <content tag="main-content">   
            <div id="list-atmReq" class="content scaffold-list" role="main">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
                
		<div class="table-responsive">
                    <table class="table table-bordered table-rounded table-striped table-hover">
                        <thead>
                            <tr>					
                                <g:sortableColumn property="terminalCode" title="${message(code: 'branch.code.label', default: 'Code')}" defaultOrder="asc"/>	
                                <g:sortableColumn property="branch" title="${message(code: 'branch.code.label', default: 'Branch')}" defaultOrder="asc" />
                                <th>Remarks</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${atmTerminal}" status="i" var="atmTerminalInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>${fieldValue(bean: atmTerminalInstance, field: "terminalCode")}</td>
                                    <td>${fieldValue(bean: atmTerminalInstance, field: "branch.name")}</td>
                                    <td>${fieldValue(bean: atmTerminalInstance, field: "remarks")}</td>
                                    <td>${fieldValue(bean: atmTerminalInstance, field: "terminalStatus.description")}</td>
                                    <td>
                                        <g:if test="${atmTerminalInstance.terminalStatus.id == 2}">
                                            <g:link class="btn btn-secondary" action="editTerminal" id="${atmTerminalInstance.id}">Edit</g:link>
                                            <g:link class="btn btn-secondary" action="deleteTerminal" id="${atmTerminalInstance.id}">Delete</g:link>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                    <!--
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    -->
                <li><g:link action="viewAtmInterface">View ATM Interface</g:link></li>
                <li><g:link action="createAtmTerminal">Create ATM Terminal</g:link></li>
            </ul>
        </content>
    </body>
</html>
