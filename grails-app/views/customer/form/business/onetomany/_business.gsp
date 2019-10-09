<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div id="business${i}" class="business-div">
        <g:if test="${business?.id}"> 
            <g:hiddenField name='businesses[${i}].id' value="${business?.id}"/>
            <g:hiddenField name='businesses[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='businesses[${i}].new' value="true"/>
        </g:else>
        <g:hiddenField name='businesses[${i}].deleted' value='false'/>
        
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].name', 'has-error')} ">
            <label class="control-label col-sm-4" for="businesses[${i}].name">
                    <g:message code="business.name.label" default="Name" />
                    
            </label>
            <div class="col-sm-8">
                <g:textField name="businesses[${i}].name" maxlength="50" value="${business?.name}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].name">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>
    <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].address1', 'has-error')} ">
            <label class="control-label col-sm-4"for="businesses[${i}].address1">
                <g:message code="business.address.label" default="Address" />
            </label>
            <div class="col-sm-8">
                <g:textField placeholder="Room No./Office Name,/Bldg./HouseNo.,Street,Subd./Brgy." name="businesses[${i}].address1" maxlength="50" value="${business?.address1}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].address1">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].address1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>
    <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].address2', 'has-error')} ">
            <label class="control-label col-sm-4"for="businesses[${i}].address2">
            </label>
            <div class="col-sm-8">
                <g:textField placeholder="District, Town, City" name="businesses[${i}].address2" maxlength="50" value="${business?.address2}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].address2">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].address2">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>
    <div class=" form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].address3', 'has-error')} ">
            <label class="control-label col-sm-4"for="businesses[${i}].address3">
            </label>
            <div class="col-sm-8">
                <g:textField placeholder="Province,Country,ZIP" name="businesses[${i}].address3" maxlength="30" value="${business?.address3}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].address3">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].address3">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    




                <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].lProject', 'has-error')} ">
                <label class="control-label col-sm-4"for="businesses[${i}].lProject">
                        <g:message code="business.region.label" default="Economic Activity" />
                </label>
                <div class="col-sm-8">
                    <g:select name="businesses[${i}].lProject.id" from="${icbs.lov.LoanProject.list()}" optionKey="id" value="${business?.lProject?.id}" class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="businesses[${i}].lProject">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="businesses[${i}].lProject">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].contactNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="businesses[${i}].contactNo">
                    <g:message code="business.contactNo.label" default="Contact No" />

            </label>
            <div class="col-sm-8">
                <g:textField name="businesses[${i}].contactNo" maxlength="50" value="${business?.contactNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].contactNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].contactNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].faxNo', 'has-error')}">
            <label class="control-label col-sm-4"for="businesses[${i}].faxNo">
                    <g:message code="business.faxNo.label" default="Fax No" />

            </label>
            <div class="col-sm-8">
                <g:textField name="businesses[${i}].faxNo" maxlength="50" value="${business?.faxNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].faxNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].faxNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].registrationDate', 'has-error')}">
            <label class="control-label col-sm-4"for="businesses[${i}].registrationDate">
                    <g:message code="business.registrationDate.label" default="Registration Date" />

            </label>
            <div class="col-sm-8">
                <g:customDatePicker name="businesses[${i}].registrationDate" maxlength="50" value="${business?.registrationDate}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].registrationDate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].registrationDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>

    </div>
    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'businesses['+i+'].eMail', 'has-error')} ">
            <label class="control-label col-sm-4"for="businesses[${i}].eMail">
                    <g:message code="business.eMail.label" default="E Mail" />

            </label>
            <div class="col-sm-8">
                <g:textField name="businesses[0].eMail" maxlength="50" value="${business?.eMail}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="businesses[${i}].eMail">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="businesses[${i}].eMail">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
    </div>  
</div>  
