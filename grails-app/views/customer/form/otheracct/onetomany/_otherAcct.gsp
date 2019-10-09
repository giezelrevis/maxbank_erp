<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="otherAcct${i}" class="otherAcct-div">
        <g:if test="${otherAcct?.id}">
            <g:hiddenField name='otheraccts[${i}].id' value="${otherAcct?.id}"/>
            <g:hiddenField name='otheraccts[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='otheraccts[${i}].new' value="true"/>
        </g:else>
        <g:hiddenField name='otheraccts[${i}].deleted' value='false'/>
        
        
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'otheraccts['+i+'].type', 'has-error')}">
            <label class="control-label col-sm-4"for="otheraccts[${i}].type">
                    <g:message code="otherAcct.type.label" default="Other Acct Type Id" />

            </label>
            <div class="col-sm-8">
                <g:select id="otheraccts[${i}].type" name="otheraccts[${i}].type.id" from="${icbs.lov.OtherAcctType.list()}" optionValue="description" optionKey="id" value="${otherAcct?.type?.id}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="otheraccts[${i}].type">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="otheraccts[${i}].type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'otheraccts['+i+'].bankName', 'has-error')} ">
            <label class="control-label col-sm-4"for="otheraccts[${i}].bankName">
                    <g:message code="otherAcct.bankName.label" default="Bank Name" />

            </label>
            <div class="col-sm-8">
                <g:textField name="otheraccts[${i}].bankName" maxlength="50" value="${otherAcct?.bankName}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="otheraccts[${i}].bankName">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="otheraccts[${i}].bankName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'otheraccts['+i+'].branchName', 'has-error')} ">
            <label class="control-label col-sm-4"for="otheraccts[${i}].branchName">
                    <g:message code="otherAcct.branchName.label" default="Branch Name" />

            </label>
            <div class="col-sm-8">
                <g:textField name="otheraccts[${i}].branchName" maxlength="50" value="${otherAcct?.branchName}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="otheraccts[${i}].branchName">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="otheraccts[${i}].branchName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'otheraccts['+i+'].acctNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="otheraccts[${i}].acctNo">
                    <g:message code="otherAcct.acctNo.label" default="Acct No" />

            </label>
            <div class="col-sm-8">
                <g:textField name="otheraccts[${i}].acctNo" maxlength="30" value="${otherAcct?.acctNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="otheraccts[${i}].acctNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="otheraccts[${i}].acctNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'otheraccts['+i+'].isOtherAcctJoint', 'has-error')} ">
            <label class="control-label col-sm-4"for="otheraccts[${i}].isOtherAcctJoint">
                    <g:message code="otherAcct.isOtherAcctJoint.label" default="Is Other Acct Joint" />

            </label>
            <div class="col-sm-8">
                <g:checkBox name="otheraccts[${i}].isOtherAcctJoint" value="${otherAcct?.isOtherAcctJoint}"/>
                <g:hasErrors bean="${customerInstance}" field="otheraccts[${i}].isOtherAcctJoint">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="otheraccts[${i}].isOtherAcctJoint">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>
    <g:if test="${canDelete!="false"}">
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-danger field-btn-delete" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.otherAcct-div');"><span class="fa fa-minus" ></span> Remove</button>
        </div>
    </g:if>
    
</div>