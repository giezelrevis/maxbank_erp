

<!DOCTYPE html>
<html>
    <head>
    	<meta name="layout" content="main">
	<title>Approve Batch</title>
    </head>
    <body>
   
        <content tag="main-content">   
            <ol class="property-list glBatchHdrInstance">
            <g:if test="${flash.message}">
                <script>
                    $(function(){
                        var x = '${flash.message}';
                            console.log('log: '+x);
                            notify.message(x);      

                    });
                </script>    
            </g:if> 
                <li class="fieldcontain">
                    <span id="type-label" class="property-label"><g:message code="glBatchHdrInstance.batchId.label" default="Batch ID" /></span>			
                    <span class="property-value" aria-labelledby="batchId-label"><g:fieldValue bean="${glBatchHdrInstance}" field="batchId"/></span>			
		</li>
                <li class="fieldcontain">
                    <span id="type-label" class="property-label"><g:message code="glBatchHdrInstance.batchName.label" default="Batch Name" /></span>			
                    <span class="property-value" aria-labelledby="batchName-label"><g:fieldValue bean="${glBatchHdrInstance}" field="batchName"/></span>			
		</li>         
                <li class="fieldcontain">
                    <span id="type-label" class="property-label"><g:message code="glBatchHdrInstance.valueDate.label" default="Batch Name" /></span>			
                    <span class="property-value" aria-labelledby="batchName-label"><g:formatDate  format="MM/dd/yyyy" date="${glBatchHdrInstance?.valueDate}" /></span>			
		</li> 
            </od>    
            <table class="table table-hover table-condensed table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Line</th>
                        <th>Debit</th>
                        <th>Credit</th>
                        <th>Debit Amount</th>
                        <th>Credit Amount</th>
                        <th>Reference</th>
                        <th>Particulars</th>
                        <th>Line Status</th>
                    </tr>
                </thead>                
                <tbody>
                    <g:set var="batchOk" value="${0}" />  
                    <g:each in="${glBatchInstance}" status="i" var="glBatch">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>${glBatch.lineNo}</td>
                            <g:if test="${glBatch.debit != 0}">
                                <td>${glBatch.debitAccount}</td>
                            </g:if>
                            <g:else>
                                <td></td>
                            </g:else>    
                            <g:if test="${glBatch.credit != 0}">
                                <td>${glBatch.creditAccount}</td>
                            </g:if>
                            <g:else>
                                <td></td>
                            </g:else>  
                            <g:if test="${glBatch.debit != 0}">
                                <td><DIV ALIGN=right> <g:formatNumber format="###,###,##0.00" number="${glBatch?.debit}"/></td>
                            </g:if>
                            <g:else>
                                <td></td>
                            </g:else>  
                            <g:if test="${glBatch.credit != 0}">
                                <td><DIV ALIGN=right> <g:formatNumber format="###,###,##0.00" number="${glBatch?.credit}"/></td>
                            </g:if>
                            <g:else>
                                <td></td>
                            </g:else>     
                            <td>${glBatch.reference}</td> 
                            <td>${glBatch.particulars}</td> 
                            <td>
                                <g:if test="${glBatch.lineStatus}">
                                    <label style="color: red;"> 
                                        <g:set var="batchOk" value="${1}" /> 
                                        ${glBatch.lineStatus}
                                    </label>
                                </g:if>
                                <g:else>
                                    OK
                                </g:else>    
                            </td>   
                        </tr>
                    </g:each>
                </tbody>
                
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="btn btn-primary btn-xs" action="edit" id="${glBatchHdrInstance.id}"> Edit </g:link></li>
                <li><g:link class="btn btn-primary btn-xs" target="_blank" action="printGlBatch" id="${glBatchHdrInstance.id}"> Print </g:link></li>
                <g:if test="${batchOk==0}">
                    <li><g:link class="btn btn-primary btn-xs" target="_blank" action="glBatchApproval" id="${glBatchHdrInstance.id}">Print GL Batch Approval</g:link></li>
                </g:if>
                <li><g:link class="btn btn-primary btn-xs" action="index"> GL Batch List</g:link></li>
            </ul>    
        </content>
    </body>
</html>
