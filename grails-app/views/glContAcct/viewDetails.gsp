


<%@ page import="icbs.gl.GlContigentAccount" %>
<%@ page import="icbs.admin.UserMaster" %>

<!DOCTYPE html>


<html>
    <head>

	<meta name="layout" content="main">
	<title>Contigent Account Details</title>
        
         <g:javascript>
            function xxxx(){
           
                alertify.confirm(AppTitle,'Are you sure you want to remove this contigent account?',
                    function(){
                                $.ajax({
                                    type: 'POST',
                                    data: {id:$('#idcontigent').val()},
                                    url: "${createLink(controller:'GlContAcct', action:'removeContigentAccountAjax')}",
                                    success: function(){                  
                                        alertify.alert(AppTitle,'sdfsdfsdf').set('message', 'Removed Successfully!').show();
                                        funcDisableProperty();
                                    },
                                    error:function(XMLHttpRequest,textStatus,errorThrown){
                                        alert(XMLHttpRequest+textStatus+errorThrown);
                                    }
                                });
                        },
                    function(){
                        return;
                    });    

                               
                    
            }
            function funcDisableProperty(){

                     document.getElementById("removedbtn").style.display="none"
                     document.getElementById("updatedbtn").style.display="none"
            }
            function submitformfunc(){
                 document.getElementById("myForm").submit();
            }
                                          
            
        </g:javascript>   
    </head>
    <body>

  	<g:each in="${GlContigentAccountList}" var="ContigentAccountInstance">	
        <content tag="main-content">   
                        
			
			<ul class="property-list branch">
                                <g:hiddenField id="idcontigent"  name="id" value="${ContigentAccountInstance.id}" />
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="ID: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "id")}</span>
                                </li>
				<li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Transaction Date: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "txnDate")}</span>
                                </li>
                                <li class="fieldcontain"  >
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Contigent Type: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "contigent")}</span>
                                </li>  
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Credit Amount: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "creditAmt")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Debit Amount: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "debitAmt")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Reference: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "reference")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Particulars: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "particulars")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Status: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${fieldValue(bean: ContigentAccountInstance, field: "status")}</span>
                                </li> 
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Created By: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${ContigentAccountInstance?.createdByUser?.username}</span>
                                </li> 
                                
                                <li class="fieldcontain">
                                    <span id="code-label" class="property-label"><g:message code="atmTerminalInstance.branch.label" default="Branch: " /></span>
                                    <span class="property-value" aria-labelledby="code-label">${ContigentAccountInstance?.branch?.name}</span>
                                </li> 
                                 
                                
                                
                               
                                  
                                
                        </ul> 
                        
	                             
		</div>
            </content>
           

        <content tag="main-actions">
            <ul>

                    <!--
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                    -->
                <li id="updatedbtn"><g:link   contoller="GlContAcct" action="updatecontAcct" params="['id': ContigentAccountInstance.id]">Update</g:link></li>
                   
                <li id="removedbtn"><a href ="#"  onclick="xxxx();" >Remove</a></li>
                <li><g:link action="createcontigent">Create New Contigent Account</g:link></li>
                <li><g:link  contoller="GlContAcct" action="index">Contigent Account List</g:link></li>
            </ul>
        </content>
        </g:each>  
    </body>
</html>

