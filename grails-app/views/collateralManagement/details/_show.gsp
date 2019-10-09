<legend>Collateral Details</legend>
<table class="table table-bordered table-striped">
    <tbody>
        <tr>
            <td style="font-weight:bold" width="30%">Owner</td>
            <td width="70%">${collateralInstance?.owner?.displayName}</td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Type</td>
            <td width="70%">${collateralInstance?.collateralType}</td>
        </tr>
        <tr>
            <td style="font-weight:bold" width="30%">Appraised Value</td>
            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${collateralInstance?.appraisedValue}"/></td>
        </tr>   
        <g:if test="${collateralInstance?.collateralType?.id == 1}">
        <tr>
            <td style="font-weight:bold" width="30%">Appraised Value Type</td>
            <td width="70%">${collateralInstance?.rem?.appraisedValueType?.description}</td>
        </tr> 
        </g:if>
        <tr>
            <td style="font-weight:bold" width="30%">Description</td>
            <td width="70%">${collateralInstance?.description}</td>
        </tr> 
  

<g:if test="${collateralInstance?.collateralType?.id == 1}">
	<g:render template="rem/show"/>
</g:if>
<g:elseif test="${collateralInstance?.collateralType?.id == 2}">
	<g:render template="chattel/show"/>
</g:elseif>
<g:elseif test="${collateralInstance?.collateralType?.id == 3}">
	<g:render template="holdout/show"/>
</g:elseif>
             
<%--<g:elseif test="${collateralInstance?.collateralType?.id == 4}">
	<g:render template="pdc/show"/>
</g:elseif>--%>

<tr>
    <td style="font-weight:bold" width="30%">Status</td>
    <td width="70%">${collateralInstance?.status}</td>
</tr>
    </tbody>    
</table> 