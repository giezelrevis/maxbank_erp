<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Create New Town/Municipality</title>
	</head>
        <body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/lovMaintenance')}">List of Values Maintenance</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create New Town/Municipality</span>
            </content>
            <content tag="main-content">
             <div class="tab-content">
                  <g:hasErrors bean="${townInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${townInstance}" var="error">
				</g:eachError>
			</ul>
                    </g:hasErrors>
                        <div class="tab-pane active fade in" id="tab_1">
                            <g:form controller="lovMaintenance" action="townInstanceSave" >
                                <g:hiddenField name="id" value="${townInstance?.id}" />
                                <g:hiddenField name="version" value="${townInstance?.version}" />
                                    <fieldset class="form">
                                        <div class="fieldcontain form-group ${hasErrors(bean: townInstance, field: 'code', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="code">
                                                <g:message code="townInstance.code.label" default="Code" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="code" maxlength="100" required="" value="${townInstance?.code}"class="form-control"/>

                                                <g:hasErrors bean="${townInstance}" field="code">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${townInstance}" field="code">
                                                               <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>
                                        <div class="fieldcontain form-group ${hasErrors(bean: townInstance, field: 'description', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="description">
                                                <g:message code="townInstance.description.label" default="Description" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${townInstance?.description}"class="form-control"/>

                                                <g:hasErrors bean="${townInstance}" field="description">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${townInstance}" field="description">
                                                                <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>
                                        <g:hiddenField name="status" value="true" />
                                    </fieldset>
                                <g:actionSubmit class="btn btn-primary" action="townInstanceSave" value="${message(code: 'default.button.created.label', default: 'Save')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.update.confirm.message', default: 'Are you sure you want to create this town?')}');" />
                            </g:form>	
                        </div>
                    </div>
            </content>	
             <content tag="main-actions">
		<ul>
                    <li></li>
                    <li><g:link action="townAndMunicipalityIndex">Cancel</g:link></li>
		</ul>
            </content>
	</body>
</html>