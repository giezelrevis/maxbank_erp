<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div id="presentedId${i}" class="presentedId-div">
        <g:if test="${presentedId?.id}">
            <g:hiddenField name='presentedids[${i}].id' value="${presentedId?.id}"/>
            <g:hiddenField name='presentedids[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='presentedids[${i}].new' value="true"/>
        </g:else>
        <g:hiddenField name='presentedids[${i}].deleted' value='false'/>
        
        
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].type', 'has-error')} required">
	<label class="control-label col-sm-4" for="presentedids[${i}].type">
		<g:message code="presentedId.type.label" default="Presented Id Type" />
		<span class="required-indicator">*</span>
	</label>
            <div class="col-sm-8">
                <g:select id="presentedids[${i}].type" name="presentedids[${i}].type.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("CIDT",true)}" optionKey="id" optionValue="itemValue" required="" value="${presentedId?.type?.id}"class="form-control" noSelection="['null': '']"/>
                <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].type">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="presentedids[${i}].type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>    
        
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].idNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="presentedids[${i}].idNo">
                    <g:message code="presentedId.idNo.label" default="Id No" />
                    <span class="required-indicator">*</span>

            </label>
            <div class="col-sm-8">
                <g:textField name="presentedids[${i}].idNo" maxlength="50" value="${presentedId?.idNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].idNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="presentedids[${i}].idNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

     </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].issueDate', 'has-error')} ">
	<label class="control-label col-sm-4"for="presentedids[${i}].issueDate">
		<g:message code="presentedId.issueDate.label" default="Issue Date" />
		
	</label>
	<div class="col-sm-8">
            <g:customDatePicker name="presentedids[${i}].issueDate" precision="day"  value="${presentedId?.issueDate}" default="none" noSelection="['': '']" class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].issueDate">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="presentedids[${i}].issueDate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>

    </div>
 
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].validDate', 'has-error')} ">
	<label class="control-label col-sm-4"for="presentedids[${i}].validDate">
		<g:message code="presentedId.issueDate.label" default="Valid Till Date" />
		
	</label>
	<div class="col-sm-8">
            <g:customDatePicker name="presentedids[${i}].validDate" precision="day"  value="${presentedId?.validDate}" default="none" noSelection="['': '']" class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].validDate">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="presentedids[${i}].validDate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>

    </div>
 

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].isGovtIssue', 'has-error')} ">
	<label class="control-label col-sm-4" for="presentedids[${i}].isGovtIssue">
		<g:message code="presentedId.isGovtIssue.label" default="Is Govt Issue" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="presentedids[${i}].isGovtIssue" value="${presentedId?.isGovtIssue}" />
            <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].isGovtIssue">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="presentedids[${i}].isGovtIssue">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        
        </div>

    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].isWithPhoto', 'has-error')} ">
	<label class="control-label col-sm-4" for="presentedids[${i}].isWithPhoto">
		<g:message code="presentedId.isWithPhoto.label" default="Is With Photo" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="presentedids[${i}].isWithPhoto" value="${presentedId?.isWithPhoto}" />
            <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].isWithPhoto">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="presentedids[${i}].isWithPhoto">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>

    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'presentedids['+i+'].isWithSignature', 'has-error')} ">
	<label class="control-label col-sm-4" for="presentedids[${i}].isWithSignature">
		<g:message code="presentedId.isWithSignature.label" default="Is With Signature" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="presentedids[${i}].isWithSignature" value="${presentedId?.isWithSignature}" />
            <g:hasErrors bean="${customerInstance}" field="presentedids[${i}].isWithSignature">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="presentedids[${i}].isWithSignature">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    <g:if test="${canDelete!="false"}">
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-danger field-btn-delete" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.presentedId-div');"><span class="fa fa-minus" ></span> Remove</button>
        </div>
    </g:if>
   
</div>
