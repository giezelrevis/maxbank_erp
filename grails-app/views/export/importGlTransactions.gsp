<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Import General Ledger Transactions</title>
	</head>
	<body>
            <content tag="main-content">   
		<div  class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				
                                <script>
                                    $(function(){
                                        var x = '${flash.message}';
                                        console.log("x value: "+x);
                                        
                                        var x1 = "/icbs/export/importGlTransactions"
                                        
                                        alertify.alert(AppTitle,""+x, function(){
                                          //window.location = x1;
                                        });



                                    });
                                </script>
			</g:if>
                        			
		</div>
                <div class="row">
                <g:form name="loanCollForm" action="processImportGl" controller="Export" enctype="multipart/form-data">
                    <div class=" form-group fieldcontain">
                        <label class="control-label col-sm-4">
                            <g:message code="inwardCheckClearing.file.label" default="Branch" />
                        </label>
                        <div class="col-sm-8">
                          <g:select id="branch" name="branch"  required="true" noSelection="${['':'']}" from="${icbs.admin.Branch.list()}" value="" optionKey="id" optionValue="name" class="form-control"/>
                        </div>
                    </div>
                    <div class=" form-group fieldcontain">
                        <label class="control-label col-sm-4">
                            <g:message code="inwardCheckClearing.file.label" default="Batch Name" />
                        </label>
                        <div class="col-sm-8">
                          <g:textField id="name" name="name"  required="true" value="" class="form-control"/>
                        </div>
                    </div>
                    <div class=" form-group fieldcontain">
                        <label class="control-label col-sm-4">
                            <g:message code="inwardCheckClearing.file.label" default="GL Journal Transactions File Name" />
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
                    <li><button id="checkClearBtn" onclick="$('#loanCollForm').submit()">Process GL Transaction File</button></li>
		</ul>
            </content>
	</body>
</html>