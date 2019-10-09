
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
                <g:set var="entityName" value="${message(code: 'loanProject.label', default: 'LoanProject')}" />
		<title>Update Loan Project</title>
                
        </head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/lovMaintenance')}">List of Values Maintenance</a>
                <span class="fa fa-chevron-right"></span><span class="current">Update Loan Project</span>
            </content>
            <content tag="main-content">
                    <g:hasErrors bean="${loanProjectInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${loanProjectInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
                    </g:hasErrors>

                    <div class="nav-tab-container">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1" data-toggle="tab"><b>Loan Project Details</b></a></li>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <div class="tab-pane active fade in" id="tab_1">
                            <g:form controller="lovMaintenance" action="loanProjectInstanceUpdate" >
                                <g:hiddenField name="id" value="${loanProjectInstance?.id}" />
                                <g:hiddenField name="version" value="${loanProjectInstance?.version}" />
                                    <fieldset class="form">
                                        <div class="fieldcontain form-group ${hasErrors(bean: loanProjectInstance, field: 'code', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="code">
                                                <g:message code="loanProjectInstance.code.label" default="Code" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="code" maxlength="100" required="" value="${loanProjectInstance?.code}"class="form-control"/>

                                                <g:hasErrors bean="${loanProjectInstance}" field="code">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${loanProjectInstance}" field="code">
                                                                <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>
                                        <div class="fieldcontain form-group ${hasErrors(bean: loanProjectInstance, field: 'description', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="description">
                                                <g:message code="loanProjectInstance.description.label" default="Description" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${loanProjectInstance?.description}"class="form-control"/>

                                                <g:hasErrors bean="${loanProjectInstance}" field="description">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${loanProjectInstance}" field="description">
                                                                <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>

                                    </fieldset>
                                    <g:actionSubmit class="btn btn-primary" action="loanProjectInstanceUpdate" value="${message(code: 'default.button.save.label', default: 'Save')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.update.confirm.message', default: 'Are you sure you want to update this loan project?')}');" />
                                    </g:form>	
                        </div>
                    </div>
                
            </content>	
            <content tag="main-actions">
		<ul>
                    <li></li>
                    <li><g:link action="loanProjectIndex">Cancel</g:link></li>
		</ul>
            </content>
	</body>
</html>
