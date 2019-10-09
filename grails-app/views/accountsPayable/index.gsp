
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Accounts Payable Subsidiary Ledger</title>
    </head>
    <body>
	<content tag="main-content">
            <div id="list-accountReceivable" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                </g:if>

                <g:form>            	
            	<div class="row">
                    <div class="col-md-12">
                        <div class="col-md-2">
                             <g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm" onchange="this.form.submit()" />
                        </div>
                        <div class="input-group col-md-10">
                            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Description"/>
                        <div class="input-group-btn">
                        <g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
                        </div>
                        </div>
                    </div>
                </div>
                <g:hiddenField id="module" name="module" value="${module}" />
                </g:form>
            </div>

            </br>
            <div class="table-responsive">
                    <table class="table table-hover table-condensed table-bordered table-striped">
                        <thead>
                                <tr>
                                    <g:sortableColumn property="payable" title="${message(code: 'accountsPayable.description.label', default: 'Payable')}" />
                                    <g:sortableColumn property="bookingDate" title="${message(code: 'accountsPayable.bookingDate.label', default: 'Booking date')}" />
                                    <g:sortableColumn property="balance" title="${message(code: 'accountsPayable.balance.label', default: 'Balance')}" />
                                    <g:sortableColumn property="currency" title="${message(code: 'accountsPayable.currency.label', default: 'Currency')}" />
                                    <td><lable>Action</label></td>
                                </tr>
                        </thead>
                        <tbody>
                        <g:each in="${accountsPayableInstanceList}" status="i" var="accountsPayableInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>${accountsPayableInstance?.payable}</td>                                       
                                    <td><g:formatDate format="MM/dd/yyyy" date="${accountsPayableInstance.bookingDate}"/></td>
                                    <td align="right"><g:formatNumber format="###,###,##0.00" number="${accountsPayableInstance?.balance}"/></td>
                                    <td>${accountsPayableInstance?.currency?.code}</td>
                                    <td><g:link class="btn btn-secondary" action="show" id="${accountsPayableInstance?.id}">View</g:link></td>
                                </tr>
                        </g:each>
                        </tbody>
                </table>
             </div>
        </content>	
		
        <content tag="main-actions">
            <ul>
                <li><g:link controller="home" action="landing">Home</g:link></li>
                <li><g:link action="create">New Accounts Payable Subsidiary Ledger</g:link></li>
                <li><g:link action="printSchedule">Print Schedule of Accounts Payable</g:link></li>                
            </ul>
        </content>
    </body>
</html>
