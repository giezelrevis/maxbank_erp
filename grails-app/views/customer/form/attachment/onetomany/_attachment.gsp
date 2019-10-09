<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>


<div id="attachment${i}" class="attachment-div">
        <g:if test="${attachment?.id}">
            <g:hiddenField name='attachments[${i}].id' value="${attachment?.id}"/>
            <g:hiddenField name='attachments[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='attachments[${i}].new' value="true"/>
        </g:else>
        
        <g:hiddenField name='attachments[${i}].deleted' value='false'/>
        
        <g:if test="${attachment?.fileName!=null}">
            <div class=" form-group fieldcontain ${hasErrors(bean: attachmentInstance, field: 'attachments['+i+'].fileName', 'has-error')} required">
                <label class="control-label col-sm-4" for="fileName">
                        <g:message code="attachment.fileName.label" default="File Name" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <g:if test="${attachment?.id!=null}">
                            <g:field  disabled="true" id="attachments[${i}].fileName" name="attachments[${i}].fileName" value="${attachment?.fileName}" class="form-control"/>
                        
                            <span class="input-group-btn">
                                        <button type="button" class="btn btn-default 
                                           dropdown-toggle" data-toggle="dropdown">
                                           Action
                                           <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                           <li> <a target="_blank"href="${createLink(controller:'Attachment', action:'show', id: attachment?.id)}">View</a></li>
                                           <li> <a target="_blank"href="${createLink(controller:'Attachment', action:'download', id: attachment?.id)}">Download</a></li>
                                        </ul>
                            </span>
                        </g:if>
                        <g:hasErrors bean="${customerInstance}" field="attachments[${i}].fileName">
                            <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${customerInstance}" field="attachments[${i}].fileName">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                            </div>
                        </g:hasErrors> 
                    </div>
                </div>
            </div>
        </g:if>
        <g:if test="${!type}">
            <div class=" form-group fieldcontain ${hasErrors(bean: attachmentInstance, field: 'attachments['+i+'].type', 'has-error')} required">
                <label class="control-label col-sm-4" for="type">
                        <g:message code="attachment.type.label" default="Attachment Type" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <g:select id="attachments[${i}].type" name="attachments[${i}].type.id" from="${icbs.lov.AttachmentType.findAllByCodeInList(['030','040','050'])}" optionKey="id" optionValue="description" required="" value="${attachment?.type?.id}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="attachments[${i}].type">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="attachments[${i}].type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors> 
                </div>
            </div>
        </g:if>
        <g:else>
            <g:hiddenField  id="attachments[${i}].type" name="attachments[${i}].type.id"  value="${type}"/>
        </g:else>
        <g:if test="${isPrimaryPhoto}">
            <g:hiddenField id="attachments[${i}].isPrimaryPhoto" name="attachments[${i}].isPrimaryPhoto" value="${isPrimaryPhoto}"/>
        </g:if>
        <g:if test="${isPrimarySig}">
            <g:hiddenField id="attachments[${i}].isPrimarySig" name="attachments[${i}].isPrimarySig" value="${isPrimarySig}"/>
        </g:if>
        <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'attachments['+i+'].fileData', 'has-error')} ">
                <label class="control-label col-sm-4" for="attachments[${i}].fileData">
                        <g:message code="attachment.fileData.label" default="Others File" />
                </label>
                <div class="col-sm-8">
                    <input type="file" id="attachments[${i}].fileData" name="attachments[${i}].fileData"class="form-control" />
                    <g:hasErrors bean="${customerInstance}" field="attachments[${i}].fileData">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="attachments[${i}].fileData">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                  </g:hasErrors>
                </div>
               
        </div>
        <g:if test="${canDelete!="false"}">
            <div class="form-group form-buttons">
                <button type="button" class="btn btn-danger field-btn-delete" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.attachment-div');"><span class="fa fa-minus" ></span> Remove</button>
            </div>
        </g:if>
        </br>
        </br>
</div>