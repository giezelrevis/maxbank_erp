<tr>
    <td style="font-weight:bold" width="30%">Account No.</td>
    <td width="70%">${collateralInstance?.holdout?.accountNo}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Account Type</td>
    <td width="70%">${collateralInstance?.holdout?.accountType}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Amount</td>
    <td width="70%"><g:formatNumber format="###,###,##0.00" number="${collateralInstance?.holdout?.amount}"/></td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Bank</td>
    <td width="70%">${collateralInstance?.holdout?.bank}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">On Us</td>
    <td width="70%"><g:formatBoolean boolean="${collateralInstance?.holdout?.onUs}" /></td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Holdout Date</td>
    <td width="70%"><g:formatDate date="${collateralInstance?.holdout?.holdoutDate}" type="date" style="FULL"/></td>
</tr>