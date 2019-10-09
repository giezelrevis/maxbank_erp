
<%@ page import="icbs.admin.Holiday" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'GLReports.label', default: 'GL Reports')}" />
		<title>General Ledger Reports</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">GL Reports</span>
		</content>

            <content tag="main-content">   
		<div id="list-Reports" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>

                        <a href = "http://192.168.0.12:8080/jasperserver" target="blank"> login to jasper </a>
                </div>
            </content>
            <content tag="main-actions">
                <ul>
                    
                </ul>
            </content>
	</body>
</html>
