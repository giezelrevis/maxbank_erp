<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Customer Infobase</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="customerHelper.js"/>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Customer Infobase</span>
        </content>
        <content tag="main-content">
        <g:javascript>
            function deleteInfoBaseAjax(x){
                console.log("delete infor base id : "+x);
                var itemValue = x.split("*");
                alertify.confirm(AppTitle,"Are you sure you want to Remove this?",
                  function(){
                            var obj = { 
                                infobaseId: itemValue[0],
                            }; 

                             console.log(JSON.stringify(obj));
                             console.log("Object Loaded iwth data...");

                            $.ajax({
                                type: "POST",
                                contentType: "application/json",
                                url: "${createLink(controller:'Customer', action:'removeCustomerInfoBaseAjax')}",
                                data: JSON.stringify(obj),

                                success: function(data){
                                    alertify.alert(AppTitle,"Customer Info Base Successfully Removed!", function(){      
                                    var x1 = "/icbs/customer/customerInfobase/"+itemValue[1]
                                    console.log("x1: "+x1);
                                    window.location = x1;
                                    });  
                                },
                                error: function(data){

                                    console.log(data);
                                    console.log("error updating");

                                },

                            }); 
                  },
                  function(){
                    alertify.error('Cancel');
                  });               
            
            }
        </g:javascript>    
        <div class="row">
            <g:render template="details/customerDetails"model="[customerInstance:customerInstance,boxName:'CIF INFO']"/>
        </div>
        <div class="section-container">
            <fieldset><legend class="section-header">Infobase</legend>
                <div id="grid">
                    <div class="box-body table-responsive no-padding">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <tr> 
                                    <td><label>Date</label></td>
                                    <td><label>Details</label></td>
                                    <td><label>User</label></td>
                                    <td><label>Action </label></td>
                                </tr>
                                <g:set var="i" value="${0}" />
                                <g:each in="${result}" var="infobase">
                                    <g:if test="${infobase.status?.id!=3}">
                                        <tr>
                                            
                                             <td>
                                               ${infobase?.refDate.format("MM/dd/yyyy")}
                                             </td>
                                             <td>
                                               ${infobase?.infoMessage}
                                             </td>                    
                                             <td>
                                               ${infobase?.user?.username}
                                             </td>
                                             
                                             <td>
                                                <a href="#" class="btn btn-danger" onclick="deleteInfoBaseAjax('${infobase.id}*${params?.id}');">Remove</a>                                                       
                                                        
                                              </td>
                                        
                                        </tr>            
                                    </g:if>
                                    <g:set var="i" value="${i = i + 1}" />
                                </g:each>        
                            </table>
                            <div class="pagination">
                                <g:paginate total="${domainInstanceCount ?: 0}"/>
                            </div>
                        </div>
                </div>
            </fieldset>
        </div>        
        </content>
        <content tag="main-actions">
            <ul>
                <g:if test="${customerInstance}">
                    <li><a href="#" data-toggle="modal" data-target="#infoBaseModal" >Add new Infobase</a></li>
<!-- Modal -->
  <div class="modal fade" id="infoBaseModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" style="color: black;">Customer Info Base</h4>
            </div>
        <div class="modal-body">
            <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                <label class="control-label col-sm-4" style="color: gray;">Information Message: </label>
                <g:textArea class="form-control" name="infoMessage" id="infoMessage" value="" rows="6" cols="40"/>
            </div>
        </div>
        <div class="modal-footer">
            <a href = "#" onclick="validateField();" class="btn btn-primary"> Create InfoBase </a>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
<g:javascript>
    function validateField(){
        var infoMsg = $('#infoMessage').val();
        
        if(infoMsg==null || infoMsg==""){
            notify.message('Information Message Cannot be null!|error|alert');     
        }else{
            var obj = { 
                infoMsg: infoMsg,
                customerTID: ${params.id},
            }; 
            console.log(JSON.stringify(obj));
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "${createLink(controller:'customer', action: 'createCustomerInfoBaseAjax')}",
                data: JSON.stringify(obj),

                success: function(data){
                    console.log("succccccccccccccccccccccc");
                    alertify.alert(AppTitle,"Customer Info Base Successfully Created!", function(){      
                    var x1 = "/icbs/customer/customerInfobase/"+${params.id}
                    console.log("x1: "+x1);
                    $('#infoBaseModal').modal('hide');
                    window.location = x1;
                    });       
                },
                error: function(data){
                    console.log("faileddd")

                },

            });          
        }
   
    
    }

</g:javascript>        
      </div>
      
    </div>
  </div>                    
                </g:if>
                <g:else>
                    <li><button disabled>Add new Infobase</button></li>
                </g:else>
                <li><g:link action="customerInquiry" id="${customerInstance?.id}">Back to Customer Inquiry</g:link></li>
            </ul>
        </content>
    </body> 
</html>
        

