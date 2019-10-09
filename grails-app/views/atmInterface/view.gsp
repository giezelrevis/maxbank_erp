


<!DOCTYPE html>


<html>
    <head>

	<meta name="layout" content="main">
	<title>Atm Txn Details</title>
    </head>
    <body>
        
  		
        <content tag="main-content">   
     
			<g:each in="${atmTxnInstanceList}" status="i" var="branchInstance">
                            
			<ul class="property-list branch">
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "id")}</span>
                                </li>
				<li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Account1:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "acct1")}</span>
                                </li>
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Account2:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "acct2")}</span>
                                </li>  
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Atm Card Number:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "atmCardNumber")}</span>
                                </li>  
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Atm Terminal:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "atmTerminal")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Balance1:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "bal1")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Balance2:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "bal2")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Is Revesed:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "isReversed")}</span>
                                </li>   
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="MTI:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "mti")}</span>
                                </li>                          
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Request Message id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label"></span>
                                     <span class="property-value" aria-labelledby="code-label"> <g:link  class="btn-info" controller="ATMInterface" action="viewAtmMsgRequest" id="${branchInstance.requestMsgId}" params="['atmtxnid': branchInstance.requestMsgId]">View Details</g:link></span>
                                </li>
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Response Date:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "responseDate")}</span>
                                </li> 
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Response Message id:" /></span>
                                    
                                    <span class="property-value" aria-labelledby="code-label"> <g:link  class="btn-info" controller="ATMInterface" action="viewAtmMsgResponse" id="${branchInstance.responseMsgId}" params="['atmtxnid': branchInstance.responseMsgId]">View Details</g:link></span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Reversal Date:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "reversalDate")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Status id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "statusId")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Amt:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnAmt")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Charge Amt:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnChargeAmt")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Code:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnCode")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Date:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnDate")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn File1:" /></span>
                                    <span class="property-value" aria-labelledby="code-label"> <g:link class="btn-info" controller="ATMInterface" action="viewAtmTxnFile" id="${branchInstance.txnFile1}" params="['atmtxnid': branchInstance.txnFile1]">View Details</g:link></span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn File2:" /></span>
                                    <span class="property-value" aria-labelledby="code-label"> <g:link  class="btn-info" controller="ATMInterface" action="viewAtmTxnFile" id="${branchInstance.txnFile2}" params="['atmtxnid': branchInstance.txnFile2]">View Details</g:link></span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Ref:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnRef")}</span>
                                 </li>
                                 
                        </ul> 
                        </g:each>
	                             
		
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

