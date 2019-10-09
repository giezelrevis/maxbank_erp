<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<legend>Presented ID </legend>
<g:render template='form/presentedid/onetomany/presentedId' model="['presentedId':customerInstance?.presentedids[0],'i':0,'canDelete':'false']"/>
<div id = "presentedIdList">
        <g:each var="presentedId" in="${customerInstance.presentedids}" status="i">
            <g:if test="${i>0 && (presentedId?.status?.id==2||!presentedId?.id)}">
                <g:render template='form/presentedid/onetomany/presentedId' model="['presentedId':presentedId,'i':i]"/>
            </g:if>
        </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addPresentedIdAjax();"<span class="fa fa-plus"></span> Add more Presented IDS</button>
</div>