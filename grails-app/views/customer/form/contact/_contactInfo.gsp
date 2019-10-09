<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
    <legend>Contact Information</legend>
    <legend>Phones</legend>
    <!--Primary Phone-->
    <g:render template='form/contact/onetomany/contact' model="['contact':customerInstance?.contacts[0],'i':0,'choice':'0',canDelete:'false']"/>
        <div id="phoneList">
             <g:each var="contact" in="${customerInstance.contacts}" status="i">
                    <g:if test="${i>1 &&(contact?.type?.itemCode=="001" || contact?.type?.itemCode=="002")&&(contact?.status?.id==2||!contact?.id)}">
                        <g:render template='form/contact/onetomany/contact' model="['contact':contact,'i':i,'choice':'0']"/>
                    </g:if>
             </g:each>
        </div>
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-primary multi-field-btn" onclick="addContactAjax(0)"><span class="fa fa-plus"></span> Add more Contacts</button>
        </div>
    <legend>Emails</legend>
        <g:render template='form/contact/onetomany/contact'  model="['contact':customerInstance?.contacts[1],'i':1,'choice':'1',canDelete:'false']"/>
        <div id="emailList">
             <g:each var="contact" in="${customerInstance.contacts}" status="i">
                    <g:if test="${i>1 && contact?.type?.itemCode=="003" && (contact?.status?.id==2||!contact?.id)}">
                        <g:render template='form/contact/onetomany/contact' model="['contact':contact,'i':i,'choice':'1']"/>
                    </g:if>
             </g:each>
        </div>
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-primary multi-field-btn" onclick="addContactAjax(1)"><span class="fa fa-plus"></span> Add more Email Addresses</button>
        </div>
    <legend> Social Media</legend>
        <div id="socialMediaList">
              <g:each var="contact" in="${customerInstance.contacts}" status="i">
                    <g:if test="${i>1 && (contact?.type?.itemCode=="004" ||contact?.type?.itemCode=="005" ||contact?.type?.itemCode=="006")&& (contact?.status?.id==2 ||!contact?.id) }">
                        <g:render template='form/contact/onetomany/contact'  model="['contact':contact,'i':i,'choice':'2']"/>
                    </g:if>
             </g:each>
        </div>
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-primary multi-field-btn" onclick="addContactAjax(2)"><span class="fa fa-plus"></span> Add more Social Media</button>
        </div>