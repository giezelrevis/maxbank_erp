<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>


<div class="row">
                <div class="col-xs-12 col-sm-12">
                  <div class="section-container">
                    <fieldset>
                        
                        <legend class="section-header">Primary Information</legend>
                        <div class="infowrap">
                            
                             <div class="col-xs-3 col-sm-3">
                                <div style="margin:auto; padding:20px;"><g:if test="${(customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="160px" height="160px"src="${createLink(controller:'Attachment', action:'show', id: (customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></div>
                             </div>
                            
                            
                            <div class="col-xs-8 col-sm-8">
                                
                                         
                             
                                <g:if test="${customerInstance?.type.id==1}">
                                    
                                    <h3 style="font-weight:bold;">${customerInstance?.name3}, ${customerInstance?.name1} ${customerInstance?.name2}</h3>
                                    <p><i>(Last Name, First Name, Middle Name)</i></p>
                                    
                                    
                                    <dl class="dl-horizontal">
                                        <dt>Title</dt>
                                        <dd>${customerInstance?.title?.itemValue}</dd>
                                    </dl>
                                    
                                  
                                   
                                     <dl class="dl-horizontal">
                                        <dt>Initials</dt>
                                        <dd>${customerInstance?.name4}</dd>
                                    </dl>
                                    <dl class="dl-horizontal">
                                        <dt>Gender</dt>
                                        <dd>${customerInstance?.gender?.description}</dd>
                                    </dl>
                                    <dl class="dl-horizontal">
                                        <dt>Date of Birth</dt>
                                        <dd>${customerInstance?.birthDate?.format("MM/dd/yyyy")}</dd>
                                    </dl>
                                    <g:if test="${customerInstance?.birthDate}">
                                    <dl class="dl-horizontal">
                                        <dt>Age</dt>
                                        <dd><g:formatNumber format="####" number="${(customerInstance?.branch?.runDate - customerInstance?.birthDate)/365.25}" /></dd>
                                    </dl>                                        
                                    </g:if>    
                                    <dl class="dl-horizontal">
                                        <dt>DOSRI Classification</dt>
                                        <dd>${customerInstance?.dosriCode?.description}</dd>
                                    </dl>                                    
                                </g:if>
                                <g:else>
                                   
                                    <h3 style="font-weight:bold;">${customerInstance?.name1}</h3>
                                 
                                    <dl class="dl-horizontal">
                                        <dt>Registration Date</dt>
                                        <dd>${customerInstance?.birthDate?.format("MM/dd/yyyy")}</dd>
                                    </dl>
                                </g:else>
                                    
                                       <dl class="dl-horizontal">
                                        <dt>Customer ID</dt>
                                        <dd>${customerInstance?.customerId}</dd>
                                     </dl>
                                      
                                     <dl  class="dl-horizontal">
                                       <dt>Customer Type</dt>
                                        <dd>${customerInstance?.type?.description}</dd>
                                    </dl>
                                    
                                    
                                    
                                      <dl class="dl-horizontal">
                                  <dt>Record Status</dt>
                                  <dd>${customerInstance?.status?.description}</dd>
                                </dl>
                            </div>
                            
                                      </fieldset>
                  </div><!-- end section-container-->
                  
                  
                   <div class="section-container">
                    <fieldset>
                       
                        
                        <legend class="section-header">Contact Information</legend>   
                          
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <tr>
                                        <g:set var="primaryAddress" value="${(customerInstance?.addresses?.find{it.isPrimary==true})}"/>
                                        <td style="font-weight:bold" width="30%">Address</td>
                                        <g:if test="${primaryAddress!=null}">
                                            <td width="70%">${primaryAddress?.address1 + ", "+ primaryAddress?.address2 +", " +primaryAddress?.town.description+", "+primaryAddress?.address3}</td>
                                        </g:if>
                                        <g:else>
                                           <td width="70%">N / A</td>
                                        </g:else>
                                    </tr>
                                    <tr>
                                         <td style="font-weight:bold" width="30%">View More Addresses</td>   
                                         <td width="70%"><g:if test="${customerInstance?.addresses?.size()>0}"><button type="button" class="btn btn-primary" onclick="openMoreAddresses()">View All Addresses</button></g:if><g:else><button class="btn btn-primary" disabled="disabled">View More Addresses</button></g:else></td>
                                    </tr>   
                                    <tr>
                                         <td style="font-weight:bold" width="30%">Customer Contact No</td>   
                                         <td width="70%">${(customerInstance?.contacts?.find{it.isPrimaryPhone ==true})?.contactValue}</td>
                                    </tr>  
                                    <tr>
                                         <td style="font-weight:bold" width="30%">Customer E-Mail Address</td>   
                                         <td width="70%">${(customerInstance?.contacts?.find{it.isPrimaryEmail ==true})?.contactValue}</td>
                                    </tr> 
                                </tbody>
                            </table>    
                    </fieldset>
                  </div><!-- end section-container-->
                </div>
</div>
