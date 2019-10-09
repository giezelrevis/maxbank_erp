<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<h3>Company Connection Information</h3>
<legend>Connections</legend>
 <g:hiddenField id='customerRelationshipType'  name='customerRelationshipType' value="${customerRelationshipType}"/>
<div id="businessRelationList">
    <g:each var="relation" in="${customerInstance?.relations}" status="i">
        <g:if test="${(relation?.status?.id==2||!relation?.id)}">
            <g:render template='form/relation/onetomany/relation' model="['relation':relation,'i':i,'choice':'4']"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary"  onclick="addRelationAjax({choice:4});" disabled="true"><span class="fa fa-plus"></span> Add Other Connections</button>
</div>