
<%@ page import="icbs.loans.GroupRecord" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'group.label', default: 'Group')}" />
		<title>View Group</title>
        <g:javascript>
            function updateStatusAjax() {
                $.ajax({
                    type: 'POST',
                    data: $('#update-status-form').serialize(),
                    url: "${createLink(controller :'group', action:'updateStatusAjax')}",
                    success: function(msg){
                        jQuery('#update-status-modal .modal-body').html(msg);
                        $('#update-status-modal').on('hidden.bs.modal', function() {
                            location.reload(true);
                        });
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function showUpdateStatus() {
                modal = new icbs.UI.Modal({id:"update-status-modal", url:"${createLink(controller :'group', action:'showUpdateStatusAjax', params:[id:groupInstance.id])}", title:"Update Status"});                
                modal.show();
            }      
        </g:javascript>
	</head>
	<body>
        <content tag="main-content">   
		<div id="show-group" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            <div class="nav-tab-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
                    <li><a href="#tab_2" data-toggle="tab">Members</a></li>
                </ul>
            </div>
            <div class="tab-content">
				<div class="tab-pane active fade in table-responsive" id="tab_1">
                    <g:render template="details/show"/>
                </div>
                <div class="tab-pane" id="tab_2">
                    <g:render template="members/show"/>
                </div>
			</div>	

			<%--<ol class="property-list group">		
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="group.dateCreated.label" default="Date Created" /></span>
					
					<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${groupInstance?.dateCreated}" /></span>					
				</li>
				</g:if>			
			</ol>--%>

            <div class="modal" id="update-status-modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Update Status</h4>
                        </div>
                        <div class="modal-body">
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateStatusAjax()">Save</a>
                        </div>
                    </div>
                </div>
            </div>
		</div>
        </content>
     	<content tag="main-actions">
            <ul>
                <li><g:link class="list" action="index">Search Group</g:link></li>
                <li><g:link action="edit" id="${groupInstance?.id}">Update Group</g:link></li>
                <li><a href="#" onclick="showUpdateStatus()">Update Status</a></li>
			</ul>
        </content>
	</body>
</html>
