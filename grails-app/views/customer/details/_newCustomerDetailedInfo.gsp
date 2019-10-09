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
<div class="row">
    <div class="col-xs-12 col-sm-12">
      <div class="section-container">
        <fieldset>
            <legend class="section-header"><g:if test="${boxName}">${boxName}</g:if><g:else>Principal Owner Details</g:else></legend>
            <div class="infowrap">
                 <div class="col-xs-3 col-sm-3">
                    <div ><g:if test="${(customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="160px" height="160px"src="${createLink(controller:'Attachment', action:'show', id: (customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></div>
                 </div>
                <div class="col-xs-9 col-sm-9">

                    <g:if test="${customerInstance?.type.id==1}">

                        <h3 style="font-weight:bold;">${customerInstance?.name3}, ${customerInstance?.name1} ${customerInstance?.name2}</h3>
                        <p><i>(Last Name, First Name, Middle Name)</i></p>
                        </br>
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
                        <dd><g:link controller="customer" action="customerInquiry" id="${customerInstance?.id}">${customerInstance?.customerId}</g:link></dd>
                        </dl>
                        <g:set var="primaryAddress" value="${(customerInstance?.addresses?.find{it.isPrimary==true})}"/>
                        <g:if test="${primaryAddress!=null}">    
                        <dl class="dl-horizontal">
                            <dt>Address</dt>
                            <dd>${primaryAddress?.address1 + ", "+ primaryAddress?.address2 +", " +primaryAddress?.town.description+", "+primaryAddress?.address3}</dd>
                        </dl>
                        </g:if>
                        <g:else>
                         <dl class="dl-horizontal">
                            <dt>Address</dt>
                            <dd>N/A</dd>
                        </dl>
                        </g:else>
                        <dl class="dl-horizontal">
                            <dt>Customer Contact No</dt>
                            <dd>${(customerInstance?.contacts?.find{it.isPrimaryPhone ==true})?.contactValue}</dd>
                        </dl>
                        <dl class="dl-horizontal">
                            <dt>Customer E-Mail Address</dt>
                            <dd>${(customerInstance?.contacts?.find{it.isPrimaryEmail ==true})?.contactValue}</dd>
                        </dl>

                </div>
            </div>    
        </fieldset>
      </div><!-- end section-container-->
    </div>
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
</div>
