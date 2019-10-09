<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Customer Collateral</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="customerHelper.js"/>
        <g:javascript>
           
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Customer Collateral</span>
	</content>
        <content tag="main-content">
        <div class="row">
            <g:render template="details/customerDetails"model="[customerInstance:customerInstance,boxName:'CIF INFO']"/>
        </div>
           <div class="row">
               <!-- for loan Comaker list table -->
                <div class="section-container">
                    <fieldset><legend class="section-header" >Customer Collateral Details</legend>
                    <div id="grid">
                            <div class="box-body table-responsive no-padding">
                                            <table class="table table-hover table-condensed table-bordered table-striped">
                                                <tr> 
                                                    
                                                    <td><label>Customer ID</label></td>
                                                    <td><label>Customer NAME</label></td>
                                                    <td><label>Customer Collateral Type</label></td>
                                                    <td><label>Appraised Value</label></td>
                                                    <td><label>Status</label></td>
                                                    <td><label>Action</label></td>

                                                </tr>
                                                <g:each in="${results}" status="i" var="customerCollateral">
                                                    
                                                        <tr>
                                                           
                                                            <td>${customerCollateral?.owner?.id}</td>
                                                            <td>${customerCollateral?.owner?.displayName}</td>
                                                            <td>${customerCollateral?.collateralType?.description}</td>
                                                            <td><g:formatNumber number="${customerCollateral?.appraisedValue}" format="###,##0.00" /></td>
                                                            <td>${customerCollateral?.status?.description}</td>
                                                            <td>
                                                                <a href='#' class='btn btn-primary' onclick='callAlertifyFuncCollateralDetails(${customerCollateral?.id});'>View Collateral Details</a>
                                                            </td>
                                                        </tr>
                                                    
                                                </g:each>        
                                            </table>
                                            <script>
                                                function callAlertifyFuncCollateralDetails(xValueCustomerId){
                                                    
                                                    alertify.confirm(AppTitle,"Are you sure you want to view Customer Collateral Details??",
                                                    function(){
                                                       var x1 = "/icbs/collateralManagement/show/"+xValueCustomerId
                                                       window.location = x1;
                                                    },
                                                    function(){
                                                      alertify.error('Canceled');
                                                    });
                                                    
                                                }
                                                
                                            </script>    
                                <div class="pagination">
                                        <g:paginate total="${domainInstanceCount ?: 0}"/>
                                </div>
                            </div>
                    </div>
                    </fieldset>
                </div>            
               <!-- end of list table -->
            </div>
            <div class="modal" id="addRelationshipModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Add Relationship</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                            <div id="createRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="saveRelationship()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="editRelationshipModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Edit Relationship</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                            <div id="editRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updateRelationship()">Save changes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal" id="deleteRelationshipModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">Delete Relationship</h4>
                        </div>
                        <div class="modal-body">
                            <g:render template='/customer/details/customerInfo' model="[customerInstance:customerInstance]"/>
                            <div id="deleteRelatedDiv">
                            
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="#" data-dismiss="modal" class="btn">Close</a>
                            <a href="#" class="btn btn-primary"onclick="updtRelationship()">Delete</a>
                        </div>
                    </div>
                </div>
            </div>            
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link action="customerInquiry" id="${customerInstance?.id}">Back to Customer Inquiry</g:link></li>
            </ul>
        </content>
    </body> 
</html>
