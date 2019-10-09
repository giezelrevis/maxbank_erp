<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<tr id="signatory${i}" class="signatory-div">
        <g:if test="${signatory?.id}">
            <g:hiddenField name="signatories[${i}].id" value="${signatory?.id}"/>
            <g:hiddenField name="signatories[${i}].new" value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name="signatories[${i}].new" value="true"/>
        </g:else>
        <g:hiddenField name="signatories[${i}].deleted" value='false'/>
        <g:hiddenField name="signatories[${i}].signatory.id" id="signatories[${i}].signatory" value="${signatory?.signatory?.id}"/>
        <td>
            ${signatory?.signatory?.id}
        </td>
        <td>
            ${signatory?.signatory?.displayName}
        </td>
        <td>
            <div class="form-group fieldcontain ${hasErrors(bean: signatory, field: 'type', 'has-error')} ">
                 <div class="col-sm-8">
                    <g:if test="${!displayOnly}">
                        <g:select id="signatories[${i}].type" name="signatories[${i}].type.id" from="${icbs.lov.SignatoryType.list()}" optionKey="id" optionValue ="description" value="${signatory?.type?.id}" class="form-control" />
                        <g:hasErrors bean="${signatory}" field="signatories[${i}].type">
                            <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${signatory}" field="signatories[${i}].type">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                            </div>
                         </g:hasErrors> 
                    </g:if>
                    <g:else>
                        ${signatory?.type?.description}
                    </g:else>
                 </div>
            </div>
        </td>
        <td>
            <g:if test="${(signatory?.signatory?.attachments?.find{it.isPrimarySig==true})?.id}"> <img onclick="yay();" width="50px" height="50px"src="${createLink(controller:'Attachment', action:'show', id: (signatory?.signatory?.attachments?.find{it.isPrimarySig==true})?.id )}"/></g:if>
        </td>   
        <g:if test="${!displayOnly}">
            <td>
                <span class="del-attachment"onClick="bindSignatoryDelete(this);">
                    <img src="${resource(dir:'images/skin', file:'database_delete.png')}" style="vertical-align: middle"/>
                </span>
            </td>
        </g:if>
</tr>
