<%@ page import="icbs.loans.GroupRecord" %>


<legend>Group Details</legend>

<div class="fieldcontain form-group ${hasErrors(bean: groupInstance, field: 'name', 'has-error')} required">
    <label class="control-label col-sm-4" for="name">
        <g:message code="group.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:textField name="name" required="" value="${groupInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${groupInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${groupInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: groupInstance, field: 'description', 'has-error')} ">
	<label class="control-label col-sm-4" for="description">
		<g:message code="group.description.label" default="Description" />
	</label>
	<div class="col-sm-8"><g:textArea name="description" value="${groupInstance?.description}" rows="3" class="form-control"/>

            <g:hasErrors bean="${groupInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${groupInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="form-group fieldcontain ${hasErrors(bean: groupInstance, field: 'type', 'has-error')} ">
    <label class="control-label col-sm-4" for="type">
        <g:message code="group.type.label" default="Type" />
    </label>
    <div class="col-sm-8">
        <g:select class="form-control" id="type" name="type.id" from="${icbs.lov.GroupType.list()}" optionKey="id" optionValue="description" value="${groupInstance?.type?.id}"/>
        <g:hasErrors bean="${groupInstance}" field="installmetypentType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${groupInstance}" field="type">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: groupInstance, field: 'parent', 'has-error')}">
    <label class="control-label col-sm-4" for="loanApplication">
        Parent Group
    </label>
    <div class="col-sm-7"><g:field name="parent-name" value="${groupInstance?.parent?.name}" class="form-control" readonly="true"/>
        <g:hiddenField id="parent" name="parent.id" value="${groupInstance?.parent?.id}" />

        <g:hasErrors bean="${groupInstance}" field="parent">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${groupInstance}" field="parent">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>

    <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showGroupSearch()" value="Search"/></div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: groupInstance, field: 'meetingDate', 'has-error')}">
	<label class="control-label col-sm-4" for="meetingDate">
		<g:message code="group.meetingDate.label" default="Meeting Date" />
	</label>
	<div class="col-sm-8"><g:customDatePicker name="meetingDate" precision="day" class="form-control"  value="${groupInstance?.meetingDate}"  />

            <g:hasErrors bean="${groupInstance}" field="meetingDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${groupInstance}" field="meetingDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

