<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="customerHelper.js"/>
        <asset:javascript src="depositHelper.js"/>
        <title>CIF Reports</title>
        <g:javascript>
            var modal;
            function updateCustomerDetailsForm(params){
                icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
            }
            function initializeCustomerSearchModal(){
                modal = new icbs.UI.Modal({id:"customerDetailsModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:updateCustomerDetailsForm});
            }
        </g:javascript>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                    <div class="box-body">
                        <div class="alert alert-info alert-dismissable">
                            <i class="fa fa-info"></i>
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <b>Message</b> <div class="message" role="status">${flash.message}</div>
                        </div>
                    </div>
            </g:if>
            <g:hasErrors bean="${fundTransferInstance}">
                <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">

                            </div>
                            <g:eachError bean="${fundTransferInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            <fieldset>
                <legend>Generate Individual Customer Report</legend>
                <g:form action="createReport">
                    <g:hiddenField name="type" value="individual"/>
                    <g:hiddenField name="_format" value="PDF"/>
                    <g:hiddenField name="_name" value="Individual CIF REPORT"/>
                    <g:hiddenField name="_file" value="customers"/>
                    <fieldset class="form-group">
                        <div id="customerDetailsDiv">
                            <g:render template='/customer/details/customerDetails' model="[customerInstance:customerInstance,boxName:'Customer Information']"/>
                        </div>
                        <input type="button" href="#"class="btn btn-secondary"onclick="initializeCustomerSearchModal();modal.show()"value="Search"/>
                        <input type="submit"class="btn btn-primary" value="Generate Individual Report">
                    </fieldset>
                </g:form>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link action="customerSearch"  
                onclick="return confirm('Are you sure you want to return to Customer Search?');">Return to Customer Search</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
