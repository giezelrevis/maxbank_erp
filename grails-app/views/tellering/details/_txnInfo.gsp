<div>
    <!--
    <p id="txnType">${txnTemplateInstance?.codeDescription}</p>
    <p id="txnDate">${txnFileInstance?.txnDate}</p>
    <p id="txnAmt">${txnFileInstance?.txnAmt}</p>
    -->
    <p id="txnType">${txnFileInstance.txnType.description}</p>
    <p id="acctNo">${txnFileInstance.acctNo}</p>
    <p id="branch">${txnFileInstance.branch?.name}</p>
    <p id="txnDate">${txnFileInstance.txnDate.format('MM/dd/yyyy')}</p>
    <p id="txnAmt"><g:formatNumber number="${txnFileInstance.txnAmt}" format="###,##0.00" /></p>
    <p id="txnCode">${txnFileInstance.txnCode}</p>
    <p id="txnTemplateDesc"> ${txnFileInstance.txnDescription} </p>
    <p id="reference">${txnFileInstance.txnRef}</p>
    <p id="particulars">${txnFileInstance.txnParticulars}</p>
    <p id="status">${txnFileInstance.status.description}</p>
    <p id="user">${txnFileInstance.user?.username}</p>  
    
    <!--
    <p id="sender">
    <g:if test="${senderInstance}">
        ${senderInstance.displayName}
    </g:if>
    </p>
    <p id="senderBirthDate">
    <g:if test="${senderInstance}">
        ${senderInstance.birthDate}
    </g:if>
    </p>
    <p id="senderAddress">
        <g:set var = "address" value="${senderInstance?.addresses?.find{it.isPrimary==true}}"/>
        <g:if test="${address}">
            ${address?.address1}<br>
            ${address?.address2}<br>
            ${address?.address3}<br>
        </g:if>
        <g:else>
            N/A
        </g:else>
    </p>
    <p id="senderPhoto">
        <g:if test="${(senderInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (senderInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if>
    </p>
    <p id="beneficiary">
    <g:if test="${beneficiaryInstance}">
        ${beneficiaryInstance.displayName}
    </g:if>
    </p>
    <p id="beneficiaryBirthDate">
    <g:if test="${beneficiaryInstance}">
        ${beneficiaryInstance.birthDate}
    </g:if>
    </p>
    <p id="beneficiaryAddress">
        <g:set var = "address" value="${beneficiaryInstance?.addresses?.find{it.isPrimary==true}}"/>
        <g:if test="${address}">
            ${address?.address1}<br>
            ${address?.address2}<br>
            ${address?.address3}<br>
        </g:if>
        <g:else>
            N/A
        </g:else>
    </p>
    <p id="beneficiaryPhoto">
        <g:if test="${(beneficiaryInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (beneficiaryInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if>
    </p>
    <p id="particulars">${txnFileInstance?.txnParticulars}</p>
    <p id="reference">${txnFileInstance?.txnRef}</p>
    <p id="status">${txnFileInstance?.status.description}</p>
    <p id="indic">${indicator}</p>
    -->
</div>