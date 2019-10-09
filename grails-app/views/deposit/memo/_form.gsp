
<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<g:if test="${flash.message == "Memo Remittance Successfully made.|success|alert"}">
<div class="nav-tabs-custom">
  <div class="nav-tab-container">
    <ul class="nav nav-tabs">
        <li class="active"><a id="tabLi1"href="#tab_1" data-toggle="tab">Credit Memo Remittance</a></li>
        <li><a id="tabLi2"href="#tab_2" data-toggle="tab" >Debit Memo/Credit Memo Adjustment</a></li>
        <li><a id="tabLi3" href="#tab_3" data-toggle="tab">Debit Memo Bills Payment</a></li>
    </ul>
  </div>
    <div class="tab-content">
        <div class="tab-pane active fade in" id="tab_1">
             <g:form name="remitanceFormSend" controller="deposit" action="saveMemoRemittance">
                <g:hiddenField id="deposit" name="deposit.id"  value="${depositInstance?.id}"/>
                <div id="remittanceForm">
                    <g:render template='memo/form/remittance/credit/form'/>
                </div>
            </g:form>
        </div>
        <div  class="tab-pane" id="tab_2">
            <g:form name="adjustmentFormSend" id="adjustmentFormSend" controller="deposit" action="saveMemoAdjustment">
                <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
                <div id="adjustmentForm">
                    <g:render template='memo/form/creditAdjustment/credit/form'/>
                </div>
            </g:form>
        </div>
        <div class="tab-pane" id="tab_3">
            <g:form name="billsPaymentFormSend" controller="deposit" action="saveMemoBillsPayment">
                <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
                <div id="bilsPaymentForm">
                    <g:render template='memo/form/billsPayment/debit/form'/>
                </div>
            </g:form>
        </div>     
    </div>
</div>
</g:if>

<g:elseif test="${flash.message == "Bills Payment Successfully made.|success|alert"}">
<div class="nav-tabs-custom">
  <div class="nav-tab-container">
    <ul class="nav nav-tabs">
        <li class="active"><a id="tabLi1"href="#tab_1" data-toggle="tab">Debit Memo Bills Payment</a></li>
        <li><a id="tabLi2"href="#tab_2" data-toggle="tab" >Credit Memo Remittance</a></li>
        <li><a id="tabLi3" href="#tab_3" data-toggle="tab">Debit Memo/Credit Memo Adjustment</a></li>
    </ul>
  </div>
    <div class="tab-content">
        <div class="tab-pane active fade in" id="tab_1">
            <g:form name="billsPaymentFormSend" controller="deposit" action="saveMemoBillsPayment">
                <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
                <div id="bilsPaymentForm">
                    <g:render template='memo/form/billsPayment/debit/form'/>
                </div>
            </g:form>
        </div>
        <div  class="tab-pane" id="tab_2">
            <g:form name="remitanceFormSend" controller="deposit" action="saveMemoRemittance">
                <g:hiddenField id="deposit" name="deposit.id"  value="${depositInstance?.id}"/>
                <div id="remittanceForm">
                    <g:render template='memo/form/remittance/credit/form'/>
                </div>
            </g:form>
        </div>
        <div class="tab-pane" id="tab_3">
            <g:form name="adjustmentFormSend" id="adjustmentFormSend" controller="deposit" action="saveMemoAdjustment">
                <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
                <div id="adjustmentForm">
                    <g:render template='memo/form/creditAdjustment/credit/form'/>
                </div>
            </g:form>
           
        </div>     
    </div>
</div>
</g:elseif>

<g:else>
<div class="nav-tabs-custom">
  <div class="nav-tab-container">
    <ul class="nav nav-tabs">
        <li class="active"><a id="tabLi1"href="#tab_1" data-toggle="tab">Debit Memo/Credit Memo Adjustment</a></li>
        <li><a id="tabLi2"href="#tab_2" data-toggle="tab" >Credit Memo Remittance</a></li>
        <li><a id="tabLi3" href="#tab_3" data-toggle="tab">Debit Memo Bills Payment</a></li>
    </ul>
  </div>
    <div class="tab-content">
        <div class="tab-pane active fade in" id="tab_1">
            <g:form name="adjustmentFormSend" id="adjustmentFormSend" controller="deposit" action="saveMemoAdjustment">
                <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
                <div id="adjustmentForm">
                    <g:render template='memo/form/creditAdjustment/credit/form'/>
                </div>
            </g:form>
        </div>
        <div  class="tab-pane" id="tab_2">
            <g:form name="remitanceFormSend" controller="deposit" action="saveMemoRemittance">
                <g:hiddenField id="deposit" name="deposit.id"  value="${depositInstance?.id}"/>
                <div id="remittanceForm">
                    <g:render template='memo/form/remittance/credit/form'/>
                </div>
            </g:form>
        </div>
        <div class="tab-pane" id="tab_3">
            <g:form name="billsPaymentFormSend" controller="deposit" action="saveMemoBillsPayment">
                <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
                <div id="bilsPaymentForm">
                    <g:render template='memo/form/billsPayment/debit/form'/>
                </div>
            </g:form>
        </div>     
    </div>
</div>
</g:else>
