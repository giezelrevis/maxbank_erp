
<%@ page import="icbs.admin.Module" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'module.label', default: 'Module')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
            <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Module List</span>
            </content>
            <content tag="main-content">   
		<div id="list-module" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        
			<%-- div class="table-responsive" --%>
            <table class="table table-bordered table-rounded table-striped table-hover" id="tblmodule">
                <thead>
					<tr>
					<th>Name</th>
					<th>Parent Module</th>
					<th>Is On Menu</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${moduleInstanceList}" status="i" var="moduleInstance">
					<tr>
					
						<td>${fieldValue(bean: moduleInstance, field: "name")}</td>
					
						<td>
							<g:if test="${moduleInstance.parentModuleCode}">
								${Module.findByCode(moduleInstance.parentModuleCode).name}
							</g:if>
						</td>
					
						<td><g:formatBoolean boolean="${moduleInstance.isOnMenu}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
                        <script>
                             $(document).ready(function() {
                                $('#tblmodule').DataTable({
                                  dom: 'Bfrtlip',
                                 //dom : '<"wrapper"flipt>',
                                  
                                    buttons: [
                                        {
                                            extend: 'print',
                                            customize: function ( win ) {
                                                $(win.document.body)
                                                    .css( 'font-size', '10pt' )
                                                    .prepend(
                                                        '<img src="icbs/assets/logo.png" style="position:absolute; top:0; left:0;" />'
                                                    );

                                                $(win.document.body).find( 'table' )
                                                    .addClass( 'compact' )
                                                    .css( 'font-size', 'inherit' );
                                            }
                                        }
                                    ]   
                                });
                                
                               $('.buttons-print').hide();
                            } );

                        </script>
                     <%-- /div %-->
			<%-- div class="pagination">
				<g:paginate total="${ModuleInstanceCount ?: 0}" params="${params}" />
			</div --%>
		</div>
            </content>
            <content  tag="main-actions">
                <ul>
                	<li><a href="#" onclick="$('.buttons-print').click();">Print</a></li>
				</ul>
            </content>
	</body>
</html>
