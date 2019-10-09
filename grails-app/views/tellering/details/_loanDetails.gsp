<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
    <div class="section-container">
        <fieldset>
        <legend class="section-header">Account Information</legend>
        <div class="infowrap">
        <div class="col-xs-8 col-sm-6 col-md-6">
            <dl class="dl-horizontal">
                <dt>Account ID</dt>
                <dd id="acctId">${loanInstance?.id}</dd>
            </dl>
             <dl class="dl-horizontal">
                <dt>Account Number</dt>
                <dd id="accountNo">${loanInstance?.accountNo}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Account Name</dt>
                <dd id="customer">${loanInstance?.customer?.displayName}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>DOSRI Classification</dt>
                <dd>${loanInstance?.customer?.dosriCode?.description}</dd>
            </dl>            
            <dl class="dl-horizontal">
                <dt>Date Opened</dt>
                <dd id="openingDate"><g:formatDate  format="MM/dd/yyyy" date="${loanInstance?.openingDate}" /></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Status</dt>
                <dd id="status">${loanInstance?.status}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Principal</dt>
                <dd id="principal">${loanInstance?.balanceAmount}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Interest</dt>
                <dd id="interest">${loanInstance?.interestBalanceAmount}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Penalty</dt>
                <dd id="penalty">${loanInstance?.penaltyBalanceAmount}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Service Charge</dt>
                <dd id="serviceCharge">${loanInstance?.serviceChargeBalanceAmount}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Tax</dt>
                <dd id="tax">${loanInstance?.taxBalanceAmount}</dd>
            </dl>
            
            <dl class="dl-horizontal">
                <dt>Principal</dt>
                <dd id="principal1"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.balanceAmount}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Interest</dt>
                <dd id="intrest1"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.interestBalanceAmount}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Penalty</dt>
                <dd id="penalty1"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.penaltyBalanceAmount}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Service Charge</dt>
                <dd id="sc1"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.serviceChargeBalanceAmount}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Tax</dt>
                <dd id="tax1"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.taxBalanceAmount}"/></dd>
            </dl>
            
            <dl class="dl-horizontal">
                <dt>Others</dt>
                <dd id="others">${0}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Granted Amount</dt>
                <dd id="grantedAmt"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.grantedAmount}"/></dd>
            </dl>             
            <dl class="dl-horizontal">
                <dt>Amount for Disbursement</dt>
                <dd id="totalNetProceeds1"><g:formatNumber format="###,###,##0.00" number="${loanInstance?.totalNetProceeds - loanInstance?.totalDisbursementAmount}"/></dd>
            </dl>
           
        </div>
<g:if test="${loanInstance?.customer?.infobases}">
  <div class="col-xs-12 col-sm-12">
    <div class="section-container">
      <fieldset>
        <legend class="section-header">Customer Infobase</legend>
          <div class="infowrap">
            <g:each in="${loanInstance?.customer?.infobases}" status="i" var="infobase">
              <g:if test="${infobase.status.id==2}">
                <dd>
                  ${fieldValue(bean: infobase, field: "infoMessage")}
                </dd>   
              </g:if>
            </g:each>
        </div>
      </fieldset>
    </div>
  </div>    
</g:if>        
        <div class="infowrap">
            <dl class="dl-horizontal">
                <dd id="photo"><g:if test="${(loanInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" style="float:right" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (loanInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></dd>
            </dl>
        </div>
        </div>
        </fieldset>
    </div>
    <g:if test="${loanInstance?.id}">
        <input type="hidden" id="id_loan" value="${loanInstance?.id}">
        <input type="hidden" id="disbamt" value="${loanInstance?.totalNetProceeds - loanInstance?.totalDisbursementAmount}">
        <!--<input type="text" id="disb" value="${loanInstance?.totalDisbursementAmount}">-->
        <script>
                id_loan = $('#id_loan').val();
                $('#loanId').val(id_loan);
//                disb = $('#disb').val();
//                $('#Net_Disburse').val(2);
                if(document.title == 'Loan Proceeds Disbursement Transaction [ICBS]')
                {
                     $('#totalNetProceeds').val(disbAmt.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
                }
        </script>
    </g:if>