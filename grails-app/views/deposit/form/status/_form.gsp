<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
            <g:hiddenField name="origStatus" value="${depositInstance.status.id}" />
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'status', 'has-error')} ">
                <label class="control-label col-sm-4" for="depositInstance">
                        <g:message code="deposit.status.label" default="Status" />

                </label>
                <div class="col-sm-8">
                    <g:select id="status" name="status.id" from="${icbs.lov.DepositStatus.findAllByStatusAndDescriptionNotEqual(true,'Closed')}" optionKey="id" optionValue="description" value="${depositInstance?.status?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                    <g:hasErrors bean="${depositInstance}" field="status">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="status">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
