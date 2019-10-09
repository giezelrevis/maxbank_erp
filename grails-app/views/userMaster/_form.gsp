<%@ page import="icbs.admin.UserMaster" %>
<%@ page import="icbs.admin.Currency" %>
<%@ page import="icbs.admin.Branch" %>

<fieldset>
<legend>Profile</legend>
<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'name1', 'has-error')} required">
	<label class="control-label col-sm-4" for="name1">
		<g:message code="userMaster.name1.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:textField name="name1" maxlength="50" required="" value="${userMasterInstance?.name1}"class="form-control"/>
            <g:hasErrors bean="${userMasterInstance}" field="name1">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="name1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'name2', 'has-error')} ">
	<label class="control-label col-sm-4" for="name2">
		<g:message code="userMaster.name2.label" default="Middle Name" />
	</label>
	<div class="col-sm-8"><g:textField name="name2" maxlength="50" value="${userMasterInstance?.name2}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="name2">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="name2">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'name3', 'has-error')} required">
	<label class="control-label col-sm-4" for="name3">
		<g:message code="userMaster.name3.label" default="Last Name" />
                <span class="required-indicator">*</span>
		
	</label>
	<div class="col-sm-8"><g:textField name="name3" maxlength="50" required="" value="${userMasterInstance?.name3}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="name3">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="name3">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'birthdate', 'has-error')} ">
	<label class="control-label col-sm-4" for="birthdate">
		<g:message code="userMaster.birthdate.label" default="Birthdate" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:customDatePicker name="birthdate" required="" precision="day" class="form-control"  value="${userMasterInstance?.birthdate}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${userMasterInstance}" field="birthdate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="birthdate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'gender', 'has-error')} required">
	<label class="control-label col-sm-4" for="gender">
		<g:message code="userMaster.gender.label" default="Gender" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="gender" name="gender.id" from="${icbs.lov.Gender.list()}" optionKey="id" optionValue="description" required="" value="${userMasterInstance?.gender?.id}"  class="many-to-one form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="gender">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="gender">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'address1', 'has-error')} required">
	<label class="control-label col-sm-4" for="address1">
		<g:message code="userMaster.address1.label" default="Address1" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="address1" maxlength="100" required="" value="${userMasterInstance?.address1}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="address1">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="address1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'address2', 'has-error')} ">
	<label class="control-label col-sm-4" for="address2">
		<g:message code="userMaster.address2.label" default="Address2" />
		
	</label>
	<div class="col-sm-8"><g:textField name="address2" maxlength="100" value="${userMasterInstance?.address2}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="address2">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="address2">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'province', 'has-error')} ">
	<label class="control-label col-sm-4" for="province">
		<g:message code="userMaster.province.label" default="Province" />
		
	</label>
	<div class="col-sm-8"><g:select id="province" name="province.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("PROV",true)}" optionKey="id" optionValue="itemValue" value="${userMasterInstance?.province?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${userMasterInstance}" field="province">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="province">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'zipCode', 'has-error')} required">
	<label class="control-label col-sm-4" for="zipCode">
		<g:message code="userMaster.zipCode.label" default="Zip Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="zipCode" maxlength="10" required="" value="${userMasterInstance?.zipCode}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="zipCode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="zipCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'email', 'has-error')} required">
	<label class="control-label col-sm-4" for="email">
		<g:message code="userMaster.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="email" maxlength="100" required="" value="${userMasterInstance?.email}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="email">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="email">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'contact', 'has-error')} required">
	<label class="control-label col-sm-4" for="contact">
		<g:message code="userMaster.contact.label" default="Contact" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="contact" maxlength="30" required="" value="${userMasterInstance?.contact}"class="form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="contact">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="contact">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'dateHired', 'has-error')} ">
	<label class="control-label col-sm-4" for="dateHired">
		<g:message code="userMaster.dateHired.label" default="Date Hired" />
	</label>
	<div class="col-sm-8"><g:customDatePicker name="dateHired" required="" precision="day" class="form-control"  value="${userMasterInstance?.dateHired}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${userMasterInstance}" field="dateHired">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="dateHired">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'designation', 'has-error')} required">
	<label class="control-label col-sm-4" for="designation">
		<g:message code="userMaster.designation.label" default="Designation" />
	</label>
	<div class="col-sm-8"><g:select id="designation" name="designation.id" from="${icbs.lov.Designation.list()}" optionKey="id" optionValue="description" required="" value="${userMasterInstance?.designation?.id}"  class="many-to-one form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="designation">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="designation">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'branch', 'has-error')} required">
	<label class="control-label col-sm-4" for="branch">
		<g:message code="userMaster.branch.label" default="Branch" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="branch" name="branch.id" from="${icbs.admin.Branch.findAll{status.id == 2}}" optionKey="id" optionValue="name" required="" value="${userMasterInstance?.branch?.id}"  class="many-to-one form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="branch">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="branch">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'cash', 'has-error')}">
    <label class="control-label col-sm-4" for="cash">
        <g:message code="userMaster.cash.label" default="Cash" />
    </label>
    <div class="col-sm-8"><g:select id="cash" name="cash.id" from="${icbs.gl.GlAccount.findAllByBranchAndCurrencyAndCodeLike(Branch.get(1),Currency.get(1),icbs.admin.Institution.findAllByParamCode("GLS.60100").paramValue)}" optionKey="id" optionValue="name" value="${userMasterInstance?.cash?.id}" noSelection="['': '']" class="many-to-one form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="cash">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="cash">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'coci', 'has-error')}">
    <label class="control-label col-sm-4" for="coci">
        <g:message code="userMaster.coci.label" default="COCI" />
    </label>
    <div class="col-sm-8"><g:select id="coci" name="coci.id" from="${icbs.gl.GlAccount.findAllByBranchAndCurrencyAndCodeLike(Branch.get(1),Currency.get(1),icbs.admin.Institution.findAllByParamCode("GLS.60200").paramValue)}" optionKey="id" optionValue="name" value="${userMasterInstance?.coci?.id}" noSelection="['': '']" class="many-to-one form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="coci">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="coci">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'employmentType', 'has-error')} required">
	<label class="control-label col-sm-4" for="employmentType">
		<g:message code="userMaster.employmentType.label" default="Employment Type" />
	</label>
	<div class="col-sm-8"><g:select id="employmentType" name="employmentType.id" required="" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("CET",true)}" optionKey="id" optionValue="itemValue" value="${userMasterInstance?.employmentType?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${userMasterInstance}" field="employmentType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="employmentType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'expiryDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="expiryDate">
		<g:message code="userMaster.expiryDate.label" default="Access Expiry Date" />
	</label>
	<div class="col-sm-8"><g:customDatePicker name="expiryDate" required="" precision="day" class="form-control"  value="${userMasterInstance?.expiryDate}" default="none" noSelection="['': '']" />

            <g:hasErrors bean="${userMasterInstance}" field="expiryDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="expiryDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
</fieldset>

<br/><br/>
<fieldset>
<legend>Account</legend>
<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'username', 'has-error')} required">
    <label class="control-label col-sm-4" for="username">
        <g:message code="userMaster.username.label" default="Username" />
        <span class="required-indicator">*</span>
    </label>

    <g:if test="${mode=='edit'}">
        <div class="col-sm-8"><g:textField name="username" maxlength="20" required="" value="${userMasterInstance?.username}"class="form-control" disabled="" />
    </g:if>
    <g:else>
        <div class="col-sm-8"><g:textField name="username" maxlength="20" required="" value="${userMasterInstance?.username}"class="form-control" />
    </g:else>

            <g:hasErrors bean="${userMasterInstance}" field="username">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="username">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<g:if test="${mode=='create'}">
