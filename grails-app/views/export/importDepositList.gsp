
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Import Deposit Batch Transactions</title>
	</head>

	<body>
            <content tag="main-content">   
		<div  class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        			
		</div>
                <div class="row">
                <g:form name="loanCollForm" action="processImportDeposit" controller="Export" enctype="multipart/form-data">
                    <div class=" form-group fieldcontain">
                        <label class="control-label col-sm-4">
                            <g:message code="inwardCheckClearing.file.label" default="Deposit Batch Transactions File Name" />
                        </label>
                        <div class="col-sm-8">
                            <input type="file" id="checkClearing" name="checkClearing"class="form-control" />
                        </div>
                    </div>
                </g:form>
                </div>                
            </content>
            <content tag="main-actions">
                <ul>
                    <li><button id="checkClearBtn" onclick="$('#loanCollForm').submit()">Process Deposit Batch File</button></li>
		</ul>
            </content>
	</body>
</html>
