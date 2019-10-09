<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<!DOCTYPE html>
<div id="updateDepositStatusDiv">        
            <g:form name ="depositUpdateStatusForm" action="updateDepositStatus">
                
                <g:hiddenField name="deposit" value="${depositInstance?.id}"/>
                <g:if test="${depositInstance?.status?.id!=7}">
                    <g:hiddenField id="status" name="status.id" value="7"/>
                </g:if>
                <g:else>
                    <g:hiddenField id="status" name="status.id" value="3"/>
                </g:else>
            </g:form>  
</div>
    
    
    