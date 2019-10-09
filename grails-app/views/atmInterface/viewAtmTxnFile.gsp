


<%@ page import="icbs.tellering.TxnFile" %>
<!DOCTYPE html>


<html>
    <head>

	<meta name="layout" content="main">
	<title>Txn File Details</title>
    </head>
    <body>
        
  		
        <content tag="main-content">   
                        
			<g:each in="${aa}" var="branchInstance">
                           
                           
                         
                      
			<ul class="property-list branch">
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "id")}</span>
                                </li>
				<li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Account No" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "acctNo")}</span>
                                </li>
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Account Status" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "acctStatusId")}</span>
                                </li>  
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Beneficiary id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "beneficiaryId")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Branch id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "branchId")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="CHD:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "chd")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Currency id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "currencyId")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Deposit Account Id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "depAcctId")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Gl Account id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "glAcctId")}</span>
                                </li>   
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Loan Account id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "loanAcctId")}</span>
                                </li>                          
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Sender id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "senderId")}</span>
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
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Code" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnCode")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Date" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnDate")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Description" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnDescription")}</span>
                                 </li>
                                 
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Particulars:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnParticulars")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Ref:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnRef")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Template id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnTemplateId")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Timestamp:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnTimestamp")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Txn Type:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "txnType")}</span>
                                 </li>
                                 <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="User id:" /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: branchInstance, field: "userId")}</span>
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

