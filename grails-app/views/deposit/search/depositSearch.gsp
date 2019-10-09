<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Deposit Search</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
    </head>
    <body>
        <content tag="breadcrumbs">
            <span class="fa fa-chevron-right"></span><span class="current">Deposit Search</span>
	</content>
        <content tag="main-content">
           <g:render template="/search/searchTemplate/searchDeposit"/>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="" action="create" resource="">New Deposit Account</g:link></li>
                <!--<li><g:link action="/depositInquiry">Back to Home</g:link></li>-->
            </ul>
        </content>
    </body> 
</html>
        

