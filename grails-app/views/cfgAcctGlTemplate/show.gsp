
<%@ page import="icbs.gl.CfgAcctGlTemplate" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cfgAcctGlTemplate.label', default: 'CfgAcctGlTemplate')}" />
		<title>Account GL Link Template Information</title>
	</head>
	<body>
             <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/cfgAcctGlTemplate')}">Account GL Link Templates</a>
                <span class="fa fa-chevron-right"></span><span class="current">Account GL Link Template Information</span>
            </content>
            <content tag="main-content">
				
                    <div id="show-cfgAcctGlTemplate" class="content scaffold-show" role="main">
                       
                        <g:if test="${cfgAcctGlTemplateInstance?.description}">
                         
                            <span id="type-label" class="property-label" ><h4>Description: <g:fieldValue bean="${cfgAcctGlTemplateInstance}" field="description"/></h4></span>           
                        </g:if>

                        <g:if test="${cfgAcctGlTemplateInstance?.type}">
                            <span id="type-label" class="property-label" ><h4>Type: <g:fieldValue bean="${cfgAcctGlTemplateInstance}" field="type"/></h4></span>   

                        </g:if>	
                      
			<!--<g:form class="form-inline" action="show">
             
				<div class="form-group">
					<g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left" onchange="this.form.submit()" />
				</div>
                                <g:hiddenField id="templateid" name="templateid" value="${params.id}" />
                                
				<div class="right">
					<div class="form-group">
						<g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 350px;" placeholder="Search"/>
					</div>
					<g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
				</div>
			</g:form> -->
			
			<div class="table-responsive">
                            <table class="table table-hover table-condensed table-bordered table-striped" id="tblmodule">
                                <thead>
					<tr>
					
						<g:sortableColumn property="id" title="${message(code: 'cfgAcctGlTemplate.description.label', default: 'id')}" />
					
						<g:sortableColumn property="glCode" title="${message(code: 'cfgAcctGlTemplate.type.label', default: 'Gl Code')}" />
                                                <g:sortableColumn property="glDescription" title="${message(code: 'cfgAcctGlTemplate.type.label', default: 'Gl Description')}" />
                                                
                                                <g:sortableColumn property="ordinalPos" title="${message(code: 'cfgAcctGlTemplate.type.label', default: 'Gl Ordinal Pos')}" />
                                                <g:sortableColumn property="status" title="${message(code: 'cfgAcctGlTemplate.type.label', default: 'Status')}" />
                                                <th>Action</th>
					</tr>
				</thead>
				<tbody>
				
                                    
                                    <g:each in="${cfgAcctGlTemplateInstance.links}" staus="i" var="link" >					
								
                                    <tr>
                                               
						<td>${link.id}</td>
                                                <td>${link.glCode}</td>
                                                <td>${link.glDescription}</td>
                                                
                                                <td>${link.ordinalPos}</td>
                                                <td>${link.status}</td>
                                                <td><g:link controller="cfgAcctGlTemplateDet" action="show" id="${link.id}">View</g:link> </td>
                                                <!--
						<td>${fieldValue(bean: cfgAcctGlTemplateInstance, field: "type")}</td>
                                                -->
                                                
					</tr>
				</g:each>
				</tbody>
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
			</table>
                     </div>
			<div class="pagination">
				<g:paginate total="${CfgAcctGlTemplateInstanceCount ?: 0}" params="${params}" />
			</div>
						</div>
            </content>
             
             <content tag="main-actions">
                <ul>

                    <li>
                    	<g:link class="list" action="index"> Back </g:link>
                    </li>
                    <li>
                    	<g:link action="glLinkCreateNewEntry" id="${params.id}" > Create New GL Link Entry </g:link>
                    </li>                    
                </ul>
            </content>
	</body>
</html>
