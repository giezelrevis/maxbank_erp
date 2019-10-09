<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<h3>Customer Extended Information</h3>
    <g:each var="code" in="${icbs.cif.Code.list()}" status="i">
       <g:if test="${code.status?.id==2}">
            <g:hiddenField id="extendedinfos[${i}].code" name="extendedinfos[${i}].code.id" value="${code?.id}"/>
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'extendedinfos['+i+'].value', 'has-error')} ">
                <label class="control-label col-sm-4" for="extendedinfos[${i}].value">
                        ${code?.value}
                        <span class="required-indicator">*</span>
                </label>
                 <div class="col-sm-8">
                     <g:textField name="extendedinfos[${i}].value"value="${customerInstance?.extendedinfos[i]?.value}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="extendedinfos[${i}].value">
                         <div class="controls">
                             <span class="help-block">
                                 <g:eachError bean="${customerInstance}" field="extendedinfos[${i}].value">
                                     <g:message error="${it}" /><br/>
                                 </g:eachError>
                             </span>
                         </div>
                     </g:hasErrors> 
                 </div>
            </div>
        </g:if>
    </g:each>

