<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<h3>Customer Attachments</h3>
<g:if test="${customerInstance?.type?.id==1}">
    <legend>Primary Photo</legend>
    <g:render template='form/attachment/onetomany/attachment' model="['attachment':customerInstance?.attachments[0],'i':0,'type':1 ,'canDelete':'false','isPrimaryPhoto':'true']"/>
     <!--<input type="button" value="Add Extra Photo" onclick="addAttachment(0);" />  -->


    <legend>Primary Signature</legend>
    <g:render template='form/attachment/onetomany/attachment' model="['attachment':customerInstance?.attachments[1],'i':1,'type':2 ,'canDelete':'false','isPrimarySig':'true']"/>
    <!--<input type="button" value="Add Extra Signature" onclick="addAttachment(1);" />-->
</g:if>
<legend>Other Attachments</legend>
<div id="otherList">
    <g:each var="attachment" in="${customerInstance.attachments}" status="i">
        <!-- Render the phone template (_phone.gsp) here -->
        <g:if test="${(attachment?.type?.code=='030'||attachment?.type?.code=='040'||attachment?.type?.code=='050')&& attachment?.status?.id==2}">
            <g:render template='form/attachment/onetomany/attachment' model="['attachment':attachment,'i':i]"/>
        </g:if>
                <!-- Render the phone template (_phone.gsp) here -->
    </g:each>
</div>
<div class="form-group form-buttons">
    <button type="button" class="btn btn-primary multi-field-btn" onclick="addAttachmentAjax(2);"<span class="fa fa-plus"></span> Add more Attachments</button>
</div>  
