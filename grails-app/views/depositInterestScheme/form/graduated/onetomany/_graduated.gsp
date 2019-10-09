<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="graduated${i}" class="graduated-div">
        <g:if test="${graduated?.id}">
            <g:hiddenField name='graduateds[${i}].id' value="${graduated?.id}"/>
            <g:hiddenField name='graduateds[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='graduateds[${i}].new' value="true"/>
        </g:else>
        <g:hiddenField name='graduateds[${i}].deleted' value='false'/>
        
        
    <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'graduateds['+i+'].startBal', 'has-error')} required">
            <label class="control-label col-sm-4" for="graduateds[${i}].startBal">
                    <g:message code="depositInterestSchemeGraduated.startBal.label" default="Start Bal" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:field name="graduateds[${i}].startBal" value="${graduated?.startBal}" class="form-control"/>

                <g:hasErrors bean="${depositInterestSchemeInstance}" field="graduateds[${i}].startBal">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInterestSchemeInstance}" field="graduateds[${i}].startBal">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'graduateds['+i+'].endBal', 'has-error')} required">
            <label class="control-label col-sm-4" for="graduateds[${i}].endBal">
                    <g:message code="depositInterestSchemeGraduated.startBal.label" default="End Bal" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:field name="graduateds[${i}].endBal" value="${graduated?.endBal}"class="form-control"/>

                <g:hasErrors bean="${depositInterestSchemeInstance}" field="graduateds[${i}].endBal">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInterestSchemeInstance}" field="graduateds[${i}].endBal">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInterestSchemeInstance, field: 'graduateds['+i+'].interestRate', 'has-error')} required">
            <label class="control-label col-sm-4" for="graduateds[${i}].interestRate">
                    <g:message code="depositInterestSchemeGraduated.interestRate.label" default="Interest Rate" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:field name="graduateds[${i}].interestRate" value="${graduated?.interestRate}"class="form-control"/>

                <g:hasErrors bean="${depositInterestSchemeInstance}" field="graduateds[${i}].interestRate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInterestSchemeInstance}" field="graduateds[${i}].interestRate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <g:if test="${canDelete!="false"}">
            <div class="form-group form-buttons">
                <button type="button" class="btn btn-danger field-btn-delete" onClick="bindGraduatedDelete(this)"><span class="fa fa-minus" ></span> Remove</button>
            </div>
    </g:if>
</div>
    