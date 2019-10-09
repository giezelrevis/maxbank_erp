<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<legend>Customer Details</legend>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'displayName', 'has-error')} ">
	<label class="control-label col-sm-4"for="displayName">
		<g:message code="customer.displayName.label" default="Display Name" />
		<span class="required-indicator">*</span>
	</label>
	 <div class="col-sm-8">
                <g:field type="text" id="displayName"name="displayName" readonly="readonly"  value="${customerInstance?.displayName}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="displayName">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="displayName" >
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>   
         </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'customerCode1', 'has-error')} ">
            <label class="control-label col-sm-4" for="dosriCode">
                    <g:message code="customer.customerCode1.label" default="Type of Resident" />
            </label>
            <div class="col-sm-8">
                <g:select id="dosriCode" name="customerCode1.id" from="${icbs.lov.ResidentType.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.customerCode1?.id}" class="form-control" />
                <g:hasErrors bean="${customerInstance}" field="customerCode1">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="customerCode1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>      
            </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'customerCode2', 'has-error')} ">
            <label class="control-label col-sm-4" for="dosriCode">
                    <g:message code="customer.customerCode2.label" default="Risk Classification" />
            </label>
            <div class="col-sm-8">
                <g:select id="dosriCode" name="customerCode2.id" from="${icbs.lov.RiskType.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.customerCode2?.id}" class="form-control" />
                <g:hasErrors bean="${customerInstance}" field="customerCode2">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="customerCode2">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>      
            </div>
       </div>
           <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'pepDescription', 'has-error')} ">
            <label class="control-label col-sm-4"for="pepDescription">
                    <g:message code="customer.pepDescription.label" default="PEP Description" />

            </label>
            <div class="col-sm-8">
                <g:textField name="pepDescription" maxlength="50" value="${customerInstance?.pepDescription}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="pepDescription">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="pepDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>    
            </div>
    </div>
       
       
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'amla', 'has-error')} ">
            <label class="control-label col-sm-4"for="amla">
                    <g:message code="customer.amla.label" default="Verified AMLA Blocked" />

            </label>
            <div class="col-sm-8">
                <g:textField name="amla" maxlength="50" value="${customerInstance?.amla}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="amla">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="amla">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>    
            </div>
    </div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'customerCode3', 'has-error')} ">
            <label class="control-label col-sm-4" for="customerCode3">
                    <g:message code="customer.customerCode3.label" default=" Size of Firm" />
            </label>
            <div class="col-sm-8">
                <g:select id="dosriCode" name="customerCode3.id" from="${icbs.lov.FirmSize.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.customerCode3?.id}" class="form-control" />
                <g:hasErrors bean="${customerInstance}" field="customerCode3">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="customerCode3">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>      
            </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'sourceOfIncome', 'has-error')} ">
	<label class="control-label col-sm-4" for="name1">
		<g:message code="customer.sourceOfIncome.label" default="Source of Income" />
		<span class="required-indicator">*</span>
	</label>
        
	<div class="col-sm-8">  
            <g:textField id="sourceOfIncome"name="sourceOfIncome" maxlength="50" ="" value="${customerInstance?.sourceOfIncome}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="sourceOfIncome">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="sourceOfIncome">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>   
</div>



<g:if test="${customerInstance?.type?.id==1}">
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'dosriCode', 'has-error')} ">
            <label class="control-label col-sm-4" for="dosriCode">
                    <g:message code="customer.dosriCode.label" default="DOSRI Code" />
            </label>
            <div class="col-sm-8">
                <g:select id="dosriCode" name="dosriCode.id" from="${icbs.lov.CustomerDosriCode.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.dosriCode?.id}" class="form-control" />
                <g:hasErrors bean="${customerInstance}" field="dosriCode">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="dosriCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>      
            </div>
    </div>
    <legend>Other Customer Details</legend>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'nationality', 'has-error')} ">
	<label class="control-label col-sm-4" for="nationality">
		<g:message code="customer.natonality.label" default="Nationality" />
		<span class="required-indicator">*</span>
	</label>
      
	<div class="col-sm-8"><g:select id="nationality" name="nationality.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("NATL",true)}" optionKey="id" optionValue ="itemValue" value="${customerInstance?.nationality?.id}"class="form-control"/></div>
        <g:hasErrors bean="${customerInstance}" field="nationality">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${customerInstance}" field="nationality">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
    <!--
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'sssNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="sssNo">
                    <g:message code="customer.sssNo.label" default="SSS" />

            </label>
             <div class="col-sm-8">
                <g:textField name="sssNo" maxlength="50" value="${customerInstance?.sssNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="sssNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="sssNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>    
             </div>

    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'gisNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="gisNo">
                    <g:message code="customer.gisNo.label" default="GSIS" />

            </label>
            <div class="col-sm-8">
                <g:textField name="gisNo" maxlength="50" value="${customerInstance?.gisNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="gisNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="gisNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>    
            </div>
    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'tinNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="tinNo">
                    <g:message code="customer.tinNo.label" default="TIN" />
            </label>
             <div class="col-sm-8">
                <g:textField name="tinNo" maxlength="50" value="${customerInstance?.tinNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="tinNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="tinNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>    
             </div>


    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'passportNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="passportNo">
                    <g:message code="customer.passportNo.label" default="Passport No" />
            </label>
            <div class="col-sm-8">
                <g:textField name="passportNo" maxlength="50" value="${customerInstance?.passportNo}"class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="passportNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="passportNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                 </g:hasErrors>    
            </div>
    </div>
    -->
   </g:if>
            
            
            
