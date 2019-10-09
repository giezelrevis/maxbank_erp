<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.deposit.IssuePassbook" %>
<%@ page import="icbs.cif.CustomerInfobase" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>

    <div class="section-container">
        <fieldset>
            
        <legend class="section-header">Account Information</legend>
       
            <script>
                
                if(document.title == 'Fixed Deposit Interest Withdrawal Transaction [ICBS]')
                {
                    FDpassbookBalAmt.value = 0;
                    FDwithdraw.value = 0;
                    txnRef.value = '';
                }
                
               
            </script>
            
        <div class="infowrap">
        <div class="col-xs-8 col-sm-6 col-md-6">
            <dl class="dl-horizontal">
                <dt>Account Number</dt>
                <dd>${depositInstance?.acctNo}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Account Name</dt>
                <dd>${depositInstance?.acctName}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>DOSRI Classification</dt>
                <dd>${depositInstance?.customer?.dosriCode?.description}</dd>
            </dl>
            <dl class="dl-horizontal">
                <g:if test="${depositInstance?.typeId == 3}">
                     <dt>Placement Date</dt>
                     <dd><g:formatDate  format="MM/dd/yyyy" date="${depositInstance?.dateOpened}" /></dd>
                </g:if>
                <g:else>
                     <dt>Date Opened</dt>
                     <dd><g:formatDate  format="MM/dd/yyyy" date="${depositInstance?.dateOpened}" /></dd>                    
                </g:else>    
            </dl>
            <dl class="dl-horizontal">
                <dt>Status</dt>
                <dd id="dpstatus">${depositInstance?.status}</dd>
            </dl>
            <g:if test="${IssuePassbook?.findAllByDepositAndCanceledAtIsNull(depositInstance)?.size()!=0}">
            <dl class="dl-horizontal">
                <dt>With Passbook</dt>
                <dd id="IssuePassbook">Yes</dd>
            </dl>            
            </g:if>    
            <g:else>
            <dl class="dl-horizontal">
                <dt>With Passbook</dt>
                <dd id="IssuePassbook">No</dd>
            </dl>            
            </g:else>
            <dl class="dl-horizontal">
                <dt>Branch</dt>
                <dd id="branchOrigin">${depositInstance?.branch?.name}</dd>
            </dl>  
        </div>
        <g:if test="${depositInstance?.typeId == 3}">
          <div class="col-xs-8 col-sm-6 col-md-6">        
            <dl class="dl-horizontal">
                <dt>Principal Amount</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.availableBalAmt}"/></dd>
            </dl>     
            <dl class="dl-horizontal">
                <dt>Rate</dt>
                <dd>${depositInstance?.interestRate}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Rollover Date</dt>
                <dd><g:formatDate  format="MM/dd/yyyy" date="${depositInstance?.currentRollover?.startDate}" /></dd>
            </dl>   
            <dl class="dl-horizontal">
                <dt>Maturity Date</dt>
                <g:if test="${depositInstance?.depositInterestScheme?.fdMonthlyTransfer==true}">
                    <dd><g:formatDate  format="MM/dd/yyyy" date="${depositInstance?.maturityDate}" /></dd>
                </g:if>
                <g:else>
                    <dd><g:formatDate  format="MM/dd/yyyy" date="${depositInstance?.currentRollover?.endDate}" /></dd>
                </g:else>
            </dl> 
            <dl class="dl-horizontal">
                <dt>Term</dt>
                <dd><g:formatNumber format="##,###" number="${depositInstance?.maturityDate - depositInstance?.currentRollover?.startDate}"/></dd>
            </dl>  
            <dl class="dl-horizontal">
                <dt>Accrued Interest</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.acrintAmt}"/></dd>
            </dl>
            <g:if test="${depositInstance?.type?.id==3}">
            <dl class="dl-horizontal">
                <dt>Pre-term Interest</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.preTermInterestAmt}"/></dd>
            </dl>
            </g:if>
            <g:else>
            <dl class="dl-horizontal">
                <dt>Interest Earned</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.preTermInterestAmt}"/></dd>
            </dl>                
            </g:else>
            <g:if test="${depositInstance?.type?.id==3 && depositInstance?.currentRollover?.type == 1}">
            <dl class="dl-horizontal">
                <dt>Withholding Tax</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.taxAmt2}"/></dd>
            </dl>                 
            </g:if>
            <g:if test="${depositInstance?.type?.id==3 && depositInstance?.currentRollover?.type != 1}">
            <dl class="dl-horizontal">
                <dt>Withholding Tax</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.currentRollover?.taxAmt1}"/></dd>
            </dl>                 
            </g:if>            
            <g:else>    
            <dl class="dl-horizontal">
                <dt>Withholding Tax</dt>
                <dd><g:formatNumber format="###,###,##0.00" number="${depositInstance?.taxWithheld}"/></dd>
            </dl>  
            </g:else>
          </div>
        </g:if>     
