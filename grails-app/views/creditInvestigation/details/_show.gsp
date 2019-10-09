<legend>Credit Investigation Details</legend>
<table class="table table-bordered table-striped">
    <tbody>
        <tr>
            <td style="font-weight:bold" width="30%">Loan Application</td>
            <td width="70%"><g:link controller="loanApplication" action="show" id="${creditInvestigationInstance?.loanApplication?.id}">${creditInvestigationInstance?.loanApplication?.id}</g:link></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Recommendation</td>
            <td width="70%"><g:fieldValue bean="${creditInvestigationInstance}" field="recommendation"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">CI Schedule Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.ciScheduleDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">CI Name</td>
            <td width="70%">${creditInvestigationInstance?.ciName}</td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">CI Execution Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.ciExecutionDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Appraisal Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.appraisalDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Appraised By</td>
            <td width="70%">${creditInvestigationInstance?.appraisedBy}</td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Loan Analysis Schedule Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.loanAnalysisScheduleDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Loan Analysist Name</td>
            <td width="70%">${creditInvestigationInstance?.analysName}</td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Loan Analysis Execution Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.loanAnalysisExecutionDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Credit Com B Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.creditComBDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Credit Com A Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.creditComADate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Lending Authority Approval Date</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.approvalDate}" type="date" style="FULL"/></td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Date Created</td>
            <td width="70%"><g:formatDate date="${creditInvestigationInstance?.dateCreated}" type="date" style="FULL"/></td>
        </tr>
    </tbody>
</table>