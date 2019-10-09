
<%@ page import="icbs.admin.ForexRate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'forexRate.label', default: 'ForexRate')}" />
		<title>Foreign Exchange Rate List</title>
	</head>
	<body>
		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Forex Rates Maintenance</span>
		</content>

            <content tag="main-content">   
		<div id="list-forexRate" class="content scaffold-list" role="main">
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

            <g:form class="form-inline">
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
				</div>
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form>
			
			<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
					<tr>
					
						<g:sortableColumn property="date" title="${message(code: 'forexRate.date.label', default: 'Cut-Date')}" />
                                                
                                                <g:sortableColumn property="currency" title="${message(code: 'forexRate.currency.label', default: 'Currency')}" />
                                                
                                                <g:sortableColumn property="currency2" title="${message(code: 'forexRate.currency2.label', default: 'Convert to Currency')}" />
                                                
						<g:sortableColumn property="rate" title="${message(code: 'forexRate.rate.label', default: 'Rate')}" />
                                                
                                                <g:sortableColumn property="pds_rate" title="${message(code: 'forexRate.pdsRate.label', default: 'PDS Rate')}" />
                                                
                                                <g:sortableColumn property="historicalRate" title="${message(code: 'forexRate.historicalRate.label', default: 'Historical Rate')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${forexRateInstanceList}" status="i" var="forexRateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${forexRateInstance.id}"><g:formatDate format="MM/dd/yyyy" date ="${forexRateInstance.txnDate}" /></g:link></td>

                                                <td>${fieldValue(bean: forexRateInstance, field: "currency.name")}</td>
                                                
                                                <td>${fieldValue(bean: forexRateInstance, field: "currency2.name")}</td>
					
						<td>${fieldValue(bean: forexRateInstance, field: "rate")}</td>
                                                
                                                <td>${fieldValue(bean: forexRateInstance, field: "pdsRate")}</td>
                                                
                                                <td>${fieldValue(bean: forexRateInstance, field: "historicalRate")}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${ForexRateInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><g:link class="create" action="create">New Forex Rate</g:link></li>
	        </ul>
            </content>
	</body>
</html>
