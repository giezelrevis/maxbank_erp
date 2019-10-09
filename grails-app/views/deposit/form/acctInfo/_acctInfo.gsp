<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

 <fieldset>
    <legend>Account Information</legend>
    <div id="acctInfoDiv">
            <g:if test="${depositInstance?.type?.id==null || depositInstance?.type?.id==1}">
                <g:render template='form/acctInfo/templates/deposit'/>
            </g:if>
            <g:if test="${depositInstance?.type?.id==2}">
                <g:render template='form/acctInfo/templates/current'/>
            </g:if>
            <g:if test="${depositInstance?.type?.id==3}">
                <g:render template='form/acctInfo/templates/fixedDeposit'/>
            </g:if>
            <g:if test="${depositInstance?.type?.id==4}">
                <g:render template='form/acctInfo/templates/deposit'/>
            </g:if>
            <g:if test="${depositInstance?.type?.id==5}">
                <g:render template='form/acctInfo/templates/deposit'/>
            </g:if>
    </div>
</fieldset>