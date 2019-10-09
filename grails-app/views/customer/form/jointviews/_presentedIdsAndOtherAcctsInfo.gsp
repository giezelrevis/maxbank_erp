<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${customerInstance?.type?.id==1}">
    <g:render template="form/presentedid/presentedIdInfo"/>
</g:if>
<g:render template="form/otheracct/otherAcctInfo"/>