
<%@ page import="icbs.admin.Holiday" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'holiday.label', default: 'Holiday')}" />
	<title>Holiday Information</title>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/holiday')}">Holiday Settings</a>
                <span class="fa fa-chevron-right"></span><span class="current">Holiday Information</span>
        </content>

        <content tag="main-content">   
            <div id="show-holiday" class="content scaffold-show" role="main">
		<g:if test="${flash.message}">
			<!-- <div class="message" role="status">${flash.message}</div> -->
                        <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                        });
                        </script>                            
		</g:if>

		<div class="nav-tab-container">                
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">Holiday Details</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Branches</a></li>
                    </ul>
                </div>

            <div class="tab-content">
            <div class="tab-pane active fade in" id="tab_1">
                <table class="table table-bordered table-rounded table-striped table-hover">
                    <tbody>
                        <tr>
                            <td><label>Holiday Code</label></td>   
                            <td>${holidayInstance?.code}</td>
                        </tr>
                        <tr>
                            <td><label>Holiday Code</label></td>   
                            <td>${holidayInstance?.code}</td>
                        </tr>
                        <tr>
                            <td><label>Holiday Name</label></td>   
                            <td>${holidayInstance?.description}</td>
                        </tr>
                        <tr>
                            <td><label>Holiday Code</label></td>   
                            <td>${holidayInstance?.code}</td>
                        </tr>
                        <tr>
                            <td><label>Holiday Date</label></td>   
                            <td><g:formatDate  format="MM/dd/yyyy" date="${holidayInstance?.holidayDate}" /></td>
                        </tr> 
                        <tr>
                            <td><label>Holiday Type</label></td>   
                            <td>${holidayInstance?.type}</td>
                        </tr> 
                        <tr>
                            <td><label>National Holiday</label></td>   
                            <td>${holidayInstance?.institutionWideHoliday}</td>
                        </tr>
                        <tr>
                            <td><label>Status</label></td>   
                            <td>${holidayInstance?.configItemStatus?.description}</td>
                        </tr>  
                    </tbody>
                </table>
            </div>

            <div class="tab-pane fade in" id="tab_2">       
                <table class="table table-bordered table-rounded table-striped table-hover">
                    <tbody>
			<g:each in="${holidayInstance.branches}" var="branch" >
                            <tr>
                                <td>${branch.name}</td>
                            </tr>
			</g:each>
                    </tbody>
                </table>
            </div>
        </div>
            		
	<g:form name="remove" id="remove" url="[resource:holidayInstance, action:'delete']" method="DELETE">
	</g:form>
	</div>
    </content>

    <content tag="main-actions">
        <ul>
            <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            <li><g:link action="edit" resource="${holidayInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link></li>
            <!--<li><g:actionSubmit  id="deleteHoliday" form="show" action="delete" 
                value="${message(code: 'default.button.delete.label', default: 'Delete')}" /></li>
            -->
            <li><g:actionSubmit id="deleteHoliday"  resource="${holidayInstance}" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="
                            alertify.confirm(AppTitle,'Are you sure you want to delete?',
                                function(){
                                    checkIfAllowed('ADM00304', 'form#remove', 'Remove holiday.', null);
                                },
                                function(){
                                    return;
                                });                      
                "/></li>
		</ul>
                <!--
            <script type="text/javascript">
                    $(document).ready(function() {
                           $( "#deleteHoliday" ).click(function() {
                              checkIfAllowed('ADM00304', 'form#remove', 'Remove holiday.', null); // params: policyTemplate.code, form to be saved
                           });
                    });
                </script>
                -->

    </content>
	</body>
</html>
