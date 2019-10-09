<%@ page import="icbs.admin.Branch" %>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="branch.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">

    <g:if test="${mode=='edit'}">
        <g:textField name="code" maxlength="10" disabled="" value="${fieldValue(bean: branchInstance, field: "code").padLeft(3, '0')}" class="form-control"/>
    </g:if>
    <g:else>
        <g:textField name="code" maxlength="10" required="" value="${fieldValue(bean: branchInstance, field: "code").padLeft(3, '0')}" class="form-control"/>
    </g:else>

            <g:hasErrors bean="${branchInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="branch.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" maxlength="50" required="" value="${branchInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${branchInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'swiftCode', 'has-error')} required">
	<label class="control-label col-sm-4" for="swiftCode">
		<g:message code="branch.swiftCode.label" default="Swift Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="swiftCode" maxlength="50" required="" value="${branchInstance?.swiftCode}"class="form-control"/>

            <g:hasErrors bean="${branchInstance}" field="swiftCode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="swiftCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'address', 'has-error')} required">
	<label class="control-label col-sm-4" for="address">
		<g:message code="branch.address.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textArea name="address" cols="40" rows="5" maxlength="255" required="" value="${branchInstance?.address}"class="form-control"/>

            <g:hasErrors bean="${branchInstance}" field="address">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="address">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'country', 'has-error')} ">
	<label class="control-label col-sm-4" for="country">
		<g:message code="branch.country.label" default="Country" />
		
	</label>
	<div class="col-sm-8"><g:select id="country" name="country.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("CTRY",true)}" optionKey="id" optionValue="itemValue" value="${branchInstance?.country?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${branchInstance}" field="country">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="country">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'region', 'has-error')} ">
	<label class="control-label col-sm-4" for="region">
		<g:message code="branch.region.label" default="Region" />
		
	</label>
	<div class="col-sm-8"><g:select id="region" name="region.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("RGN",true)}" optionKey="id" optionValue="itemValue" value="${branchInstance?.region?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${branchInstance}" field="region">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="region">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'contactNumber', 'has-error')} ">
	<label class="control-label col-sm-4" for="contactNumber">
		<g:message code="branch.contactNumber.label" default="Contact Number" />
		
	</label>
	<div class="col-sm-8"><g:textField name="contactNumber" value="${branchInstance?.contactNumber}"class="form-control"/>

            <g:hasErrors bean="${branchInstance}" field="contactNumber">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="contactNumber">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'managerId', 'has-error')} ">
	<label class="control-label col-sm-4" for="managerId">
		<g:message code="branch.managerId.label" default="Manager" />
		
	</label>
	<div class="col-sm-8"><g:select id="managerId" name="managerId.id" from="${icbs.admin.UserMaster.list()}" optionKey="id" optionValue="name1" value="${branchInstance?.managerId?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${branchInstance}" field="managerId">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="managerId">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'openDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="openDate">
		<g:message code="branch.openDate.label" default="Open Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="openDate" precision="day" class="form-control"  value="${branchInstance?.openDate}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${branchInstance}" field="openDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="openDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'dataCenter', 'has-error')} ">
	<label class="control-label col-sm-4" for="dataCenter">
		<g:message code="branch.dataCenter.label" default="Data Center" />
		
	</label>

    <g:if test="${disableDataCenter}">
        <div class="col-sm-8"><g:checkBox name="dataCenter" class="form-control" value="${branchInstance?.dataCenter}" disabled="disabled" />
    </g:if>
    <g:else>
        <div class="col-sm-8"><g:checkBox name="dataCenter" class="form-control" value="${branchInstance?.dataCenter}" />
    </g:else>

    

            <g:hasErrors bean="${branchInstance}" field="dataCenter">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="dataCenter">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: branchInstance, field: 'taxNo', 'has-error')} ">
	<label class="control-label col-sm-4" for="taxNo">
		<g:message code="branch.taxNo.label" default="Tax No" />
		
	</label>
	<div class="col-sm-8"><g:textField name="taxNo" maxlength="50" value="${branchInstance?.taxNo}"class="form-control"/>

            <g:hasErrors bean="${branchInstance}" field="taxNo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${branchInstance}" field="taxNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ">
    <label class="control-label col-sm-4" >
        <g:message code="branch.workingDays.label" default="Working Days" />
        
    </label>

    <div>
        
            <g:checkBox name="openOnMon" value="${branchInstance?.openOnMon}" /> Monday
            <g:checkBox name="openOnTue" value="${branchInstance?.openOnTue}" /> Tuesday
            <g:checkBox name="openOnWed" value="${branchInstance?.openOnWed}" /> Wednesday
            <g:checkBox name="openOnThu" value="${branchInstance?.openOnThu}" /> Thursday
            <g:checkBox name="openOnFri" value="${branchInstance?.openOnFri}" /> Friday
            <g:checkBox name="openOnSat" value="${branchInstance?.openOnSat}" /> Saturday
            <g:checkBox name="openOnSun" value="${branchInstance?.openOnSun}" /> Sunday
        
    </div>             
</div>







<div><g:hiddenField name="status" value="2" /></div>

