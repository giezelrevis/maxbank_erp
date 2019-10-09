<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.cif.CustomerInfobase" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>

<g:hiddenField id="Customer_status" name="Customer_status" value="${customerInstance?.status}"/>
<g:hiddenField id="customer" name="customer.id" value="${customerInstance?.id}"/>
    <div class="section-container">
        <fieldset>
            <legend class="section-header"><g:if test="${boxName}">${boxName}</g:if><g:else>Principal Owner Details</g:else></legend>
            
                    <table class="table table-bordered table-striped">
                        <tbody>
                            <tr>
                                <td style="font-weight:bold" width="30%">Customer ID</td>
                                <td width="70%"><g:link controller="customer" action="customerInquiry" id="${customerInstance?.id}">${customerInstance?.customerId}</g:link></td>
                            </tr>
                            <tr>
                                <g:if test="${customerInstance?.type?.id==1}">
                                    <td style="font-weight:bold" width="30%">Customer Name</td>
                                </g:if>    
                                <g:else>
                                    <td style="font-weight:bold" width="30%">Company Name</td>
                                </g:else>
                                <td width="70%">${customerInstance?.displayName}</td>
                            </tr>
                            <tr>
                                 <g:if test="${customerInstance?.type?.id==1}">
                                    <td style="font-weight:bold" width="30%">Date Of Birth</td>
                                </g:if>    
                                <g:else>
                                    <td style="font-weight:bold" width="30%">Registration Date</td>
                                </g:else>
                                <td width="70%"><g:formatDate format="MM/dd/yyyy" date="${customerInstance?.birthDate}"/></td>
                            </tr>
                            <tr>
                                <g:set var = "address" value="${customerInstance?.addresses?.find{it.isPrimary==true}}"/>
                                <td style="font-weight:bold" width="30%">Address</td>
                                <g:if test="${address}">
                                    <td width="70%">${address?.address1}<br>
                                     ${address?.address2}<br>
                                     ${address?.town?.description}<br>
                                     ${address?.address3}<br>
                                    </td>
                                </g:if>
                                <g:else>
                                    <td width="70%">N/A</td>
                                </g:else>
                                
                            </tr>
                        <tbody>
                    </table>        
<g:if test="${CustomerInfobase.findAllByCustomerAndStatus(customerInstance,ConfigItemStatus.get(2))}">
  <div class="col-xs-12 col-sm-12">
    <div class="section-container">
      <fieldset>
       <legend class="section-header">Customer Infobase</legend>
          <div class="infowrap" style="background-color: #ffff99;">
            <g:each in="${CustomerInfobase.findAllByCustomerAndStatus(customerInstance,ConfigItemStatus.get(2))}" status="i" var="infobase">
              <g:if test="${infobase.status.id==2}">
                <dd>
                  ${fieldValue(bean: infobase, field: "infoMessage")}
                </dd>   
              </g:if>
            </g:each>
        </div>
      </fieldset>
    </div>
  </div>    
</g:if>           
            <div class="infowrap">
                <dl class="dl-horizontal">
                   <dd><g:if test="${(customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" style="float:right" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></dd>
                </dl>
            </div>
        </fieldset>
    </div>
