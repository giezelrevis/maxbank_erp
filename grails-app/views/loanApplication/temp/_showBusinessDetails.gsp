    <g:set var="customerInstance" value="${loanApplicationInstance?.customer}" />  

    <dl class="dl-horizontal">
        <dt>Business Name</dt>
        <dd>${customerInstance?.businesses[0]?.name}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>Business Address</dt>
        <dd>${customerInstance?.businesses[0]?.address1}</dd>
        <dd>${customerInstance?.businesses[0]?.address2}</dd>
        <dd>${customerInstance?.businesses[0]?.address3}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>Business Registration Date</dt>
        <dd>${customerInstance?.businesses[0]?.registrationDate}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>Fax No</dt>
        <dd>${customerInstance?.businesses[0]?.faxNo}</dd>
    </dl>
    <dl class="dl-horizontal">
        <dt>Email Address</dt>
        <dd>${customerInstance?.businesses[0]?.eMail}</dd>
    </dl>

