
<%@ page import="icbs.loans.CreditInvestigation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'creditInvestigation.label', default: 'CreditInvestigation')}" />
		<title>Credit Investigation</title>
	</head>
	<body>
        <content tag="main-content">   
		<div id="list-creditInvestigation" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <g:form>            	
            	<div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				             <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Credit Investigation ID"/>
		                	<div class="input-group-btn">
		                    	<g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
		                	</div>
				        </div>
				    </div>
				</div>				
            </g:form>
            <br />
			<div class="table-responsive">
            	<table class="table table-hover table-condensed table-bordered table-striped">
                <thead>
					<tr>                                                
                                            <g:sortableColumn property="id" title="${message(code: 'creditInvestigation.id.label', default: 'ID')}" />
                                            <td><label>Branch</label></td>
                                            <g:sortableColumn property="id" title="${message(code: 'creditInvestigation.loanApplication.label', default: 'Loan Application')}" />
                                            <td><label>Borrower Name</label></td>
                                            <g:sortableColumn property="recommendation" title="${message(code: 'creditInvestigation.appraisedBy.label', default: 'Appraised By')}" />
                                            <td><label>Appraisal Date</label></td>
                                            <td><label>Action</label></td>
					</tr>
				</thead>
				<tbody>
				<g:each in="${creditInvestigationInstanceList}" status="i" var="creditInvestigationInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>${creditInvestigationInstance?.id}</td>
                                        <td>${creditInvestigationInstance?.loanApplication?.branch?.name}</td>    
                                        <td>${creditInvestigationInstance?.loanApplication?.id}</td>
                                        <td>${creditInvestigationInstance?.loanApplication?.customer?.displayName}</td>
                                        <td>${creditInvestigationInstance?.appraisedBy}</td>
                                        <td><g:formatDate format="MM/dd/yyyy" date="${creditInvestigationInstance?.appraisalDate}"/></td>
                                        <td><g:link class="btn btn-secondary" action="show" id="${creditInvestigationInstance.id}">View</g:link></td>
                                    </tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${CreditInvestigationInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <%--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--%>
                    <li><g:link class="create" action="create">New Credit Investigation</g:link></li>
		</ul>
            </content>
	</body>
</html>
