<%@ page import="icbs.loans.CreditInvestigation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'creditInvestigation.label', default: 'CreditInvestigation')}" />
		<title>Update Credit Investigation</title>
		<g:javascript>
			function showAttachments() {
                $.ajax({
                    type: 'POST',
                    data: {id:${creditInvestigationInstance?.id}},
                    url: "${createLink(controller:'creditInvestigation', action:'showAttachmentsAjax2')}",
                    success: function(msg){                     
                        $('#tab_2').html(msg);
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function addAttachmentAjax() {
                var file = (document.getElementById("fileData")).files[0];                                

                var data = new FormData(); 
                data.append("id", ${creditInvestigationInstance?.id});
                data.append("file", file);
                data.append("description", $('#add-attachment-modal #description').val());
                data.append("type", $('#add-attachment-modal #type').val());

                $.ajax({
                    type: 'POST',
                    data: data,
                    contentType: false,
                    processData: false,
                    url: "${createLink(controller:'creditInvestigation', action:'addAttachmentAjax2')}",
                    success: function(msg){
                        $('#add-attachment-modal .modal-body').html(msg);
                        $('#add-attachment-modal').on('hidden.bs.modal', function() {
                            showAttachments();
                        });                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });        
            }            

            function showAddAttachment() {
                modal = new icbs.UI.Modal({id:"add-attachment-modal", url:"${createLink(controller: 'creditInvestigation', action:'showAddAttachmentAjax')}", title:"Add Attachment"});
                modal.show();
            }

            function updateAttachmentAjax() {
                var description = $('#update-attachment-modal #description').val();
                var type = $('#update-attachment-modal #type').val();
                
                $.ajax({
                    type: 'POST',
                    data: {id:$('#attachmentId').val(), description:description, type:type},
                    url: "${createLink(controller:'creditInvestigation', action:'updateAttachmentAjax2')}",
                    success: function(msg){
                        $('#update-attachment-modal .modal-body').html(msg);
                        $('#update-attachment-modal').on('hidden.bs.modal', function() {                        
                            showAttachments();
                        });                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }            

            function showUpdateAttachment(id) { 
                $.ajax({
                    type: 'POST',
                    data: {id:id},
                    url: "${createLink(controller:'creditInvestigation', action:'showUpdateAttachmentAjax2')}",
                    success: function(msg){
                        $('#attachmentId').val(id);
                        $('#update-attachment-modal .modal-body').html(msg);                      
                        $('#update-attachment-modal').modal({show:true});                     
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function deleteAttachmentAjax(id) {
                if (confirm('Are you sure?')) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${creditInvestigationInstance?.id}, attachmentId:id},
                        url: "${createLink(controller:'creditInvestigation', action:'deleteAttachmentAjax2')}",
                        success: function(msg){
                            showAttachments();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }
		</g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="edit-creditInvestigation" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<g:hasErrors bean="${creditInvestigationInstance}">
				<div class="box-body">
	                <div class="alert alert-danger alert-dismissable">
	                    <i class="fa fa-ban"></i>
	                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                    <b>Alert!</b> 
	                    <ul class="errors" role="alert">
	                        There are errors
	                    </ul>            
	                </div>
	            </div>
            </g:hasErrors>
			<g:form id="credit-investigation-form"  url="[controller:creditInvestigation, action:'update', id:creditInvestigationInstance?.id]" method="PUT" >
				<g:hiddenField name="version" value="${creditInvestigationInstance?.version}" />
				<div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Attachments</a></li>
                        <li><a href="#tab_3" data-toggle="tab">Checklist</a></li>
                    </ul>
                </div>		
                <div class="tab-content">
                    <div class="tab-pane active fade in table-responsive" id="tab_1">
                        <g:render template="details/form"/>
                    </div>
                    <div class="tab-pane" id="tab_2">
                        <g:render template="attachments/list"/>
                    </div>
                    <div class="tab-pane" id="tab_3">
                        <g:render template="checklist"/>
                    </div>
                </div>			
			</g:form>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:submitButton id="save" name="save" value="Save" /></li>
            	<script type="text/javascript">
		            $(document).ready(function() {
		               	$( "#save" ).click(function() {
		             		 checkIfAllowed('LON00402', 'form#credit-investigation-form', 'Update branch XXX.', null); // params: policyTemplate.code, form to be saved
		               	});
		            }); 
                 </script>
                <li><g:link class="list" action="show" id="${creditInvestigationInstance.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
            </ul>
        </content>
	</body>
</html>
