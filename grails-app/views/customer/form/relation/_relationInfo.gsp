<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
 <g:hiddenField id='customerRelationshipType'  name='customerRelationshipType' value="${customerRelationshipType}"/>
<h3> Family Information</h3>
<!--<legend>Spouse Information</legend>
<div id ="spouseList">
    <g:set var="spouseCount" value="${0}"/>
    <g:each var="relation" in="${customerInstance?.relations}" status="i">
        <g:if test="${relation?.type?.id==65&&(relation?.status?.id==2||!relation?.id)}">
            <g:render template='form/relation/onetomany/relation' model="['relation':relation,'i':i,'choice':'0']"/>
            <g:set var="spouseCount" value="${spouseCount+1}"/>
        </g:if>
    </g:each>
</div> 
<g:if test="${spouseCount==0}">
    <div class="form-group form-buttons">
        <button type="button" id="spouseAddButton" class="btn btn-primary spouseAddButton"  onclick="addRelationAjax({choice:0});"><span class="fa fa-plus"></span> Add Spouse</button>
    </div> 
</g:if>
<g:else>
    <div class="form-group form-buttons">
        <button type="button" id="spouseAddButton" class="btn btn-primary spouseAddButton" disabled="disabled"  onclick="addRelationAjax({choice:0});"><span class="fa fa-plus"></span> Add Spouse</button>
    </div> 
</g:else>
-->
<legend>Father Information</legend>
<div id ="fatherList">
    <g:set var="fatherCount" value="${0}"/>
    <g:each var="relation" in="${customerInstance?.relations}" status="i">
        <g:if test="${relation?.type?.id==48&&(relation?.status?.id==2||!relation?.id)}">
            <g:render template='form/relation/onetomany/relation' model="['relation':relation,'i':i,'choice':'1','hide':'true']"/>
            <g:set var="fatherCount" value="${fatherCount+1}"/>
        </g:if>
    </g:each>
</div>
<g:if test="${fatherCount==0}">
    <div class="form-group form-buttons">
        <button type="button" id="fatherAddButton" class="btn btn-primary fatherAddButton"  onclick="addRelationAjax({choice:1});" disabled="true"><span class="fa fa-plus"></span> Add Father</button>
    </div> 
</g:if>
<g:else>
    <div class="form-group form-buttons">
        <button type="button" id="fatherAddButton" class="btn btn-primary fatherAddButton" disabled="disabled"  onclick="addRelationAjax({choice:1});"><span class="fa fa-plus"></span> Add Father</button>
    </div> 
</g:else>


    
<legend>Mother Information</legend>
<div id ="motherList">
    <g:set var="motherCount" value="${0}"/>
    <g:each var="relation" in="${customerInstance?.relations}" status="i">
        <g:if test="${relation?.type?.id==47&&(relation?.status?.id==2||!relation?.id)}">
            <g:render template='form/relation/onetomany/relation' model="['relation':relation,'i':i,'choice':'2']"/>
            <g:set var="motherCount" value="${motherCount+1}"/>
        </g:if>
    </g:each>
</div>
<g:if test="${motherCount==0}">
    <div class="form-group form-buttons">
        <button type="button" id="motherAddButton" class="btn btn-primary motherAddButton"  onclick="addRelationAjax({choice:2});" disabled="true"><span class="fa fa-plus"></span> Add Mother</button>
    </div> 
</g:if>
<g:else>
    <div class="form-group form-buttons">
        <button type="button" id="motherAddButton" class="btn btn-primary motherAddButton" disabled="disabled"  onclick="addRelationAjax({choice:2});"><span class="fa fa-plus"></span> Add Mother</button>
    </div> 
</g:else>
<legend>Other Dependents</legend>
<div id="otherRelationList">
    <g:each var="relation" in="${customerInstance?.relations}" status="i">
        <g:if test="${relation?.type?.id!=47&&relation?.type?.id!=48&&(relation?.status?.id==2||!relation?.id)}">
            <g:render template='form/relation/onetomany/relation' model="['relation':relation,'i':i,'choice':'3']"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary"  onclick="addRelationAjax({choice:3});" disabled="true"><span class="fa fa-plus"></span> Add Other Relations</button>
</div>