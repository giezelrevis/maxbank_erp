<tr>
    <td style="font-weight:bold" width="30%">Land Area (sq. meters)</td>
    <td width="70%"><g:formatNumber format="##,###,###,##0.00" number="${collateralInstance?.rem?.landArea}"/></td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">TCT No.</td>
    <td width="70%">${collateralInstance?.rem?.tctNo}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Lot No.</td>
    <td width="70%">${collateralInstance?.rem?.lotNo}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Location</td>
    <td width="70%">${collateralInstance?.rem?.location}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Other Owners</td>
    <td width="70%">${collateralInstance?.rem?.otherOwners}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Registry of Deeds</td>
    <td width="70%">${collateralInstance?.rem?.registryOfDeeds}</td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Date of Issuance</td>
    <td width="70%"><g:formatDate date="${collateralInstance?.rem?.dateOfIssuance}" type="date" style="FULL"/></td>
</tr>
<tr>
    <td style="font-weight:bold" width="30%">Encumberances</td>
    <td width="70%">${collateralInstance?.rem?.encumberances}</td>
</tr>