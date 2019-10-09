<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<!--Search Modal-->
<legend>Other Owners/Signatories</legend>
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'ownershipType', 'has-error')} ">
                <label class="control-label col-sm-4" for="ownershipType">
                        <g:message code="deposit.ownershipType.label" default="Ownership Type" />

                </label>
                <div class="col-sm-8"><g:select id="ownershipType" onchange="showSignatories(this)" name="ownershipType.id" from="${icbs.lov.OwnershipType.list()}" optionKey="id" optionValue="description" value="${depositInstance?.ownershipType?.id}" class="many-to-one form-control"/>
                    
                    <g:hasErrors bean="${depositInstance}" field="ownershipType">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="ownershipType">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
            <g:render template="form/signatory/signatoryGrid"/>
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'sigRules', 'has-error')} ">
                <label class="control-label col-sm-4" for="sigRules">
                        <g:message code="deposit.sigRules.label" default="Sig Rules" />

                </label>
                <div class="col-sm-8"><g:textField name="sigRules" maxlength="50" value="${depositInstance?.sigRules}"class="form-control"/>

                    <g:hasErrors bean="${depositInstance}" field="sigRules">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="sigRules">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'sigRemarks', 'has-error')} ">
                <label class="control-label col-sm-4" for="sigRemarks">
                        <g:message code="deposit.sigRemarks.label" default="Sig Remarks" />

                </label>
                <div class="col-sm-8"><g:textField name="sigRemarks" maxlength="50" value="${depositInstance?.sigRemarks}"class="form-control"/>

                    <g:hasErrors bean="${depositInstance}" field="sigRemarks">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="sigRemarks">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
            
            
            
            
<g:javascript>
    var signatoryCount = ${depositInstance?.signatories?.size()}+0;
     function bindSignatoryDelete(caller)
    {
        //find the parent div
        var prnt = $(caller).parents(".signatory-div");
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