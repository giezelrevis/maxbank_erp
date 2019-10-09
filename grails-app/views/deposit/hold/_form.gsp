<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField name="id" value="${holdInstance?.id}"/>
<g:hiddenField id="deposit"name="deposit.id" value="${holdInstance?.deposit?.id}"/>
<!-- Hold Type -->
<div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'type', 'has-error')} required">
    
	<label class="control-label col-sm-4" for="type">
		<g:message code="hold.type.label" default="Hold Type" />
		<span class="required-indicator">*</span>
	</label>
        <div class="col-sm-8">
        <g:if test="${!disabled}">
            <g:select id="type"  name="type.id" onchange="updateForm()"from="${icbs.lov.HoldType.list()}" optionKey="id" required="" optionValue="description" value="${holdInstance?.type?.id}" class="many-to-one form-control"/>
        </g:if>  
        
        <g:elseif test="${disabled}">
            <g:select id="type"  disabled="disabled" name="type.id" onchange="updateForm()"from="${icbs.lov.HoldType.list()}" optionKey="id" required="" optionValue="description" value="${holdInstance?.type?.id}" class="many-to-one form-control"/>
        </g:elseif>
        </div>
        
        <g:hasErrors bean="${holdInstance}" field="type">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${holdInstance}" field="type">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>               
</div>
<!-- Status -->
<div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'status', 'has-error')} ">
    
	<label class="control-label col-sm-4" for="status">
		<g:message code="hold.status.label" default="Status" />		
	</label>
        
	<div class="col-sm-8">
            
            <g:select id="status" name="status.id" from="${icbs.lov.HoldStatus.list()}" optionValue="description" optionKey="id" value="${holdInstance?.status?.id}" class="many-to-one form-control"/>
            <g:if test="${holdInstance?.status?.id < 3}">
    
            <g:hiddenField id="holdDate" name="holdDate" value="${icbs.admin.Branch.findById(session.branch_id).runDate.format("MM/dd/yyyy")}"/>
            <!--<g:hiddenField id="heldById" name="heldBy" value="${icbs.admin.UserMaster.findById(session.user_id).id}"/>
            -->
        </div>
</div>
            
<!-- hold date -->
<div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'holdDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="holdDate">
		<g:message code="hold.holdDate.label" default="Hold Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:hiddenField id="holdDate" name="holdDate" value="${icbs.admin.Branch.findById(session.branch_id).runDate.format("MM/dd/yyyy")}"/>
            <g:textField name="holdDate" disabled="disabled" value="${icbs.admin.Branch.findById(session.branch_id).runDate.format("MM/dd/yyyy")}"class="form-control"/>
            
            <g:hasErrors bean="${holdInstance}" field="holdDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holdInstance}" field="holdDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- hold date -->

<!-- held by -->
<div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'heldById', 'has-error')} required">
        <label class="control-label col-sm-4" for="heldById">
		<g:message code="heldById.label" default="Held By" />
		<span class="required-indicator">*</span>
	</label>
        
	<div class="col-sm-8">
            <!-- g:hiddenField  name="heldBy" value="${icbs.admin.UserMaster.findById(session.user_id)}"/ -->
            <g:textField name="heldById" readonly="true" value="${icbs.admin.UserMaster.findById(session.user_id).username}" class="form-control"/>
            
            <g:hasErrors bean="${holdInstance}" field="heldById">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${holdInstance}" field="heldById">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- held by -->
<!-- maturity date -->
<div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'maturityDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="maturityDate">
		<g:message code="hold.maturityDate.label" default="Maturity Date" />
		<span class="required-indicator">*</span>
	</label>
        <g:if test="${!disabled}">
            <!-- for new hold -->
            <div class="col-sm-8"><g:customDatePicker name="maturityDate" precision="day" class="form-control"  value="${icbs.admin.Branch.findById(session.branch_id).runDate+1}"  /></div>
        </g:if>        
        <g:if test="${disabled}">
            <div class="col-sm-8"><g:customDatePicker name="maturityDate" precision="day" class="form-control"  value="${holdInstance?.maturityDate}"  /></div>
        </g:if>
        <g:hasErrors bean="${holdInstance}" field="maturityDate">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${holdInstance}" field="maturityDate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
                   
