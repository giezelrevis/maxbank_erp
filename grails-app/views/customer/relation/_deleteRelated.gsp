<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
        
            <g:if test="${flash.message}">
                <div id= "addCustomerRelatedMessage" class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <g:if test="${!saved}">
            <g:hasErrors bean="${relationInstance}">
                <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                                            
                            </div>
                            <g:eachError bean="${relationInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            </g:if>
            <g:form name="customerDeleteRelatedForm" id="customerDeleteRelatedForm">
                <g:render template='relation/deleteformRelated' model='[relationInstance:relationInstance,disabled:'disabled',customerRelationshipType:customerRelationshipType]'/>
            </g:form>
            
            