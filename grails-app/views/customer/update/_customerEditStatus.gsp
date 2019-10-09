<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<div id="updateCustomerStatusDiv">        
            <g:if test="${message}">
                <div id= "updateStatusMessage" class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${message}</div>
                    </div>
                </div>
                <script>
                    alertify.alert(AppTitle,"Customer Status Successfully Updated!", function(){
                    
                    $('#updateCustomerStatusModal').modal('hide');
                    var x1 = "/icbs/customer/customerInquiry/"+${params.id}
                    console.log("x1: "+x1);
                    window.location = x1;
                    });  
                </script>    
            </g:if>
            <g:hasErrors bean="${customerInstance}">
                <div id= "updateStatusError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            There are errors. The errors are highlighted in red
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            <g:if test="${!saved}">
                <g:form name ="customerUpdateStatusForm"id="customerUpdateStatusForm">
                    <g:hiddenField name="id" id="id" value="${customerInstance?.id}"/>
                    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'status', 'has-error')} ">
                        <label class="control-label col-sm-4"for="status">
                                <g:message code="customer.status.label" default="Customer Status" />
                        </label>
                        <div class="col-sm-8">
                            <g:select id="status" name="status.id" from="${icbs.lov.CustomerStatus.findAllByStatusAndIdNotInList(true,['5'])}" optionKey="id" optionValue="description" value="${customerInstance?.status?.id}" class="form-control"/>
                            <g:hasErrors bean="${customerInstance}" field="status">
                                <div class="controls">
                                    <span class="help-block">
                                        <g:eachError bean="${customerInstance}" field="status">
                                            <g:message error="${it}" /><br/>
                                        </g:eachError>
                                    </span>
                                </div>
                            </g:hasErrors>
                        </div>
                    </div>
                </g:form>
            </g:if>
</div>
    
    
    