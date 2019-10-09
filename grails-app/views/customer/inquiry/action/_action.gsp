<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<ul>
        <li><g:link class="" action="customerSearch">Search Customers</g:link></li>
        <g:if test="${customerInstance}">
          <li><g:link action="customerViewMoreInformation" id="${customerInstance.id}">View More Information</g:link></li>
        </g:if>
        <g:else>
          <li><button disabled="disabled">View More Information</button></li>
        </g:else>
        <g:if test="${customerInstance&&customerInstance.status?.id!=3}">
          <li><g:link class="edit" action="edit" resource="${customerInstance}">Update Customer</g:link></li>
        </g:if>
        <g:else>
          <li><button disabled="disabled">Update Customer</button></li>
        </g:else>
         <g:if test="${customerInstance}">
          <li><button onclick="viewAccounts()">Customer Accounts</button></li>
        </g:if>
        <g:else>
          <li><button disabled="disabled">Customer Accounts</button></li>
        </g:else>
        <g:if test="${customerInstance?.type?.id==1&&customerInstance.status?.id!=3}">
          <li><g:link action="customerShowRelated" id="${customerInstance?.id}">Customer Relationships</g:link></li>
        </g:if>
        <g:if test="${customerInstance?.type?.id!=1&&customerInstance.status?.id!=3}">
          <li><g:link action="customerShowRelated" id="${customerInstance?.id}">Company Connections</g:link></li>
        </g:if>
        <g:if test="${customerInstance}">
          <li><a href="#" onclick="openUpdateCustomerStatus()">Update Customer Status</a></li>
        </g:if>
        <g:else>
          <li><button disabled>Update Customer Status</button></li>
        </g:else>
        <g:if test="${customerInstance&&customerInstance.status?.id!=3}">
          <li><a href="#" onclick="openUpdateCustomerCreditLimit()">Update Customer Credit Limit</a></li>
        </g:if>
        <g:else>
          <li><button disabled>Update Customer Credit Limit</button></li>
        </g:else>
        <g:if test="${customerInstance&&customerInstance.status?.id==2}">
          <li><a href="#" onclick="openNewAccount()">Open Accounts</a></li>
        </g:if>
        <g:else>
          <li><button disabled>Open Accounts</button></li>
        </g:else>
        <li><g:link action="customerInfobase" id="${customerInstance?.id}">Customer Infobase</g:link></li>
        <li><g:link class="" action="create" resource="">New Customer</g:link></li>
        
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <!-- new view added by jmmarquez july 10, 2017 -->
        <li><g:link action="viewLoanComakerRelationship" id="${customerInstance?.id}">View Loan Comaker Relationship</g:link></li>
        <!-- new view added by jmmarquez September 20, 2017 -->
        <li><g:link action="viewCustomerCollateral" id="${customerInstance?.id}">View Customer Collateral</g:link></li>
      </ul>