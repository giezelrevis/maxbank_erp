<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
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
        <asset:javascript src="depositHelper.js"/>
        <title>Deposit Listing/Summary</title>
        <g:javascript>
        </g:javascript>
    </head>
    <body>
        <content tag="main-content">
            <div class="row">
                <form class="form-horizontal row col-md-6">
                   <div class="form-group">
                        <label class="control-label">Deposit Account No.</label>
                        <div class="col-sm-9"><g:textField name="acctNo"value="${depositInstance?.acctNo}" disabled="disabled" class="form-control" /></div>
                    </div>
                </form>
            </div>
            <div class="row">
                <div class="col-md-6">
                   <g:render template='/customer/details/customerDetails' model="[customerInstance:depositInstance?.customer]"/>
                </div>

                <div class="col-md-6">
                   <g:render template='/deposit/details/depositDetails' model="[depositInstance:depositInstance]"/> 

                </div>
            </div>
            <div class="row">
                <div id="showPassbookFormDiv">
                    <g:render template="passbook/viewGrid"/>
                </div>
            </div>
            <div class="modal" id="addPassbookModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Passbook</h4>
                        </div>
                        <div class="modal-body">
                            <div id="createRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="savePassbook()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editPassbookModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Passbook</h4>
                        </div>
                        <div class="modal-body">
                            <div id="editRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updatePassbook()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="addPassbook()">Issue a new Passbook</a></li>
                </g:if>
                <li><g:link action="depositInquiry" id="${depositInstance?.id}"  
                                                    onclick="return confirm('Are you sure you want to return to Deposit Inquiries page?');">Return to Deposit Inquiry Page</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
