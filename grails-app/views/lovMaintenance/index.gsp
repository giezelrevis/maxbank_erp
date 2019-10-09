
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="LOVMaintenance" />
		<title>List of Values Maintenance</title>
	</head>
	<body>
             <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">List of Values Maintenance</span>
            </content>
            <content tag="main-content">
		<g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
		</g:if>
		<table class="table table-bordered table-rounded table-striped table-hover">
                    <thead>
			<tr>
                            <th>List of Value Group</th>					
			</tr>
                    </thead>
			<tbody>
                            <tr>
                                <td><g:link controller="lovMaintenance" class="sizeOfFirmIndex" action="sizeOfFirmIndex">Customer Size of Firm</g:link></td>	
                            </tr>
                            <tr>
                                <td><g:link controller="lovMaintenance" class="customerResidentTypeIndex" action="customerResidentTypeIndex">Customer Resident Type</g:link></td>
                            </tr>   
                            <tr>
                                <td><g:link controller="lovMaintenance" class="townAndMunicipalityIndex" action="townAndMunicipalityIndex">List of Towns/Municipalities</g:link></td>	
                            </tr>
                            <tr>
                                <td><g:link controller="lovMaintenance" class="kindsOfLoanIndex" action="kindsOfLoanIndex">Kind of Loan</g:link></td>	
                            </tr>
                            <tr>
                                <td><g:link controller="lovMaintenance" class="loanProjectIndex" action="loanProjectIndex">Loan Project</g:link></td>	
                            </tr>	
                            <tr>
                                <td><g:link controller="lovMaintenance" class="loanSecurityClassificationIndex" action="loanSecurityClassificationIndex">Loan Security Classification</g:link></td>
                            </tr>
                        </tbody>
		</table>                        
            </content>	
            <content tag="main-actions">
		<ul>
                    <li><g:link onclick="window.print();">Print</g:link></li>
		</ul>
            </content>
	</body>
</html>
