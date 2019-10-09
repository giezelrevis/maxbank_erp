
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>DepEd Loan File Processing</title>
	</head>

	<body>
            <content tag="main-content">   
		<div  class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        			
		</div>
                <div class="row">
                <g:form name="DepEdForm" action="processDepEd" controller="Export" enctype="multipart/form-data">
                    <div class=" form-group fieldcontain">
                        <label class="control-label col-sm-4">
                            <g:message code="inwardCheckClearing.file.label" default="DepEd File Name" />
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
                    <li><button id="checkClearBtn" onclick="$('#DepEdForm').submit()">Process DepEd File</button></li>
		</ul>
            </content>
	</body>
</html>
