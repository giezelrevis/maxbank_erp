<%@ page import="icbs.loans.CreditInvestigation" %>


<legend>Credit Investigation Details</legend>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'loanApplication', 'has-error')} required">
	<label class="control-label col-sm-4" for="loanApplication">
		<g:message code="creditInvestigation.loanApplication.label" default="Loan Application" />
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-7"><g:field name="loanApplication" type="number" value="${creditInvestigationInstance?.loanApplication?.id}" class="form-control" readonly="true"/>

        <g:hasErrors bean="${creditInvestigationInstance}" field="loanApplication">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${creditInvestigationInstance}" field="loanApplication">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>
        </g:hasErrors>
    </div>

    <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showLoanApplicationSearch()" value="Search"/></div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'recommendation', 'has-error')} required">
	<label class="control-label col-sm-4" for="recommendation">
		<g:message code="creditInvestigation.recommendation.label" default="Recommendation" />
        </label>
	<div class="col-sm-8"><g:textArea name="recommendation" cols="40" rows="5" maxlength="255" value="${creditInvestigationInstance?.recommendation}"class="form-control"/>

            <g:hasErrors bean="${creditInvestigationInstance}" field="recommendation">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="recommendation">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'ciScheduleDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="ciScheduleDate">
		<g:message code="creditInvestigation.ciScheduleDate.label" default="CI Schedule Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="ciScheduleDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.ciScheduleDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="ciScheduleDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="ciScheduleDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'ciName', 'has-error')} required">
	<label class="control-label col-sm-4" for="ciName">
		<g:message code="creditInvestigation.ciName.label" default="CI Name" />
        </label>
	<div class="col-sm-8"><g:field name="ciName" value="${creditInvestigationInstance?.ciName}" class="form-control"/>

            <g:hasErrors bean="${creditInvestigationInstance}" field="ciName">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="ciName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'ciExecutionDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="ciExecutionDate">
		<g:message code="creditInvestigation.ciExecutionDate.label" default="CI Execution Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="ciExecutionDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.ciExecutionDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="ciExecutionDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="ciExecutionDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'appraisalDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="appraisalDate">
		<g:message code="creditInvestigation.appraisalDate.label" default="Appraisal Date" />
	</label>
	<div class="col-sm-8"><g:customDatePicker name="appraisalDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.appraisalDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="appraisalDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="appraisalDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'appraisedBy', 'has-error')} required">
	<label class="control-label col-sm-4" for="appraisedBy">
		<g:message code="creditInvestigation.appraisedBy.label" default="Appraised By" />
	</label>
	<div class="col-sm-8"><g:field name="appraisedBy" value="${creditInvestigationInstance?.appraisedBy}" class="form-control"/>

            <g:hasErrors bean="${creditInvestigationInstance}" field="appraisedBy">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="appraisedBy">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'appraExeDate', 'has-error')} required">
	<label class="control-label col-sm-4" for="appraExeDate">
		<g:message code="creditInvestigation.appraExeDate.label" default="Appraisal Execution Date" />
	
	</label>
	<div class="col-sm-8"><g:customDatePicker name="appraExeDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.appraExeDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="appraExeDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="appraExeDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'loanAnalysisScheduleDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="loanAnalysisScheduleDate">
		<g:message code="creditInvestigation.loanAnalysisScheduleDate.label" default="Loan Analysis Schedule Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="loanAnalysisScheduleDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.loanAnalysisScheduleDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="loanAnalysisScheduleDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="loanAnalysisScheduleDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'analysName', 'has-error')} required">
	<label class="control-label col-sm-4" for="analysName">
		<g:message code="creditInvestigation.analysName.label" default="Analyst Name" />
		
	</label>
	<div class="col-sm-8"><g:field name="analysName" value="${creditInvestigationInstance?.analysName}" class="form-control"/>

            <g:hasErrors bean="${creditInvestigationInstance}" field="analysName">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="analysName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'loanAnalysisExecutionDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="loanAnalysisExecutionDate">
		<g:message code="creditInvestigation.loanAnalysisExecutionDate.label" default="Loan Analysis Execution Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="loanAnalysisExecutionDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.loanAnalysisExecutionDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="loanAnalysisExecutionDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="loanAnalysisExecutionDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'creditComBDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="creditComBDate">
		<g:message code="creditInvestigation.creditComBDate.label" default="Credit Com B Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="creditComBDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.creditComBDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="creditComBDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="creditComBDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'creditComADate', 'has-error')} ">
	<label class="control-label col-sm-4" for="creditComADate">
		<g:message code="creditInvestigation.creditComADate.label" default="Credit Com A Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="creditComADate" precision="day" class="form-control"  value="${creditInvestigationInstance?.creditComADate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="creditComADate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="creditComADate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: creditInvestigationInstance, field: 'approvalDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="approvalDate">
		<g:message code="creditInvestigation.approvalDate.label" default="Lending Authority Approval Date" />
		
	</label>
	<div class="col-sm-8"><g:customDatePicker name="approvalDate" precision="day" class="form-control"  value="${creditInvestigationInstance?.approvalDate}"  />

            <g:hasErrors bean="${creditInvestigationInstance}" field="approvalDate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${creditInvestigationInstance}" field="approvalDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>









