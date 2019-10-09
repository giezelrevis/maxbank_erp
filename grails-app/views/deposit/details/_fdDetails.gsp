<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
    <div class="section-container">
        <g:hiddenField id="depositFromSearch" name="depositFromSearch" value="${depositInstance?.id}"/>
        <fieldset>
        <legend class="section-header">${boxName?boxName:"Fixed Deposit Details"}</legend>
        <div class="infowrap">
            <dl class="dl-horizontal">
                <dt>Ledger Balance</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.ledgerBalAmt}"/></dd>
            </dl>              <dl class="dl-horizontal">
                <dt>Rollover Date</dt>
                <dd><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.currentRollover?.endDate}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Accrued Interest</dt>
                    <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.normalInterestAmt}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Accrued Tax</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt * depositInstance?.depositTaxChargeScheme?.taxRate.div(100)}"/></dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Pre-Term Interest</dt>
                    <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.preTermInterestAmt}"/></dd>
            </dl>            
            <dl class="dl-horizontal">
                <dt>Accrued Tax (Pre-Term)</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.taxAmt2}"/></dd>
            </dl>   
            <dl class="dl-horizontal">
                <dt>Net Normal Interest</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.normalInterestAmt - (depositInstance?.acrintAmt * depositInstance?.depositTaxChargeScheme?.taxRate.div(100))}"/></dd>
            </dl> 
        </div>
        </fieldset>
    </div>