<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<h3>Other Bank Accounts</h3>
<div id="otherAcctList">
    <g:each var="otherAcct" in="${customerInstance.otheraccts}" status="i">
        <g:if test="${otherAcct?.status?.id==2||!otherAcct?.id}">
            <g:render template='form/otheracct/onetomany/otherAcct' model="['otherAcct':otherAcct,'i':i]"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addOtherAcctAjax();"<span class="fa fa-plus"></span> Add more Other Accounts</button>
</div>
