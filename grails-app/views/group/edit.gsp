<%@ page import="icbs.loans.GroupRecord" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'group.label', default: 'Group')}" />
		<title>Edit Group</title>
		<g:javascript>
            function updateParentGroupAjax(params) {
                if(params.group2) {
                    $.ajax({
                        type: 'POST',
                        data: {id:params.group2},
                        url: "${createLink(controller:'group', action:'getGroupInfoAjax')}",
                        success: function(msg){        
                            $('#parent-name').val($(msg).find('#group-name').html());
                            $('#parent').val(params.group2);
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }

            function showGroupSearch() {                             
                modal = new icbs.UI.Modal({id:"groupModal", url:"${createLink(controller: 'group', action:'search')}", title:"Search Group", onCloseCallback:updateParentGroupAjax});
                modal.show();                   
            }

            function showMembers() {
                $.ajax({
                    type: 'POST',
                    data: {id:${groupInstance?.id}},
                    url: "${createLink(controller:'group', action:'showMembersAjax2')}",
                    success: function(msg){                     
                        $('#tab_2').html(msg);
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }

            function addMemberAjax(params) {
                if (params.customer2) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${groupInstance?.id}, cid:params.customer2},
                        url: "${createLink(controller:'group', action:'addMemberAjax2')}",
                        success: function(msg){                  
                            showMembers();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }

            function showMemberSearch() {  
                modal = new icbs.UI.Modal({id:"customerDetailsModal", url:"${createLink(controller: 'search', action:'search')}", title:"Search Customer", onCloseCallback:addMemberAjax});
                modal.show();
            }

            function deleteMemberAjax(id) {                
                if (confirm('Are you sure?')) {
                    $.ajax({
                        type: 'POST',
                        data: {id:${groupInstance?.id}, cid:id},
                        url: "${createLink(controller:'group', action:'deleteMemberAjax2')}",
                        success: function(msg){
                            showMembers();
                        },
                        error:function(XMLHttpRequest,textStatus,errorThrown){
                            alert(XMLHttpRequest+textStatus+errorThrown);
                        }
                    });
                }
            }

            icbs.Dependencies.Ajax.addLoadEvent(function(){
                updateParentGroupAjax({group2:"${groupInstance?.parent?.id}"});
            });
        </g:javascript>
	</head>
	<body>
        <content tag="main-content">
		<div id="edit-group" class="content scaffold-edit" role="main">
			<g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
			<g:hasErrors bean="${groupInstance}">
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
			<g:form id="group-form" url="[controller:group, action:'update', id:groupInstance?.id]" method="PUT" >
				<g:hiddenField name="version" value="${groupInstance?.version}" />
				<div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Details</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Members</a></li>
                    </ul>
                </div>		
                <div class="tab-content">
                    <div class="tab-pane active fade in table-responsive" id="tab_1">
                        <g:render template="details/form"/>
                    </div>
                    <div class="tab-pane" id="tab_2">
                        <g:render template="members/list"/>
                    </div>
                </div>
			</g:form>
		</div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:submitButton name="save" value="Save" onclick="jQuery('#group-form').submit()" /></li>
        		<li><g:link action="show" id="${groupInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">Cancel</g:link></li>
            </ul>
        </content>        
	</body>
</html>
