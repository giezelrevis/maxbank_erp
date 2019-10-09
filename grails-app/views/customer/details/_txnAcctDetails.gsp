 <div class="section-container">
        <fieldset>
            <legend class="section-header">Account Details</legend>
            <div class="col-xs-8 col-sm-6 col-md-6">
                <div class="infowrap">
                    <dl class="dl-horizontal">
                           <dt>Customer Name</dt>
                           <dd>${customerInstance?.displayName}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                           <dt>Date Of Birth</dt>
                           <dd><g:formatDate format="MM/dd/yyyy" date="${customerInstance?.birthDate}"/></dd>
                    </dl>
                    <dl class="dl-horizontal">
                           <dt>Address</dt>
                           <g:set var = "address" value="${customerInstance?.addresses?.find{it.isPrimary==true}}"/>
                            <g:if test="${address}">
                                <dd>
                                     ${address?.address1}<br>
                                     ${address?.address2}<br>
                                     ${address?.town?.description}<br>
                                     ${address?.address3}<br>

                                </dd>
                            </g:if>
                            <g:else>
                                <dd>N/A</dd>
                            </g:else>
                    </dl>
                </div>
            </div>
            <div class="infowrap">
                <dl class="dl-horizontal">
                   <dd><g:if test="${(customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (customerInstance?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></dd>
                </dl>
            </div>
        </fieldset>
    </div>