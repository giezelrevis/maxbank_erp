<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Customer Relationships</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="customerHelper.js"/>
        <g:javascript>
            function updateCustomerRelatedForm(){
                icbs.Customer.Relation('relationForm',"${createLink(controller : 'customer', action:'customerShowRelatedFormAjax')}",{id:${customerInstance?.id}});
            }
            function addRelationship(params){
                if(params){
                    icbs.Customer.Relation('add',"${createLink(controller : 'customer', action:'customerCreateRelatedAjax')}",{id:${customerInstance?.id},customerRelationshipType:${customerInstance?.type?.id},customer2:params.customer2});
                }else{
                     icbs.Customer.Relation('add',"${createLink(controller : 'customer', action:'customerCreateRelatedAjax')}",{id:${customerInstance?.id},customerRelationshipType:${customerInstance?.type?.id}});
                }
               
            }
            //Add new customer relation
            function saveRelationshipAuthCallback(){
                icbs.Customer.Relation('save',"${createLink(controller : 'customer', action:'customerSaveRelatedAjax')}",jQuery('#createRelatedDiv :input').serialize());
            }
            //Override for adding new customer relation
            function saveRelationship(){
                checkIfAllowed('CIF00100', saveRelationshipAuthCallback); // params: policyTemplate.code, form to be saved
            }

            function editRelationship(id){
                icbs.Customer.Relation('edit',"${createLink(controller : 'customer', action:'customerEditRelatedAjax')}",{id:id,customerRelationshipType:${customerInstance?.type?.id}});
            }
            function deleteRelationship(id){
                icbs.Customer.Relation('delete',"${createLink(controller : 'customer', action:'customerDeleteRelatedAjax')}",{id:id,customerRelationshipType:${customerInstance?.type?.id}});
            }
            
            //Update Customer Relationship details
            function updateRelationshipAuthCallback(){
                icbs.Customer.Relation('update',"${createLink(controller : 'customer', action:'customerSaveRelatedAjax')}",jQuery('#editRelatedDiv :input').serialize());
            }
            //Override for customer relationship update
            function updateRelationship(){
                checkIfAllowed('CIF00100', updateRelationshipAuthCallback); // params: policyTemplate.code, form to be saved
            }
            
            
            function updtRelationship(){
                icbs.Customer.Relation('update',"${createLink(controller : 'customer', action:'customerSaveRelatedAjax')}",jQuery('#deleteRelatedDiv :input').serialize());
            }
            
            icbs.Dependencies.Ajax.addLoadEvent(function(){
                ;$('#editRelationshipModal').on('hidden.bs.modal', function () {
                    updateCustomerRelatedForm();
                })
                $('#addRelationshipModal').on('hidden.bs.modal', function () {
                    updateCustomerRelatedForm();
                });
                $('#deleteRelationshipModal').on('hidden.bs.modal', function () {
                    updateCustomerRelatedForm();
                });
            })
            var modal;
            function initializeAddRelationSearchModal(){
                modal = new icbs.UI.Modal({id:"addRelationSearchModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:addRelationship});
            }
        </g:javascript>
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Customer Related</span>
        </content>
        <content tag="main-content">
        <div class="row">
            <g:render template="details/customerDetails"model="[customerInstance:customerInstance,boxName:'CIF INFO']"/>
        </div>
           <div class="row">
                <div id="showRelatedFormDiv">
                    <g:render template='relation/showRelatedForm'/>
                </div>
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
                <g:if test="${customerInstance}">
                    <li><a href="#" onclick="addRelationship()">Add new Relationship</a></li>
                </g:if>
                <g:else>
                    <li><button disabled>Add New Relationship</button></li>
                </g:else>
                <li><g:link action="customerInquiry" id="${customerInstance?.id}">Back to Customer Inquiry</g:link></li>
            </ul>
        </content>
    </body> 
</html>
        

