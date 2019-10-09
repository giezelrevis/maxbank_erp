<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Create New Size of Firm</title>
	</head>
        <body>
           <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/lovMaintenance')}">List of Values Maintenance</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create New Size of Firm</span>
            </content>
         <content tag="main-content">
             <div class="tab-content">
                  <g:hasErrors bean="${firmSizeInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${firmSizeInstance}" var="error">
				</g:eachError>
			</ul>
                    </g:hasErrors>
                        <div class="tab-pane active fade in" id="tab_1">
                            <g:form controller="lovMaintenance" action="firmSIzeInstanceSave" >
                                <g:hiddenField name="id" value="${firmSizeInstance?.id}" />
                                <g:hiddenField name="version" value="${firmSizeInstance?.version}" />
                                    <fieldset class="form">
                                        <div class="fieldcontain form-group ${hasErrors(bean: firmSizeInstance, field: 'code', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="code">
                                                <g:message code="firmSizeInstance.code.label" default="Code" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="code" maxlength="100" required="" value="${firmSizeInstance?.code}"class="form-control"/>

                                                <g:hasErrors bean="${firmSizeInstance}" field="code">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${firmSizeInstance}" field="code">
                                                               <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>
                                        <div class="fieldcontain form-group ${hasErrors(bean: firmSizeInstance, field: 'description', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="description">
                                                <g:message code="frimSizeInstance.description.label" default="Description" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${firmSizeInstance?.description}"class="form-control"/>

                                                <g:hasErrors bean="${firmSizeInstance}" field="description">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${firmSizeInstance}" field="description">
                                                                <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>
                                        <g:hiddenField name="status" value="true" />
                                    </fieldset>
                                <g:actionSubmit class="btn btn-primary" action="firmSizeInstanceSave" value="${message(code: 'default.button.created.label', default: 'Save')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.update.confirm.message', default: 'Are you sure you want to create this firm size?')}');" />
                            </g:form>	
                        </div>
                    </div>
            </content>	
             <content tag="main-actions">
		<ul>
                    <li></li>
                    <li><g:link action="sizeOfFirmIndex">Cancel</g:link></li>
		</ul>
            </content>
	</body>
</html>