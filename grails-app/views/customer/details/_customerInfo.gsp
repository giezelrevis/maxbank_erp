<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
 <div class ="row">
    <div class="col-md-12">
        <address>
            <div class="col-xs-8 col-sm-8 col-md-8">
                <div class="infowrap">
                    <dl class="dl-horizontal">
                             <dt>Customer Name :</strong></dt>
                             <dd>${customerInstance?.displayName}</dd>
                    </dl>
                    <dl class="dl-horizontal">
                            <g:if test="${customerInstance?.type?.id == 1}">
                             <dt><strong><strong>Date Of Birth :</strong></strong></dt>
                            </g:if>
                            <g:else>
                                <dt><strong><strong>Registration Date :</strong></strong></dt>
                            </g:else>
                             <dd><g:formatDate format="MM/dd/yyyy" date="${customerInstance?.birthDate}"/></dd>
                    </dl>
                    <dl class="dl-horizontal">
                             <dt><strong><strong>Address :</strong></strong></dt>
                             <dd><g:set var = "address" value="${customerInstance?.addresses?.find{it.isPrimary==true}}"/>
                                <g:if test="${address}">
                                  ${address?.address1}<br>
                                  ${address?.address2}<br>
                                  ${address?.town?.description}<br>
                                  ${address?.address3}<br>
                                </g:if>
                                <g:else>
                                    N/A
                                </g:else>
                             </dd>
                    </dl>
                </div>
            </div>
        </address>
    </div>
</div>