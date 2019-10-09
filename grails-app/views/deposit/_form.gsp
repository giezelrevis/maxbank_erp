<%@ page import="icbs.deposit.Deposit" %>
<%@ page import="icbs.admin.Branch" %>
<div class="nav-tabs-custom">
 <%--  <g:textField id="rollo" name="rollo" value="DEPTYPEID+ ${depositInstance?.type?.id}"/>
    <g:textField id="rollo1" name="rollo1" value="DEPID+ ${depositInstance?.id}"/>
    <g:textField id="roll1" name="roll1" value="CURROLLTYPEID+ ${currentRollover?.type?.id}"/>
    <g:textField id="roll2" name="roll2" value="DEPCURROLLTYPEID+ ${depositInstance?.currentRollover?.type?.id}"/>
    <g:textField id="roll3" name="roll3" value="PAYMENTMODE+ ${interestPaymentMode}"/>
    <g:textField id="roll4" name="roll4" value="DEPPAYMENTID+ ${depositInstance?.currentRollover?.interestPaymentMode?.id}"/>
--%>
<g:hiddenField id="RollTerm" name="RollTerm" />
<g:hiddenField id="DepSchemValMin" name="DepSchemValMin" value="${depositInstance?.fixedDepositTermScheme?.termMin}"/>
<g:hiddenField id="DepSchemValMax" name="DepSchemValMax" value="${depositInstance?.fixedDepositTermScheme?.termMax}"/>
<g:hiddenField id="DepTypeId" name="DepTypeId" value="${depositInstance?.type?.id}"/>

    <g:if test="${depositInstance?.acctNo}">
      <table style="width:100%; padding:15px;" >
        <tr>
            <td><h3>Account Number: ${depositInstance?.acctNo}</h3></td>
            <td></td>
            <td><h3>Customer Name: ${depositInstance?.acctName}</h3></td>
        </tr>
      </table>
    </g:if>

                <div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a id="tabLi1"href="#tab_1" data-toggle="tab">Basic Information</a></li>
                        <li><a id="tabLi2"href="#tab_2" data-toggle="tab" >Account Information</a></li>
                        <li><a id="tabLi3"href="#tab_3" data-toggle="tab" >Signatories</a></li>
                        <g:if test="${depositInstance?.type?.id==3 && !depositInstance?.id}">
                            <li><a id="tabLi4"href="#tab_4" data-toggle="tab" >Rollover</a></li>
                        </g:if>
                       <g:if test="${depositInstance?.type?.id==3 && depositInstance?.id }">
                            <!--<li><a id="tabLi4"href="#tab_4" data-toggle="tab" >Edit Rollover</a></li> -->
                        </g:if>
                        <g:if test="${depositInstance?.id}">
                            <li><a id="tabLi5"href="#tab_5" data-toggle="tab" >Status</a></li>
                        </g:if>
                    </ul>
                </div>
                <div class="tab-content">
                    <div class="tab-pane active fade in" id="tab_1">
                        <g:render template="form/basicInfo/basicInfo"/>
                    </div>   
                    <div class="tab-pane fade in" id="tab_2">
                        <g:render template="form/acctInfo/acctInfo"/>
                    </div> 
                    <div class="tab-pane fade in" id="tab_3">
                        <g:render template="form/signatory/signatoryInfo"/>
                    </div>
                    <g:if test="${depositInstance?.type?.id==3 && !depositInstance?.id}">
                        <div class="tab-pane fade in" id="tab_4">
                            <g:render template="form/rollover/form"/>
                        </div>
                    </g:if>
                    <g:if test="${depositInstance?.type?.id==3 && depositInstance?.id}">
                        <div class="tab-pane fade in" id="tab_4">
                            <%-- <g:render template="form/rollover/form1"/> --%>
                        </div> 
                    </g:if>
                    <g:if test="${depositInstance?.id}">
                        <div class="tab-pane fade in" id="tab_5">
                            <g:render template="form/status/form"/>
                        </div>
                    </g:if>
                </div>
</div>
 <g:javascript>
    function changeAcctInformation(){
    jQuery.ajax({type:'POST', 
            data:{depositType:$('#depositType :select').serialize()},
            url:"${createLink(controller : 'deposit', action:'changeAcctInformationFormAjax')}",
            success:function(data,textStatus){
                $('#acctInfoDiv').html(data);
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                alert(errorThrown);
            }
        });
    
    }
    function openCustomerDetailsModal(){
        
    }
    $('#customerDetailsModal').on('hidden.bs.modal', function () {
        if(CIDRET){
            updateCustomerDetailsForm(CIDRET);
        }
    })
    $('#customerDetailsModal').on('shown.bs.modal', function () {
        jQuery.ajax({type:'POST', 
            url:'/icbs/search/search',
            success:function(data,textStatus){
                jQuery('#customerDetailSearchDiv').html(data);
                jQuery('#customerDetailsDiv').modal('show');
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                alert(textStatus +errorThrown);
            }
        }) 
    })
    function updateCustomerDetailsForm(CIDRET){
        jQuery.ajax({type:'POST', 
            data:{customer:CIDRET},
            url:"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",
            success:function(data,textStatus){
                $('#customerDetailsDiv').html(data);
                CIDRET=null;
            },
            error:function(XMLHttpRequest,textStatus,errorThrown){
                CIDRET=null;
                alert(errorThrown);
            }
        });
    }
</g:javascript>
