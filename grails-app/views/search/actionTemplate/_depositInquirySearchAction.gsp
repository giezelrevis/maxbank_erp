<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<td>
    <g:if test="${depositInstance.status.description == 'Closed' && params.module != 'memo'}">
        <g:link class="btn btn-secondary" controller="deposit" action="depositInquiry"  params="[module:'close']" class="btn btn-secondary" id="${depositInstance?.id}"  
                                    onclick="return confirm('Are you sure you want to query this Deposit Account?');">View </g:link>
   
    </g:if>
    <g:else>
        <g:link class="btn btn-secondary" controller="deposit" action="depositInquiry" params="${params}" class="btn btn-secondary" id="${depositInstance?.id}"  
                                    onclick="return confirm('Are you sure you want to query this Deposit Account?');">View </g:link>
   
    </g:else>

    
   
    
    </td>