<g:if test="${CustomerInfobase.findAllByCustomerAndStatus(depositInstance?.customer,ConfigItemStatus.get(2))}">
  <div class="col-xs-12 col-sm-12">
    <div class="section-container">
      <fieldset>
        <legend class="section-header">Customer Infobase</legend>
          <div class="infowrap">
            <g:each in="${CustomerInfobase.findAllByCustomerAndStatus(depositInstance?.customer,ConfigItemStatus.get(2))}" status="i" var="infobase">
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
                <dd><g:if test="${(depositInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id}"> <img width="120px" style="float:right" height="120px"src="${createLink(controller:'Attachment', action:'show', id: (depositInstance?.customer?.attachments?.find{it.isPrimaryPhoto==true})?.id )}"/></g:if></dd>
            </dl>
        </div>
        <div>
            <g:hiddenField id="deposit" name="deposit.id" value="${depositInstance?.id}"/>
        </div>
        
        <script>
        function addCommas(nStr)
        {
            nStr += '';
            x = nStr.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }
        </script>
        <input type="hidden" id="www" value="${rollenddate}">
        <input type="hidden" id="ww" value="${branchrundate}">
        <input type="hidden" id="w" value="${dateclosing}">
        <input type="hidden" id="netRollover" value="${depositInstance?.netRolloverInterestAmt}">
        <input type="hidden" id="x4" value="${depositInstance?.currentRollover?.typeId}">
        <input type="hidden" id="x5" value="${depositInstance?.currentRollover?.interestPaymentModeId}">         
        <!--
        <g:if test="${IssuePassbook?.findAllByDepositAndCanceledAtIsNull(depositInstance)?.size()!=0}">
            <script>
                Passbook = 1
                $('#Passbook').val(1);
                alert(Passbook);
            </script>    
        </g:if>    
       -->
        <g:if test="${depositInstance?.currentRollover?.startDate == depositInstance?.branch?.runDate && depositInstance?.status?.id != 7}">
            
            <input type="hidden" id="xxx" value="${depositInstance?.availableBalAmt}">
            <input type="hidden" id="xx" value="${depositInstance?.acrintAmt}">
            <input type="hidden" id="x" value="${depositInstance?.currentRollover?.taxAmt1}">
            <script>
                    passBalAmt = accounting.unformat($('#xxx').val()-0);
                    BalAmt = passBalAmt.toFixed(2);
                    $('#FDpassbookBalAmt').val(accounting.formatNumber(BalAmt,2));
                    $('#passbookBal').val(accounting.formatNumber(BalAmt,2));
//                    interest_ = parseFloat($('#xx').val());
//                    tax_ = parseFloat($('#x').val());
//                    $('#FDwithdraw').val(addCommas(interest_.toFixed(2)-tax_.toFixed(2)));
                    NetRollInt = accounting.unformat($('#xx').val()) - accounting.unformat($('#x').val());
                    console.log('netrollint? '+NetRollInt);
                    if(NetRollInt == 'NaN')
                    {
                        NetRollInt = 0;
                    }
                    $('#FDwithdraw').val(accounting.formatNumber(NetRollInt.toFixed(2),2));
                    FDDepId = $('#deposit').val();
                    $('#FDDepID').val(FDDepId);
                    //$('#debitAmt').val(999);
            </script>
        </g:if>
        <g:elseif test="${dateclosing == branchrundate}">
            <input type="hidden" id="xxx" value="${depositInstance?.availableBalAmt}">
            <input type="hidden" id="xx" value="${depositInstance?.currentRollover?.preTermInterestAmt}">
            <input type="hidden" id="x" value="${depositInstance?.currentRollover?.taxAmt2}">
            <script>
                    passBalAmt = accounting.unformat($('#xxx').val()-0);
                    BalAmt = passBalAmt.toFixed(2);
                    $('#FDpassbookBalAmt').val(accounting.formatNumber(BalAmt,2));
                    $('#passbookBal').val(accounting.formatNumber(BalAmt,2));
