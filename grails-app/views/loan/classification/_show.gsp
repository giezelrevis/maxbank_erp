<table class="table table-bordered table-striped">
    <legend>Performance Classification</legend>
    <tr>
        <td style="font-weight:bold" width="30%">Kind Of Loan</td>
        <td width="70%"><span>${loanInstance?.loanKindOfLoan?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Name of Institution</td>
        <td width="70%"><span>${loanInstance?.loanType?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Economic Activity</td>
        <td width="70%"><span>${loanInstance?.loanProject?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Age in Arears</td>
        <td width="70%"><span>${loanInstance?.ageInArrears}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Bsp Provision</td>
        <td width="70%"><span>${loanInstance?.loanProvisionBsp?.description}</span></td>
    </tr>    
    <tr>
        <td style="font-weight:bold" width="30%">Loan Provision</td>
        <td width="70%"><span>${loanInstance?.loanProvision?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Loan Status</td>
        <td width="70%"><span>${loanInstance?.loanPerformanceId?.description}</span></td>
    </tr>
    <tr>
        <td style="font-weight:bold" width="30%">Loan Security</td>
        <td width="70%"><span>${loanInstance?.loanSecurity?.description}</span></td>
    </tr> 
</table>    

<%--<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 1" />
    </label>
    <span><g:link controller="loanPerformanceClassification" action="show" id="${loanInstance?.performanceClassificationScheme1?.id}">${loanInstance?.performanceClassificationScheme1?.name}</g:link></span>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 2" />
    </label>
    <span><g:link controller="loanPerformanceClassification" action="show" id="${loanInstance?.performanceClassificationScheme2?.id}">${loanInstance?.performanceClassificationScheme2?.name}</g:link></span>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 3" />
    </label>
    <span><g:link controller="loanPerformanceClassification" action="show" id="${loanInstance?.performanceClassificationScheme3?.id}">${loanInstance?.performanceClassificationScheme3?.name}</g:link></span>
</div>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 4" />
    </label>
    <span><g:link controller="loanPerformanceClassification" action="show" id="${loanInstance?.performanceClassificationScheme4?.id}">${loanInstance?.performanceClassificationScheme4?.name}</g:link></span>
</div>--%>

<table class="table table-bordered table-striped">
    <legend>GL</legend>
    <tr>
        <td style="font-weight:bold" width="30%">Loan Type</td>
        <td width="70%"><span><g:link controller="cfgAcctGlTemplate" action="show" id="${loanInstance?.glLink?.id}">${loanInstance?.glLink?.description}</g:link></span></td>
    </tr> 
</table>    