
<%@ page import="icbs.tellering.TxnCOCI" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>View Check Deposit Details</title>
	</head>
	<body>

        <content tag="main-content">   
		<div id="list-check-details" class="content scaffold-list" role="main">

                    <div class="table-responsive">
                        <table class="table table-bordered table-rounded table-striped table-hover">
                            <thead>
				<tr>
                                    <td>Id</td>
                                    <td>Account Number</td>
                                    <td>Bank</td>
                                    <td>Amount</td>
                                    <td>Check Date</td>
                                    <td>Check Number</td>
                                    <td>Type</td>
                                    <td>Cleared</td>
                                    <td>Clearing Date</td>
				</tr>
                            </thead>
                            <tbody>
				<g:each in="${txnCOCIInstanceList}" status="i" var="txnCOCIInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td>${fieldValue(bean: txnCOCIInstance, field: "id")}</td>
					<td>${fieldValue(bean: txnCOCIInstance, field: "acctNo")}</td>
                                        <td>${fieldValue(bean: txnCOCIInstance, field: "bank.name")}</td>
                                        <td><g:formatNumber number="${txnCOCIInstance?.checkAmt}" format="###,##0.00" /></td>
                                        <td>${txnCOCIInstance?.checkDate?.format('MM/dd/yyyy')}</td>
                                        <td>${fieldValue(bean: txnCOCIInstance, field: "checkNo")}</td>
                                        <td>${fieldValue(bean: txnCOCIInstance, field: "checkType.description")}</td>
                                        <td>${fieldValue(bean: txnCOCIInstance, field: "cleared")}</td>
                                        <td>${txnCOCIInstance?.clearingDate?.format('MM/dd/yyyy')}</td>
                                    </tr>
				</g:each>
                            </tbody>
			</table>
                     </div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
		</ul>
            </content>
	</body>
</html>
