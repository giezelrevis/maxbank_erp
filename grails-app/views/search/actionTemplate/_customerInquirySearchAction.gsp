<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<td><g:link class="btn btn-secondary" controller="customer"action="customerInquiry" class="btn btn-secondary"id="${customerInstance?.id}"  
                                    onclick="return confirm('Are you sure you want to query this customer?');">View</g:link></td>