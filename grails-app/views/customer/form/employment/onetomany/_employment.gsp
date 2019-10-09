<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>



<div id="employment${i}" class="employment-div">
        <g:if test="${employment?.id}"> 
            <g:hiddenField name='employments[${i}].id' value="${employment?.id}"/>
            <g:hiddenField name='employments[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='employments[${i}].new' value="true"/>
        </g:else>
        <g:hiddenField name='employments[${i}].deleted' value='false'/>
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].employerName', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].employerName">
                        <g:message code="employment.employerName.label" default="Employer Name" />
                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].employerName" maxlength="50" value="${employment?.employerName}"class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="employments[${i}].employerName">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="employments[${i}].employerName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                    </g:hasErrors>
                
                </div>
        </div>
           <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].address1', 'has-error')} ">
            <label class="control-label col-sm-4"for="employments[${i}].address1">
                <g:message code="employment.address1.label" default="Address" />
            </label>
            <div class="col-sm-8">
                <g:textField placeholder="Room No./Office Name,/Bldg./HouseNo.,Street,Subd./Brgy." name="employments[${i}].address1" maxlength="50" value="${employment?.address1}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="employments[${i}].address1">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="employments[${i}].address1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].address2', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].address2">
                </label>
                <div class="col-sm-8">
                    <g:textField placeholder="District, Town, City" name="employments[${i}].address2"  maxlength="50" value="${employment?.address2}"class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="employments[${i}].address2">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].address2">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>
        <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].address3', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].address3">
                </label>
                <div class="col-sm-8">
                    <g:textField placeholder="Province,Country,ZIP" name="employments[${i}].address3" maxlength="30" value="${employment?.address3}"class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="employments[${i}].address3">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].address3">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].yearStart', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].yearStart">
                        <g:message code="employment.yearStart.label" default="Year Start" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].yearStart" maxlength="4" value="${employment?.yearStart}"class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="employments[${i}].yearStart">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].yearStart">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                
                </div>

        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].yearEnd', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].yearEnd">
                        <g:message code="employment.yearEnd.label" default="Year End" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].yearEnd" maxlength="4" value="${employment?.yearEnd}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].yearEnd">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].yearEnd">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].designation', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].designation">
                        <g:message code="employment.designation.label" default="Designation" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].designation" maxlength="50" value="${employment?.designation}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].designation">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].designation">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].employmentId', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].employmentId">
                        <g:message code="employment.employmentId.label" default="Employment Id" />
                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].employmentId" maxlength="30" value="${employment?.employmentId}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].employmentId">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].employmentId">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
 
                </div>
        </div>
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].depedEmploymentId', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].depedEmploymentId">
                        <g:message code="employment.depedEmploymentId.label" default="DepEd Employment Id" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].depedEmploymentId" maxlength="30" value="${employment?.depedEmploymentId}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].depedEmploymentId">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].depedEmploymentId">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].region', 'has-error')} ">
	<label class="control-label col-sm-4" for="employments[${i}].region">
		<g:message code="customer.region.label" default="Region" />
	</label>
      
	<div class="col-sm-8"><g:select name="employments[${i}].region.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("RGN",true)}" optionKey="id" optionValue ="itemValue" value="${employment?.region?.id}"class="form-control"/></div>
        <g:hasErrors bean="${customerInstance}" field="employment[${i}].region">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${customerInstance}" field="employments[${i}].region">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
</div>         
                    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].monthlyIncome', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].monthlyIncome">
                        <g:message code="employment.monthlyIncome.label" default="Monthly Income" />
                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].monthlyIncome" maxlength="30" value="${employment?.monthlyIncome}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].monthlyIncome">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].monthlyIncome">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
 
                </div>
        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].supervisor', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].supervisor">
                        <g:message code="employment.supervisor.label" default="Supervisor" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].supervisor" maxlength="50" value="${employment?.supervisor}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].supervisor">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].supervisor">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].contactNo', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].contactNo">
                        <g:message code="employment.contactNo.label" default="Contact No" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].contactNo" maxlength="50" value="${employment?.contactNo}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].contactNo">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].contactNo">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].faxNo', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].faxNo">
                        <g:message code="employment.faxNo.label" default="Fax No" />

                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].faxNo" maxlength="50" value="${employment?.faxNo}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].faxNo">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].faxNo">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                
                </div>

        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'employments['+i+'].eMail', 'has-error')} ">
                <label class="control-label col-sm-4"for="employments[${i}].eMail">
                        <g:message code="employment.eMail.label" default="E Mail" />
                </label>
                <div class="col-sm-8">
                    <g:textField name="employments[${i}].eMail" maxlength="50" value="${employment?.eMail}"class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="employments[${i}].eMail">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="employments[${i}].eMail">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>
</div>