<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'password', 'has-error')} required">
    <label class="control-label col-sm-4" for="password">
        <g:message code="userMaster.password.label" default="Password" />
        <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-8">
        <g:hiddenField id="newPasswordHiddenField" name="password" value="" />
        <g:textField id="newPasswordTextField" name="p" required="" disabled="disabled" value="" size="30" />
        <button type="button" id="generate-password" class="btn btn-primary">Generate Password</button>
        <g:hasErrors bean="${userMasterInstance}" field="password">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${userMasterInstance}" field="password">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

</g:if>

<div class="fieldcontain form-group ${hasErrors(bean: userMasterInstance, field: 'expiryDate', 'has-error')} required">
    <label class="control-label col-sm-4" for="expiryDate">
        <g:message code="userMaster.expiryDate.label" default="Expiry Date" />
    </label>

    <g:if test="${mode=='create'}">      
        <div class="col-sm-8"><g:customDatePicker name="expiryDate" required="" precision="day" class="form-control"  value="${branchRunDate.plus(accessValidity)}" noSelection="['': '']" />
    </g:if>
    <g:else>
        <div class="col-sm-8"><g:customDatePicker name="expiryDate" required="" precision="day" class="form-control"  value="${userMasterInstance?.expiryDate}" noSelection="['': '']" />
    </g:else>

            <g:hasErrors bean="${userMasterInstance}" field="expiryDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${userMasterInstance}" field="expiryDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
</fieldset>

<div><g:hiddenField name="configItemStatus" value="2" /></div>