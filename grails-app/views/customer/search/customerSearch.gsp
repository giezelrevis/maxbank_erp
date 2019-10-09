<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Customer Search</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
    </head>
    <body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><span class="current">Search Customer</span>
            </content>        
        <content tag="main-content">
           <g:render template="/search/searchTemplate/searchCustomer"/>
          <!-- <g:jasperReport action="createReport"  controller="customer" format="PDF" jasper="customers" name="CLL PDF"> 
               <import value="icbs.Admin.Branch"/>
           </g:jasperReport>
           <g:jasperReport action="createReport" import value="icbs.Admin.Branch" controller="customer" format="XLS" jasper="customers" name="CLL XLS"/> -->
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="" action="create" resource="">New Customer</g:link></li>
                <!-- <li><g:link class="" action="viewCustomerReports" resource="">CIF REPORTS</g:link></li> -->
            </ul>
        </content>
    </body> 
</html>
        

