
<%@ page import="icbs.admin.ForexRate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'forexRate.label', default: 'ForexRate')}" />
		<title>Forex Rate Information</title>
	</head>
	<body>
		<content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/forexRate')}">Forex Rates Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Forex Rate Information</span>
		</content>

            <content tag="main-content">   
		<div id="show-forexRate" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                            <script>
                                    $(function(){
                                        var x = '${flash.message}';
                                            //notify.message(x);
                                            console.log('log: '+x);
                                            alertify.alert(AppTitle,""+x, function(){

                                            });
                                    });
                            </script>  
			</g:if>
                        <div class="section-container"> 
                            <fieldset>
                                <legend class="section-header">Forex rate Information</legend>
                                <table class="table table-bordered table-striped">
                                    <tbody>

                                           <tr>
                                                <td style="font-weight:bold" width="30%">Currency</td>
                                                <td width="70%"><g:link controller="currency" action="show" id="${forexRateInstance?.currency?.id}">${forexRateInstance?.currency?.name}</g:link></td>
                                            </tr>
                                           <tr>
                                                <td style="font-weight:bold" width="30%">Date</td>
                                                <td width="70%"><g:formatDate format="MM/dd/yyyy" date ="${forexRateInstance.txnDate}" /></td>
                                            </tr> 
                                           <tr>
                                                <td style="font-weight:bold" width="30%">Rate</td>
                                                <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.rate}"/></td>
                                            </tr>
                                           <tr>
                                                <td style="font-weight:bold" width="30%">PDS Rate</td>
                                                <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.pdsRate}"/></td>
                                            </tr>
                                            <tr>
                                                <td style="font-weight:bold" width="30%">Historical Rate</td>
                                                <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.historicalRate}"/></td>
                                            </tr>
                                            <g:if test="${forexRateInstance?.refRate}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Ref Rate</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.refRate}"/></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${forexRateInstance?.buyRate1}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Buy Rate1</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.buyRate1}"/></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${forexRateInstance?.buyRate2}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Buy Rate2</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.buyRate2}"/></td>
                                                </tr> 
                                            </g:if> 
                                            <g:if test="${forexRateInstance?.buyRate3}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Buy Rate3</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.buyRate3}"/></td>
                                                </tr> 
                                            </g:if>                                             
                                            <g:if test="${forexRateInstance?.buyRate4}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Buy Rate4</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.buyRate4}"/></td>
                                                </tr> 
                                            </g:if>      
                                            <g:if test="${forexRateInstance?.buyRate5}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Buy Rate5</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.buyRate5}"/></td>
                                                </tr> 
                                            </g:if> 
                                            <g:if test="${forexRateInstance?.sellRate1}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Sell Rate1</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.sellRate1}"/></td>
                                                </tr> 
                                            </g:if> 
                                            <g:if test="${forexRateInstance?.sellRate2}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Sell Rate2</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.sellRate2}"/></td>
                                                </tr> 
                                            </g:if> 
                                            <g:if test="${forexRateInstance?.sellRate3}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Sell Rate3</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.sellRate3}"/></td>
                                                </tr> 
                                            </g:if> 
                                            <g:if test="${forexRateInstance?.sellRate4}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Sell Rate4</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.sellRate4}"/></td>
                                                </tr> 
                                            </g:if>
                                            <g:if test="${forexRateInstance?.sellRate5}">
                                                <tr>
                                                    <td style="font-weight:bold" width="30%">Sell Rate5</td>
                                                    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${forexRateInstance?.sellRate5}"/></td>
                                                </tr> 
                                            </g:if> 
                                    </tbody>
                                </table>
                            </fieldset>
                       </div>	
			<g:form url="[resource:forexRateInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
				<g:actionSubmit class="hidden" id="deleteforexRate" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
				</fieldset>
			</g:form>
		</div>
            </content>
             <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                    <li><g:link class="create" action="create"><g:message code="default.newupdate.label" args="[entityName]" default="New Forex Rate" /></g:link></li>
                    <li><g:link action="edit" id="${forexRateInstance.id}">Edit Forex Rate</g:link></li>
                    <li><a href="#" onclick="alertifyConfirmDiagDelete();">Delete Forex Rate</a></li>
                    <script>
                        function alertifyConfirmDiagDelete(){
                            alertify.confirm(AppTitle,"Are you sure want to delete this Forex Rate?",
                            function(){
                              $('#deleteforexRate').click();
                            },
                            function(){
                              alertify.error('Canceled!');
                            });
                        }
                        
                    </script>
                </ul>
            </content>
	</body>
</html>
