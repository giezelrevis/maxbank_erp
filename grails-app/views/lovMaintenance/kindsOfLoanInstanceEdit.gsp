
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
                <g:set var="entityName" value="${message(code: 'loanKindOfLoan.label', default: 'LoanKindOfLoan')}" />
		<title>Update Kind of Loan</title>
                
        </head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/lovMaintenance')}">List of Values Maintenance</a>
                <span class="fa fa-chevron-right"></span><span class="current">Update Kind of Loan</span>
            </content>
            <content tag="main-content">
                    <g:hasErrors bean="${loanKindOfLoanInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${loanKindOfLoanInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
                    </g:hasErrors>

                    <div class="nav-tab-container">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1" data-toggle="tab"><b>Kind of Loan Details</b></a></li>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <div class="tab-pane active fade in" id="tab_1">
                            <g:form controller="lovMaintenance" action="kindsOfLoanInstanceUpdate" >
                                <g:hiddenField name="id" value="${loanKindOfLoanInstance?.id}" />
                                <g:hiddenField name="version" value="${loanKindOfLoanInstance?.version}" />
                                    <fieldset class="form">
                                        <div class="fieldcontain form-group ${hasErrors(bean: loanKindOfLoanInstance, field: 'code', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="code">
                                                <g:message code="loanKindOfLoanInstance.code.label" default="Code" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="code" maxlength="100" required="" value="${loanKindOfLoanInstance?.code}"class="form-control"/>

                                                <g:hasErrors bean="${loanKindOfLoanInstance}" field="code">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${loanKindOfLoanInstance}" field="code">
                                                                <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>
                                        <div class="fieldcontain form-group ${hasErrors(bean: loanKindOfLoanInstance, field: 'description', 'has-error')} required">
                                            <label class="control-label col-sm-4" for="description">
                                                <g:message code="loanKindOfLoanInstance.description.label" default="Description" />
                                                <span class="required-indicator">*</span>
                                            </label>
                                            <div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${loanKindOfLoanInstance?.description}"class="form-control"/>

                                                <g:hasErrors bean="${loanKindOfLoanInstance}" field="description">
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            <g:eachError bean="${loanKindOfLoanInstance}" field="description">
                                                                <g:message error="${it}" /><br/>
                                                            </g:eachError>
                                                        </span>
                                                    </div>
                                                </g:hasErrors>
                                            </div>             
                                        </div>

                                    </fieldset>
                                    <g:actionSubmit class="btn btn-primary" action="kindsOfLoanInstanceUpdate" value="${message(code: 'default.button.save.label', default: 'Save')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.update.confirm.message', default: 'Are you sure you want to update this kind of loan?')}');" />
                                    </g:form>	
                        </div>
                    </div>
                
            </content>	
            <content tag="main-actions">
		<ul>
                    <li></li>
                    <li><g:link action="kindsOfLoanIndex">Cancel</g:link></li>
		</ul>
            </content>
	</body>
</html>
