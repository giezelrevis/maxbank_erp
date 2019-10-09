<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<title>Edit Loan Special</title>
	</head>
	<body>
        <content tag="main-content">
		<div id="edit-loan" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>

			<g:hasErrors bean="${loanInstance?.special}">
	            <div class="box-body">
	                <div class="alert alert-danger alert-dismissable">
	                    <i class="fa fa-ban"></i>
	                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                    <b>Alert!</b> 
	                    <ul class="errors" role="alert">
	                        There are errors
	                    </ul>            
	                </div>
	            </div>
            </g:hasErrors>

			<g:form url="[controller:loan, id:"${loanInstance?.id}", action:'updateSpecial']" method="POST" >				
				<div>
					<g:hiddenField name="version" value="${loanInstance?.special?.version}" />

					<div class="fieldcontain form-group">
						<label class="control-label col-sm-4" for="type">Type</label>
						<div class="col-sm-8"><g:select id="type" name="type.id" from="${icbs.lov.LoanSpecialType.list()}" optionKey="id" optionValue="description" value="${loanInstance?.special?.type?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

				            <g:hasErrors bean="${loanInstance?.special}" field="type">
				                <div class="controls">
			                        <span class="help-block">
			                            <g:eachError bean="${loanInstance?.special}" field="type">
			                                <g:message error="${it}" /><br/>
			                            </g:eachError>
			                        </span>
				                </div>
				            </g:hasErrors>
				        </div>             
					</div>    

					<div class="fieldcontain form-group">
						<label class="control-label col-sm-4" for="specialAction">Action</label>
						<div class="col-sm-8"><g:textField name="specialAction" value="${loanInstance?.special?.action}"class="form-control"/>

				            <g:hasErrors bean="${loanInstance?.special}" field="action">
				                <div class="controls">
			                        <span class="help-block">
			                            <g:eachError bean="${loanInstance?.special}" field="action">
			                                <g:message error="${it}" /><br/>
			                            </g:eachError>
			                        </span>
				                </div>
				            </g:hasErrors>
				        </div>             
					</div>   

		           <div class="fieldcontain form-group">
						<label class="control-label col-sm-4" for="transferDate">Transfer Date</label>
					    <div class="col-sm-8"><g:customDatePicker name="transferDate" precision="day" 
					    class="form-control" value="${loanInstance?.special?.transferDate}" type="text" default="none" noSelection="['': '']" />

					        <g:hasErrors bean="${loanInstance?.special}" field="transferDate">
					            <div class="controls">
				                    <span class="help-block">
				                        <g:eachError bean="${loanInstance?.special}" field="transferDate">
				                            <g:message error="${it}" /><br/>
				                        </g:eachError>
				                    </span>
					            </div>
					        </g:hasErrors>
					    </div>             
					</div>
				</div>
				<div class="form-group form-buttons">
					<%--<g:actionSubmit class="btn btn-primary" value="${message(code: 'default.button.update.label', default: 'Update')}" />--%>
					<g:submitButton class="btn btn-primary" name="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</div>
			</g:form>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link controller="loanInquiry" action="show" id="${loanInstance.id}">View Loan Account</g:link></li>                
            </ul>
        </content>
	</body>
</html>
