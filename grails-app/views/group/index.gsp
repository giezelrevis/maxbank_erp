
<%@ page import="icbs.loans.GroupRecord" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'group.label', default: 'Group')}" />
		<title>Group Maintenance</title>
	</head>
	<body>
		<content tag="main-content">   
		<div id="list-group" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <g:form>            	
            	<div class="row">
				    <div class="col-md-12">
				        <div class="col-md-2">
				             <g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm" onchange="this.form.submit()" />
				        </div>
				        <div class="input-group col-md-10">
				            <g:textField  type="text" name="query" class="form-control" placeholder="Enter Group Name"/>
		                	<div class="input-group-btn">
		                    	<g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
		                	</div>
				        </div>
				    </div>
				</div>				
            </g:form>
            <br />
			<div class="table-responsive">
                <table class="table table-hover table-condensed table-bordered table-striped">
                    <tbody>
						<tr>
							<g:sortableColumn property="id" title="ID" />

							<g:sortableColumn property="name" title="Name" />

							<g:sortableColumn property="type.description" title="Type" />

							<g:sortableColumn property="meetingDate" title="Meeting Date" />

							<td><label>Action</label></td>
						</tr>
					</tbody>
					<tbody>
						<g:each in="${groupInstanceList}" status="i" var="groupInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
							<td>${groupInstance?.id}</td>
							<td>${groupInstance?.name}</td>
							<td>${groupInstance?.type?.description}</td>
							<td><g:formatDate format="MM/dd/yyyy" date="${groupInstance?.meetingDate}"/></td>
							<td><g:link class="btn btn-secondary" action="show" id="${groupInstance.id}">View</g:link></td>
						</tr>
						</g:each>
					</tbody>
				</table>
         	</div>
		 	<div class="pagination">
		 		<g:paginate total="${groupInstanceCount ?: 0}" params="${params}" />
		 	</div>
		</div>
    </content>
    <content tag="main-actions">
	    <ul>
	        <li><g:link class="create" action="create">New Group</g:link></li>
		</ul>
	</content>
	</body>
</html>
