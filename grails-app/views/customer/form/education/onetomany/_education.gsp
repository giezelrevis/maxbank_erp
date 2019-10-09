<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
    
<div id="education${i}" class="education-div" class="multi-field">
        <g:if test="${education?.id}">
            <g:hiddenField name='educations[${i}].id' value="${education?.id}"/>
            <g:hiddenField name='educations[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='educations[${i}].new' value="true"/>
        </g:else>
        <g:hiddenField name='educations[${i}].deleted' value='false'/>
        

        <g:if test="${choice=='0'}">
            <g:hiddenField name="educations[${i}].type" value="1"/>
        </g:if>
        <g:if test="${choice=='1'}">
            <g:hiddenField name="educations[${i}].type" value="2"/>
        </g:if>
        <g:if test="${choice=='2'}">
            <g:hiddenField name="educations[${i}].type" value="3"/>
        </g:if>
        <g:if test="${choice=='3'}">
            <g:hiddenField name="educations[${i}].type" value="4" />
        </g:if>
        <g:if test="${choice=='4'}">
            <g:hiddenField name="educations[${i}].type" value="5"/>
        </g:if>
	
        
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'educations['+i+'].schoolAttended', 'has-error')} ">
            <label class="control-label col-sm-4" for="educations[${i}].schoolAttended">
                    <g:message code="education.schoolAttended.label" default="School Attended" />

            </label>
            <div class="col-sm-8">
                <g:textField name="educations[${i}].schoolAttended" maxlength="50" value="${education?.schoolAttended}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="educations[${i}].schoolAttended">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="educations[${i}].schoolAttended">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <g:if test="${!(choice=='0'||choice=='1')}">
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field:  'educations['+i+'].educationDegree', 'has-error')} ">
                <label class="control-label col-sm-4" for="educations[${i}].educationDegree">
                        <g:message code="education.educationDegree.label" default="Education Degree" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="educations[${i}].educationDegree" maxlength="50" value="${education?.educationDegree}"class="form-control"/><
                    <g:hasErrors bean="${customerInstance}" field="educations[${i}].educationDegree">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="educations[${i}].educationDegree">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
        </g:if>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'educations['+i+'].yearStart', 'has-error')} ">
            <label class="control-label col-sm-4" for="educations[${i}].yearStart">
                    <g:message code="education.yearStart.label" default="Year Start" />

            </label>
            <div class="col-sm-8">
                <g:textField name="educations[${i}].yearStart" maxlength="4" value="${education?.yearStart}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="educations[${i}].yearStart">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="educations[${i}].yearStart">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            
            </div>
        </div>
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'educations['+i+'].yearEnd', 'has-error')} ">
            <label class="control-label col-sm-4" for="educations[${i}].yearEnd">
                    <g:message code="education.yearStart.label" default="Year End" />

            </label>
            <div class="col-sm-8">
                <g:textField name="educations[${i}].yearEnd" maxlength="4" value="${education?.yearEnd}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="educations[${i}].yearEnd">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="educations[${i}].yearEnd">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        <g:if test="${canDelete!="false"}">
            <div class="form-group form-buttons">
                <button type="button" class="btn btn-danger field-btn-delete" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.education-div');"><span class="fa fa-minus" ></span> Remove</button>
            </div>
        </g:if>
    </div> 