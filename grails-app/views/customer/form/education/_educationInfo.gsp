<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<h3>Education Information</h3>
<legend>Primary Education</legend> 
<div id = "primaryList">
    <g:each var="education" in="${customerInstance.educations}" status="i">
        <g:if test="${education?.type?.id ==1&&(education.status?.id==2||!education?.id)}">
            <g:render template='form/education/onetomany/education' model="['education':education,'i':i,'choice':'0']"/>
        </g:if>
    </g:each> 
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addEducationAjax(0);"><span class="fa fa-plus"></span> Add More Primary</button>
</div>
<legend>High School Education</legend>
<div id = "secondaryList">
    <g:each var="education" in="${customerInstance.educations}" status="i">
        <g:if test="${education?.type?.id ==2&&(education.status?.id==2||!education?.id)}">
            <g:render template='form/education/onetomany/education' model="['education':education,'i':i,'choice':'1']"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addEducationAjax(1);"><span class="fa fa-plus"></span> Add more Secondary</button>
</div>
<legend>College Education</legend>
<div id = "collegeList">
    <g:each var="education" in="${customerInstance.educations}" status="i">
        <g:if test="${education?.type?.id ==3&&(education.status?.id==2||!education?.id)}">
            <g:render template='form/education/onetomany/education' model="['education':education,'i':i,'choice':'2']"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addEducationAjax(2);"><span class="fa fa-plus"></span> Add more College</button>
</div>

<legend>Vocational Education</legend>
<div id = "vocationalList">
    <g:each var="education" in="${customerInstance.educations}" status="i">
        <g:if test="${education?.type?.id ==4&&(education.status?.id==2||!education?.id)}">
            <g:render template='form/education/onetomany/education' model="['education':education,'i':i,'choice':'3']"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addEducationAjax(3);"><span class="fa fa-plus"></span> Add more Vocational</button>
</div>
<legend>Post Grad Education</legend>
<div id = "postGradList">
    <g:each var="education" in="${customerInstance.educations}" status="i">
        <g:if test="${education?.type?.id ==5&&(education.status?.id==2||!education?.id)}">
            <g:render template='form/education/onetomany/education' model="['education':education,'i':i,'choice':'4']"/>
        </g:if>
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addEducationAjax(4);"><span class="fa fa-plus"></span> Add more Post Grad</button>
</div>

