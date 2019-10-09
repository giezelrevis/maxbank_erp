
<%@ page import="icbs.deposit.DocInventory" %>
<!DOCTYPE html>
    <html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'docInventory.label', default: 'DocInventory')}" />
		<title>Document Inventory</title>
	</head>
	<body>
            <content tag="main-content">   
		<div id="list-docInventory" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        
                        <g:form>
                                <div class="row">
                                    <div class=" col-md-2">
                                         <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" onchange="this.form.submit()" />
                                    </div>
                                    <div class="col-md-4">
                                        <g:select id="searchType" name="searchType" from="${icbs.lov.DocInventoryType.list(sort: "description")}" optionKey="id"  onchange="this.form.submit()" optionValue="description" required="" value="${params?.searchType}" class="many-to-one form-control"  />       
                                    </div><!-- /.col-lg-6 -->
                                    <div class="input-group col-md-6">
                                        <input id="searchQuery"name="query"type="text" class="form-control" value="${params?.query}" onchange="this.form.submit()">
                                        <span class="input-group-btn">
                                          <g:submitButton name="search" value="Search" class="btn btn-primary" />
                                        </span>
                                    </div><!-- /input-group -->
                                </div><!-- /.col-lg-6 -->
                        </g:form>
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <thead>
					<tr>	
                                                <g:sortableColumn property="type" title="${message(code: 'docInventory.type.label', default: 'Document Inventory Type')}" />
                                                <g:sortableColumn property="branch" title="${message(code: 'docInventory.seriesStart.label', default: 'Branch')}" />
                                                <g:sortableColumn property="seriesStart" title="${message(code: 'docInventory.seriesStart.label', default: 'Series Start')}" />
                                                <g:sortableColumn property="seriesEnd" title="${message(code: 'docInventory.seriesEnd.label', default: 'Series End')}" />
                                                <g:sortableColumn property="isCanceled" title="${message(code: 'docInventory.isCanceled.label', default: 'Is Canceled')}" />
                                                <g:sortableColumn property="canceledAt" title="${message(code: 'docInventory.canceledAt.label', default: 'Canceled At')}" />
						<th><g:message code="docInventory.canceledBy.label" default="Canceled By" /></th>
          
						<th>Status</th>
                                                <th>Action</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${docInventoryInstanceList}" status="i" var="docInventoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td>${fieldValue(bean: docInventoryInstance, field: "type.description")}</td>
                                                <td>${docInventoryInstance?.branch?.name}</td>
						<td>${docInventoryInstance?.seriesStart}</td>
                                                <td>${docInventoryInstance?.seriesEnd}</td>
                                                 <td><g:formatBoolean boolean="${docInventoryInstance.isCanceled}" /></td>
                                                <td><g:formatDate format="yyyy-MM-dd" date="${docInventoryInstance.canceledAt}" /></td>
                                                <td>${fieldValue(bean: docInventoryInstance, field: "canceledBy.username")}</td>
                                                <td>${fieldValue(bean: docInventoryInstance, field: "status.description")}</td>                                   
                                                 <g:if test="${docInventoryInstance.usageCount > 0}">
                                                <td>
                                                    <g:link action="show" id="${docInventoryInstance.id}" class="btn btn-primary">View</g:link>
                                                </td>
                                                </g:if>
                                                <g:else>
                                                 <td>
                                                    <!-- <g:link action="edit" id="${docInventoryInstance.id}" class="btn btn-primary">Edit</g:link> -->
                                                    <g:link action="show" id="${docInventoryInstance.id}" class="btn btn-primary">View</g:link>
                                                </td>
                                                </g:else>
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${DocInventoryInstanceCount ?: 0}" params="${params}" />
			</div>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                         <li><g:link class="create" action="create">Create Document Inventory</g:link></li>
		</ul>
            </content>
	</body>
</html>
