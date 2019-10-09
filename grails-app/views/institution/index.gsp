
<%@ page import="icbs.admin.Institution" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'institution.label', default: 'Institution')}" />
		<title>Institution Settings</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Institution Settings</span>
            </content>
		<content tag="main-content">
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
                        <g:form>
                                <div class="row">
                                    <div class=" col-md-2">
                                         <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" onchange="this.form.submit()" />
                                    </div>
                                   
                                    <div class="input-group col-md-10">
                                        <input id="searchQuery"name="query"type="text" class="form-control" value="${params?.query}" onchange="this.form.submit()">
                                        <span class="input-group-btn">
                                          <g:submitButton name="search" value="Search" class="btn btn-primary" />
                                        </span>
                                    </div><!-- /input-group -->
                                </div><!-- /.col-lg-6 -->
                        </g:form>
			<table class="table table-bordered table-rounded table-striped table-hover">
				<thead>
					<tr>
						<g:sortableColumn property="id" title="${message(code: 'institution.id.label', default: 'ID')}" />
                                                <g:sortableColumn property="paramCode" title="${message(code: 'institution.paramCode.label', default: 'Param Code')}" />
                                                <g:sortableColumn property="caption" title="${message(code: 'institution.caption.label', default: 'Caption')}" />
                                                <g:sortableColumn property="paramValue" title="${message(code: 'institution.paramValue.label', default: 'Param Value')}" />
                                                <th>Action</th>
					
					</tr>
				</thead>
				<tbody>
					<g:each in="${institutionInstanceList}" status="i" var="institutionInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
                                                        <td>${fieldValue(bean: institutionInstance, field: "id")}</td>
							<td>${fieldValue(bean: institutionInstance, field: "paramCode")}</td>
						
							<td>${fieldValue(bean: institutionInstance, field: "caption")}</td>
							
							<td>${fieldValue(bean: institutionInstance, field: "paramValue")}</td>
                                                        <td><button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#instutionmodal${i}">Edit</button></td> 
                                                     
						</tr>
                                                
                                                <!-- START MODAL -->
                                                <!-- Modal -->
                                            <div id="instutionmodal${i}" class="modal fade" role="dialog">
                                              <div class="modal-dialog">

                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        <h4 class="modal-title" style="color: black;">Institution Details</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="fieldcontain form-group">
                                                            <label class="control-label col-sm-4" style="color: gray;">Param Code: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="pcode${i}" name="glcode" value="${fieldValue(bean: institutionInstance, field: "paramCode")}" readonly="readonly"/></div>
                                                        </div>
                                                        <div class="fieldcontain form-group ">
                                                            <label class="control-label col-sm-4" style="color: gray;">Caption: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="caption${i}" name="glcode" value="${fieldValue(bean: institutionInstance, field: "caption")}" readonly="readonly"/></div>
                                                        </div>
                                                         <div class="fieldcontain form-group">
                                                            <label class="control-label col-sm-4" style="color: gray;">Param Value: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="paramvalue${i}" name="glcode" value="${fieldValue(bean: institutionInstance, field: "paramValue")}"/></div>
                                                        </div>
                                                       
                                                       
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-primary" onclick = "alertifyDialog(${i});">Save</button>    
                                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                                    </div>
                                                    
                                                    <g:javascript>
                                                   
                                                        function alertifyDialog (x){
                                                        if(document.getElementById("paramvalue"+x).value == null || document.getElementById("paramvalue"+x).value==""){
                                                            notify.message('Institution Param value cannot be null!|error|alert');
                                                            return;
                                                        }else{
                                                          alertify.confirm(AppTitle,"Are you sure want update this data",
                                                          function(){

                                                            var obj ={
                                                               paramcode : document.getElementById("pcode"+x).value,
                                                               caption : document.getElementById("caption"+x).value,
                                                               paramval : document.getElementById("paramvalue"+x).value
                                                            };


                                                            $.ajax({
                                                               type: 'POST',
                                                                contentType: "application/json",
                                                                url:'${createLink(controller:'institution', action:'updateParamvalue')}',
                                                                data: JSON.stringify(obj),
                                                                success: function(data) {
                                                                        
                                                                      alertify
                                                                        .alert(AppTitle,"Successfully Updated an Institution!", function(){
                                                                            $('#instutionmodal'+x).modal('hide');
                                                                          location.reload();
                                                                        });
                                                                      
                                                                },
                                                                error: function(data) {

                                                                location.reload();
                                                                }
                                                            });


                                                            
                                                          },
                                                          function(){
                                                            alertify.error('Canceled');
                                                          });
                                                        }
                                                        
                                                    }
                                                    </g:javascript>
                                                </div>

                                              </div>
                                            </div>  

                                                <!--END MODAL-->
                                                
					</g:each>
				</tbody>
			</table>
                        <div class="pagination">
				<g:paginate total="${InstitutionInstanceCount ?: 0}" params="${params}" />
			</div>
		</content>

                    <!-- Modal -->
                       

                  
                  
                   <!-- End Modal -->>
                
		<content tag="main-actions">
			<ul>
				<li><g:link onclick="window.print();">Print</g:link></li>
                                <li><a href="#" id="inscreate" data-toggle="modal" data-target="#createInstitution" >New Institution</a></li>
                                    <div id="createInstitution" class="modal fade" role="dialog">
                                              <div class="modal-dialog">

                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        <h4 class="modal-title" style="color: black;">New Institution Details</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="fieldcontain form-group">
                                                            <label class="control-label col-sm-4" style="color: gray;">Param Code: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="crtpcode" name="crtpcode" value="" /></div>
                                                        </div>
                                                        <div class="fieldcontain form-group ">
                                                            <label class="control-label col-sm-4" style="color: gray;">Caption: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="crtcaption" name="crtcaption" value="" /></div>
                                                        </div>
                                                         <div class="fieldcontain form-group">
                                                            <label class="control-label col-sm-4" style="color: gray;">Param Type: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="crtparamtype" name="crtparamtype" value=""/></div>
                                                        </div>                                                        
                                                         <div class="fieldcontain form-group">
                                                            <label class="control-label col-sm-4" style="color: gray;">Param Value: </label>
                                                            <div class="col-sm-8"><g:textField class="form-control" id="crtparamvalue" name="crtparamvalue" value=""/></div>
                                                        </div>
                                                       
                                                       
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-primary" onclick = "validateInstFields();">Save</button>    
                                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                                    </div>
                                                    
                                                    <g:javascript>
                                                        function validateInstFields(){
                                                            console.log("pending peding insss");
                                                            
                                                            var crtpcode = $('#crtpcode').val();
                                                            var crtcaption = $('#crtcaption').val();
                                                            var crtparamtype = $('#crtparamtype').val();
                                                            var crtparamvalue = $('#crtparamvalue').val();
                                                            if(crtpcode=="" || crtpcode==null){
                                                                notify.message('Institution Param code cannot be null!|error|alert'); 
                                                            }
                                                            else if(crtcaption=="" || crtcaption==null){
                                                                notify.message('Institution Caption cannot be null!|error|alert'); 
                                                            }
                                                            else if(crtparamtype=="" || crtparamtype==null){
                                                                notify.message('Institution Param type cannot be null!|error|alert'); 
                                                            }
                                                            else if(crtparamvalue=="" || crtparamvalue==null){
                                                                notify.message('Institution Param value cannot be null!|error|alert'); 
                                                            }
                                                            else{
                                                                alertify.confirm(AppTitle,"Are you sure you want to create this Institution ?",
                                                                  function(){
                                                                    var obj ={
                                                                        paramcode : crtpcode,
                                                                        caption : crtcaption ,
                                                                        paramval : crtparamvalue,
                                                                        paramtype : crtparamtype 
                                                                    };
                                                                    console.log(JSON.stringify(obj));
                                                                    $.ajax({
                                                                         type: 'POST',
                                                                         contentType: "application/json",
                                                                         url:'${createLink(controller:'institution', action:'createNewInstitutionAjax')}',
                                                                         data: JSON.stringify(obj),
                                                                         success: function(data) {

                                                                            alertify.alert(AppTitle,"Successfully created new Institution!", function(){
                                                                                location.reload();
                                                                            });

                                                                         },
                                                                         error: function(data) {

                                                                         
                                                                         }
                                                                     });
                                                                    
                                                                    
                                                                  },
                                                                  function(){
                                                                    alertify.error('Canceled');
                                                                  });
                                                            }
                                                        }
                                                    </g:javascript>
                                                </div>

                                              </div>
                                            </div>  

                                                <!--END MODAL-->                                
                                <script>
                                </script>
			</ul>
		</content>
	</body>
</html>
