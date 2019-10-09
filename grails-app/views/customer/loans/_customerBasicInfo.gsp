<%@ page import="icbs.cif.Customer" %>


<div>
    <p id="display-name">${customerInstance?.displayName ?: ""}</p>
    <p id="birth-date"><g:formatDate format="MM/dd/yyyy" date="${customerInstance?.birthDate ?: ""}"/></p>

    <g:set var="primaryAddress" value="${(customerInstance?.addresses?.find{it.isPrimary==true})}"/>
	<p id="address">    
	<g:if test="${primaryAddress != null}">
    ${primaryAddress?.address1 + ", " + primaryAddress?.address2 +", " +primaryAddress?.address3}
	</g:if>
	</p>

	<p id="photo">
	<g:if test="${(customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> 
	<img width="140px" height="140px" src="${createLink(controller:'Attachment', action:'show', id: (customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/>
	</g:if>
    </p>
    <p id="total-released"><g:formatNumber format="###,###,##0.00" number="${totReleased}"/></p>
    <p id="total-balance"><g:formatNumber format="###,###,##0.00" number="${totBalance}"/></p>
    <p id="total-count"><g:formatNumber format="###,###,##0" number="${totCount}"/></p>
</div>


