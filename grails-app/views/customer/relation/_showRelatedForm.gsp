<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div class="section-container">
    <fieldset><legend class="section-header">Relationships</legend>
    <div id="grid">
            <div class="box-body table-responsive no-padding">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <tr> 
                                    <td><label>Customer ID</label></td>
                                    <td><label>Name</label></td>
                                    <td><label>Customer Address</label></td>
                                    <td><label>Customer Type</label></td>
                                    <td><label>Customer Relationship</label></td>
                                    <td><label>Action</label></td>

                                </tr>
                                <g:each in="${customerInstance?.relations}" status="i" var="relation">
                                    <g:if test="${relation.status?.id!=3}">
                                        <tr>
                                                <td><g:link action="customerInquiry" id="${relation?.customer2?.id}">${relation?.customer2?.customerId}</g:link></td>
                                             
                                             <td>
                                               ${relation?.customer2?.displayName}
                                             </td>
                                             <td>
                                                 <g:set var="concatenatedAddress" value="${relation?.customer2?.addresses?.find{it.isPrimary==true}}"/>
                                                 <g:if test="${concatenatedAddress!=null}">
                                                     ${concatenatedAddress.address1 +", " + concatenatedAddress.address2 +", " +concatenatedAddress.address3}
                                                 </g:if>
                                             </td>
                                             <td>
                                                ${relation?.customer2?.type?.description}
                                             </td>
                                             <td>
                                                ${relation?.type?.itemValue}
                                             </td>
                                             <td>
                                                 <input type="button" class="btn btn-secondary" value="Edit" onclick="editRelationship(${relation?.id})"/>
                                                 <!--
                                                 <input type="button" class="btn btn-secondary" value="Delete" onclick="deleteRelationship(${relation?.id})"/>
                                                 -->
                                             </td>
                                        </tr>
                                    </g:if>
                                </g:each>        
                            </table>
                <div class="pagination">
                        <g:paginate total="${domainInstanceCount ?: 0}"/>
                </div>
            </div>
    </div>
    </fieldset>
</div>
</div>    