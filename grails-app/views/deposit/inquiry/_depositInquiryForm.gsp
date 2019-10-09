<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="row">
      <div class="col-md-12">
        <h3>Account Number: ${depositInstance?.acctNo}</h3>
      </div>
</div>

<div class="row">
    <div class="col-md-12">
        <g:render template='/customer/details/newCustomerDetailedInfo' model="[customerInstance:depositInstance?.customer]"/>

    </div>
</div>
<div class="row">
    <div class="col-md-12">
    <div class="section-container">
        <fieldset>
        <legend class="section-header"> Account Information </legend>

            
                <table class="table table-bordered table-striped">
                    <tbody>
                        <tr>
                            <td style="font-weight:bold" width="30%">Account Status</td>
                            <td width="70%">${depositInstance?.status?.description}</td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold" width="30%">Branch</td>
                            <td width="70%">${depositInstance?.branch.name}</td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold" width="30%">Account Name</td>
                            <td width="70%">${depositInstance?.acctName}</td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold" width="30%">Deposit Product</td>
                            <td width="70%">${depositInstance?.product.name}</td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold" width="30%">Interest Rate</td>
                            <td width="70%"><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/>%</td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold" width="30%">General Ledger Code</td>
                            <td width="70%">${depositInstance?.glLink?.description}</td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold" width="30%">Currency</td>
                            <td width="70%">${depositInstance?.product?.currency?.name}</td>
                        </tr> 
                    </tbody>
                </table>
            </div>

        </fieldset>
    </div>
</div>
<div class="row">    
    <div class="col-md-12">
      
         <div class="section-container">
                    <fieldset>
                        <legend class="section-header">Balance Information</legend>
                        <table class="table table-bordered table-striped">
                                <tbody>
                                    <g:if test="${depositInstance?.status?.id==7 && depositInstance?.ledgerBalAmt==0}">
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Current Balance</td>
                                        <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.ledgerBalAmt}"/></td>
                                    </tr>
                                    </g:if>
                                    <g:else>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Current Balance</td>
                                        <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.ledgerBalAmt}"/></td>
                                    </tr>   
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Available Balance</td>
                                        <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.availableBalAmt}"/></td>
                                    </tr> 
                                    <g:if test="${ depositInstance?.type?.id == 1}">
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Passbook Balance</td>
                                        <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.passbookBalAmt}"/></td>
                                    </tr>
                                    </g:if>
                                    <tr>
                                        <td style="font-weight:bold" width="30%">Hold Balance</td>
                                        <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.holdBalAmt}"/></td>
                                    </tr>
                                    <g:if test="${depositInstance?.type?.id == 3 && depositInstance?.currentRollover?.status?.id == 1}">
                                        <g:if test="${depositInstance?.status?.id == 7}">        
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Accrued Interest</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt}"/></td>
                                        </tr>
                                        </g:if>
                                        <g:else>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Accrued Interest</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.normalInterestAmt}"/></td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Pre-Term Interest</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.preTermInterestAmt}"/></td>
                                        </tr>
                                        </g:else>    
                                    </g:if>
                                    <g:else>
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Accrued Interest</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt}"/></td>
                                        </tr> 
                                        <tr>
                                            <td style="font-weight:bold" width="30%">Last EOM ADB</td>
                                            <td width="70%"><g:formatNumber format="###,###,##0.00" number="${depositInstance?.lmAveBalAmt}"/></td>
                                        </tr>
                                    </g:else>           
                                    </g:else>    
                                </tbody>
                        </table>        
                    </fieldset>
                </div>
       </div>
</div>





<div class="row">
      <div class="section-container">
            <fieldset>
                <legend class="section-header">Other Owners/Signatories</legend>
                    <table class="table table-bordered table-striped">
                        <tbody>
                            <tr>
                                <td style="font-weight:bold" width="30%">Ownership Type</td>
                                <td width="70%">${depositInstance?.ownershipType?.description}</td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Signatory Rules</td>
                                <td width="70%">${depositInstance?.sigRules}</td>
                            </tr>
                            <tr>
                                <td style="font-weight:bold" width="30%">Signatory Remarks</td>
                                <td width="70%">${depositInstance?.sigRemarks}</td>
                            </tr>
                        </tbody>
                    </table>    
                    <div class="table-responsive col-md-12">
                        <g:if test="${depositInstance?.signatories?.size()>0}">
                            <table id="signatoryTable" class="table table-hover table-condensed table-striped">
                                <tr>
                                    <td><label>CID</label></td>
                                    <td><label>Name</label></td>
                                    <td><label>Signatory</label></td>
                                </tr>
                                <tbody height="100px">
                                    <div id="signatoryList">
                                        <g:each var="signatory" in="${depositInstance?.signatories}" status="i">
                                            <g:if test="${signatory.status.id!=3}">
                                                <g:render template='form/signatory/onetomany/signatory' model="[signatory:signatory,i:i,displayOnly:'true']"/>
                                            </g:if>
                                        </g:each>
                                </tbody>
                            </table>
                        </g:if>
                    </div>                      
            </fieldset>
        </div>
    </div>