</div>

<!-- Percentage -->
<div id="variable-amount-div" style="<g:if test="${holdInstance?.type?.id!=1&&holdInstance?.type?.id}">display:block</g:if><g:else>display:none</g:else>">
    <div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'percent', 'has-error')} ">
            <label class="control-label col-sm-4" for="percent">
                    <g:message code="hold.percent.label" default="Percentage" />

            </label>
                <div class="col-sm-8"><g:field name="percent" value="${fieldValue(bean: holdInstance, field: 'percent')}" class="form-control"/>
                <g:hasErrors bean="${holdInstance}" field="percent">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${holdInstance}" field="percent">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>
<!-- Amount -->
<g:if test="${session["holdaction"] == 'create'}">                
<div id="fixed-amount-div" style="<g:if test="${holdInstance?.type?.id==1||(holdInstance?.type?.id==2&&holdInstance?.id)||!holdInstance?.type}">display:block</g:if><g:else>display:none</g:else>">
    <div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'amt', 'has-error')} ">
            <label class="control-label col-sm-4" for="amt">
                    <g:message code="hold.amt.label" default="Amount" />

            </label>
            <div class="col-sm-8"><g:field name="amt" value="${fieldValue(bean: holdInstance, field: 'amt')}" class="form-control"/>
                <g:hasErrors bean="${holdInstance}" field="amt">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${holdInstance}" field="amt">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>
</g:if>
<g:else>
<div id="fixed-amount-div" style="<g:if test="${holdInstance?.type?.id==1||(holdInstance?.type?.id==2&&holdInstance?.id)||!holdInstance?.type}">display:block</g:if><g:else>display:none</g:else>">
    <div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'amt', 'has-error')} ">
            <label class="control-label col-sm-4" for="amt">
                    <g:message code="hold.amt.label" default="Amount" />

            </label>
            <div class="col-sm-8"><g:field disabled="${disabled}" name="amt" value="${fieldValue(bean: holdInstance, field: 'amt')}" class="form-control"/>
                <g:hasErrors bean="${holdInstance}" field="amt">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${holdInstance}" field="amt">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>    
</g:else>

<div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'remarks', 'has-error')} ">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="hold.remarks.label" default="Remarks" />
		
	</label>
	<div class="col-sm-8">
            <g:textArea name="remarks" cols="40" rows="5" maxlength="255" value="${holdInstance?.remarks}"class="form-control"/>

                     
        </div>

    
</div>

<!-- 
    <div id="fixed-amount-div" style="<g:if test="${holdInstance?.type?.id==1||(holdInstance?.type?.id==2&&holdInstance?.id)||!holdInstance?.type}">display:block</g:if><g:else>display:none</g:else>">
    <div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'amt', 'has-error')} ">
            <label class="control-label col-sm-4" for="amt">
                    <g:message code="hold.amt.label" default="Amount" />


            </label>
            <div class="col-sm-8"><g:field name="amt" disabled="${disabled}" value="${fieldValue(bean: holdInstance, field: 'amt')}" class="form-control"/>
                <g:hasErrors bean="${holdInstance}" field="amt">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${holdInstance}" field="amt">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: holdInstance, field: 'remarks', 'has-error')} ">
            <label class="control-label col-sm-4" for="remarks">
                    <g:message code="hold.remarks.label" default="Remarks" />

            </label>
            <div class="col-sm-8"><g:textArea name="remarks" cols="40" rows="5" maxlength="255" value="${holdInstance?.remarks}"class="form-control"/>

                <g:hasErrors bean="${holdInstance}" field="remarks">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${holdInstance}" field="remarks">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>         
    </div>
</g:if>
-->