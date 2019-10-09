<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<div id="customerUpdateCreditLimitDiv">
            <g:if test="${message}">
                <div id= "updateCreditLimitMessage" class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${message}</div>
                    </div>
                </div>
                <script>
                    alertify.alert(AppTitle,"Credit Limit Successfully Updated!", function(){
                        $('#updateCustomerCreditLimitModal').modal('hide');
                        var x1 = "/icbs/customer/customerInquiry/"+${params.id}
                        console.log("x1: "+x1);
                        window.location = x1;
                    });  
                </script>                 
            </g:if>
            <g:hasErrors bean="${customerInstance}">
                <div id= "updateCreditLimitError" class="box-body">
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
                <g:form name="tangina" id="tangina">
                    <g:hiddenField name="id" id="id" value="${customerInstance?.id}"/>
                    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'creditLimit', 'has-error')} required">
                        <label class="control-label col-sm-4" for="creditLimit">
                            <g:message code="customer.creditLimit.label" default="Credit Limit" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="col-sm-8">
                            <g:field name="creditLimit" value="${customerInstance?.creditLimit}" required="" class="form-control"/>
                            <g:hasErrors bean="${customerInstance}" field="creditLimit">
                                <div class="controls">
                                    <span class="help-block">
                                        <g:eachError bean="${customerInstance}" field="creditLimit">
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