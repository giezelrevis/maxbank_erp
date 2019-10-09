<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<!--Search Modal-->
<legend>Graduated Interest Rates</legend>
    <div id = "graduatedList">
        <g:each var="graduated" in="${depositInterestSchemeInstance.graduateds}" status="i">
            <g:if test="${graduated?.status?.id!=3}">
                <g:render template='form/graduated/onetomany/graduated' model="['graduated':graduated,'i':i]"/>
            </g:if>
        </g:each> 
    </div>
    <div class="form-group form-buttons">
        <button type="button" class="btn btn-primary multi-field-btn" onclick="addGraduatedAjax();"><span class="fa fa-plus"></span> Add More Graduated</button>
    </div>
<g:javascript>
    icbs.Deposit.DepositInterestScheme.Form.getForm.graduatedCount = ${depositInterestSchemeInstance?.graduateds?.size()}+0;
     function bindGraduatedDelete(caller)
    {
        //find the parent div
        var prnt = $(caller).parents(".graduated-div");
        //find the deleted hidden input
        var delInput = prnt.find("input[id$=deleted]");
        //check if this is still not persisted
        var newValue = prnt.find("input[id$=new]").attr('value');
        //if it is new then i can safely remove from dom
        if(newValue == 'true'){
            prnt.remove();
        }else{
            //set the deletedFlag to true
            delInput.attr('value','true');
            //hide the div
            prnt.hide();
        }        
    }
</g:javascript>