//                    interest_ = accounting.unformat($('#xx').val());
//                    tax_ = parseFloat($('#x').val());
                    Inter = $('#xx').val();
                    if(!Inter)
                    Inter = 0;
                    interest_ = accounting.unformat(Inter);
                    Taxx = $('#x').val();
                    if(!Taxx)
                    Taxx = 0;
                    tax_ = parseFloat(Taxx);
                    //$('#FDwithdraw').val(accounting.formatNumber(accounting.unformat(BalAmt)+interest_-tax_,2));
                    $('#FDwithdraw').val(accounting.formatNumber(accounting.unformat(BalAmt),2));
                    FDDepId = $('#deposit').val();
                    $('#FDDepID').val(FDDepId);
                    //$('#debitAmt').val(1);
            </script>
        </g:elseif>        
        <g:elseif test="${depositInstance?.currentRollover?.typeId == 2 && depositInstance?.currentRollover?.interestPaymentModeId == 1 && depositInstance?.status?.id == 2}">

                    <input type="hidden" id="xxx" value="${depositInstance?.availableBalAmt}">
                    <input type="hidden" id="xx" value="${depositInstance?.acrintAmt}">
                    <input type="hidden" id="x" value="${depositInstance?.currentRollover?.taxAmt1}">
                    <script>
                            passBalAmt = accounting.unformat($('#xxx').val()-0);
                            BalAmt = passBalAmt.toFixed(2);
                            $('#FDpassbookBalAmt').val(accounting.formatNumber(BalAmt,2));
                            $('#passbookBal').val(accounting.formatNumber(BalAmt,2));
        //                    interest_ = parseFloat($('#xx').val());
        //                    tax_ = parseFloat($('#x').val());
        //                    $('#FDwithdraw').val(addCommas(interest_.toFixed(2)-tax_.toFixed(2)));
                            NetRollInt = accounting.unformat($('#xx').val()) - accounting.unformat($('#x').val());
                            console.log('netrollint? '+NetRollInt);
                            if(NetRollInt == 'NaN')
                            {
                                NetRollInt = 0;
                            }
                            $('#FDwithdraw').val(accounting.formatNumber(NetRollInt.toFixed(2),2));
                            FDDepId = $('#deposit').val();
                            $('#FDDepID').val(FDDepId);
                            //$('#debitAmt').val(999);
                    </script>

        </g:elseif>
        <g:elseif test="${depositInstance?.currentRollover?.typeId == 1 && depositInstance?.currentRollover?.interestPaymentModeId == 1 && depositInstance?.status?.id == 2}">

                    <input type="hidden" id="xxx" value="${depositInstance?.availableBalAmt}">
                    <input type="hidden" id="xx" value="${depositInstance?.acrintAmt}">
                    <input type="hidden" id="x" value="${depositInstance?.currentRollover?.taxAmt1}">
                    <script>
                            passBalAmt = accounting.unformat($('#xxx').val()-0);
                            BalAmt = passBalAmt.toFixed(2);
                            $('#FDpassbookBalAmt').val(accounting.formatNumber(BalAmt,2));
                            $('#passbookBal').val(accounting.formatNumber(BalAmt,2));
        //                    interest_ = parseFloat($('#xx').val());
        //                    tax_ = parseFloat($('#x').val());
        //                    $('#FDwithdraw').val(addCommas(interest_.toFixed(2)-tax_.toFixed(2)));
                            NetRollInt = accounting.unformat($('#xx').val()) - accounting.unformat($('#x').val());
                            console.log('netrollint? '+NetRollInt);
                            if(NetRollInt == 'NaN')
                            {
                                NetRollInt = 0;
                            }
                            $('#FDwithdraw').val(accounting.formatNumber(NetRollInt.toFixed(2),2));
                            FDDepId = $('#deposit').val();
                            $('#FDDepID').val(FDDepId);
                            //$('#debitAmt').val(999);
                    </script>

        </g:elseif> 
        <g:else>
            <input type="hidden" id="yyy" value="${depositInstance?.availableBalAmt}">
            <script>
                //alert($('#FDDepID').val());
                passBalAmt = accounting.unformat($('#yyy').val() - 0);
                BalAmt = passBalAmt.toFixed(2);
                $('#passbookBal').val(accounting.formatNumber(BalAmt,2));
                $('#deposit_no').val(${depositInstance?.id});
            </script>
        </g:else>
   
        </div>
        </fieldset>
    </div>