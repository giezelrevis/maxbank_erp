<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.deposit.Rollover" %>
<%@ page import="icbs.admin.Branch" %>
<%@ page import="icbs.admin.UserMaster" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <asset:javascript src="depositHelper.js"/>
        <title>FD Rollover Options</title>
        <g:javascript>
             
            function addRollover(){
                icbs.Deposit.ManualRollover('add',"${createLink(controller : 'deposit', action:'createManualRolloverAjax')}",{id:${depositInstance?.id}});
            }
            function saveRollover(){
                alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                    function(){
                        checkIfAllowed("DEP01800", saveRolloverAuthCallback);
                    },
                    function(){
                        return;
                    });               
            }
            function saveRolloverAuthCallback() {
                icbs.Deposit.ManualRollover('save',"${createLink(controller : 'deposit', action:'saveManualRollover')}",jQuery('#saveRolloverForm').serialize());
            }
            //================================ NEW ADD BY JM
            var paymode = "";
            function changeRolloverForm(){
                
                var rollType = $('#currentRollover').val();
                console.log("rollType: "+rollType);
                
                if(rollType == 1){
                    document.getElementById('rollovetype1').style.display="block";
                    document.getElementById('rollovetype2').style.display="none";
                    document.getElementById('rollovetype3').style.display="none";
                    document.getElementById('rollovetypeEmpty').style.display="none";
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeA').value;
                }
                if(rollType == 2){
                    document.getElementById('rollovetype1').style.display="none";
                    document.getElementById('rollovetype2').style.display="block";
                    document.getElementById('rollovetype3').style.display="none";
                    document.getElementById('rollovetypeEmpty').style.display="none";  
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeB').value;
                }
                if(rollType == 3){
                    document.getElementById('rollovetype1').style.display="none";
                    document.getElementById('rollovetype2').style.display="none";
                    document.getElementById('rollovetype3').style.display="block";
                    document.getElementById('rollovetypeEmpty').style.display="none";
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeC').value;
                }
                if(rollType == 4){
                    document.getElementById('rollovetype1').style.display="none";
                    document.getElementById('rollovetype2').style.display="none";
                    document.getElementById('rollovetype3').style.display="none";
                    document.getElementById('rollovetypeEmpty').style.display="block";
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeD').value;
                }
                
                //var endDateReadyCalculator = document.getElementById('endDateCalculator').value; 


                
                if(paymode == 2){
                    document.getElementById('transfertoDepositBlaBla').style.display="block";
                }else{
                    document.getElementById('transfertoDepositBlaBla').style.display="none";
                }
                    
            }
            function showSignatories(e){
                if(e){
                    if(e.options[e.selectedIndex].value==1){
                        document.getElementById('signatory-main-div').style.display = 'none';
                    }else{
                        document.getElementById('signatory-main-div').style.display = 'block';
                    }
                }
            }
            function getTransferForm(mode){
                console.log("getTransferForm function");
                console.log("mode: "+mode);
                var interestPaymode = mode
                paymode = mode
                console.log("interestPaymode: "+interestPaymode);
                
                if(interestPaymode == 2){
                    document.getElementById('transfertoDepositBlaBla').style.display="block";
                }else{
                    document.getElementById('transfertoDepositBlaBla').style.display="none";
                }
            }
            // this is when the browser is loaded
            $( document ).ready(function() {
                console.log( "ready!" );
                var rollType = $('#currentRollover').val();
                

                
                if(rollType == 1){
                    document.getElementById('rollovetype1').style.display="block";
                    document.getElementById('rollovetype2').style.display="none";
                    document.getElementById('rollovetype3').style.display="none";
                    document.getElementById('rollovetypeEmpty').style.display="none";
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeA').value;
                }
                if(rollType == 2){
                    document.getElementById('rollovetype1').style.display="none";
                    document.getElementById('rollovetype2').style.display="block";
                    document.getElementById('rollovetype3').style.display="none";
                    document.getElementById('rollovetypeEmpty').style.display="none";  
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeB').value;
                }
                if(rollType == 3){
                    document.getElementById('rollovetype1').style.display="none";
                    document.getElementById('rollovetype2').style.display="none";
                    document.getElementById('rollovetype3').style.display="block";
                    document.getElementById('rollovetypeEmpty').style.display="none";
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeC').value;
                    console.log("paymode: "+paymode);
                }
                if(rollType == 4){
                    document.getElementById('rollovetype1').style.display="none";
                    document.getElementById('rollovetype2').style.display="none";
                    document.getElementById('rollovetype3').style.display="none";
                    document.getElementById('rollovetypeEmpty').style.display="block";
                    paymode = document.getElementById('currentRolloverInterestPaymentModeTypeD').value;
                }
                
                console.log("paymode: "+paymode);
                
                if(paymode == 2){
                    document.getElementById('transfertoDepositBlaBla').style.display="block";
                }else{
                    document.getElementById('transfertoDepositBlaBla').style.display="none";
                }
                
            });               
            // ============= initialize modals and authcallbacks
                    var modal;
                            
                    function updateCustomerDetailsForm(params){
                        
                        icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
                    }
                    function updateCustomerDetForm(params){
                        icbs.Deposit.Form.getForm('customerDetails',"${createLink(controller : 'deposit', action:'showCustomerDetailsAjax')}",params);
                    }
                    function initializeCustomerDetailsSearchModal(){
                    
                        modal = new icbs.UI.Modal({id:"customerDetailsModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:updateCustomerDetForm});
                    }
                    function addSignatoryAjax(params){
                        icbs.Deposit.Form.getForm('signatory',"${createLink(controller : 'deposit', action:'addSignatoryFormAjax')}",params);
                    }
                    function initializeSignatorySearchModal(){
                        modal = new icbs.UI.Modal({id:"signatorySearchModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Customer",onCloseCallback:addSignatoryAjax});
                    }
                    
                    function updateRollbackDepositAccountForm(params){
                        console.log("params: "+params.deposit);
                        $('#newFundedDeposit').val(params.deposit);
                        params.boxName = "Transfer to Deposit Account";
                         icbs.Deposit.Form.getForm('rolloverDepositDetails',"${createLink(controller : 'deposit', action:'showDepositDetailsAjax')}",params);
                    }
                    
                    function initializeRollbackToDepositModal(){
                        modal = new icbs.UI.Modal({id:"rollbackToDepositModal",url:"${createLink(controller : 'search', action:'search')}",title:"Search Deposit",onCloseCallback:updateRollbackDepositAccountForm,params:{'searchDomain':'deposit'}});
                    }
                    function saveUpdateRollover(){
                        console.log("use clicks: ");
                        var newfundedDep = $('#newFundedDeposit').val();
                        var startDate = document.getElementById('currentRollover.startDate');
                        var endDate  =  document.getElementById('currentRollover.endDate');
                        var endDateReadyCalculator = document.getElementById('endDateCalculator').value; 
                        var rolltype = $('#currentRollover').val();
                        var oldrolltypeR = $('#oldRolltype').val();
                        
                        var fdinterestPaymentMode = paymode;
                        
                        var depositID = $('#depositId').val();
                        console.log("newfundedDep: "+newfundedDep);
                        var newEndDate = $('#currEndDate').val();

                        console.log("newEndDate: "+newEndDate);
                        if(startDate){
                            startDate=startDate.value;
                        }else{
                            startDate = null;
                        }
                        
                        if(newEndDate){
                            
                        }else{
                            endDate = null;
                        }
                        
                        if(newfundedDep){
                        
                        }else{
                            newfundedDep = null
                        }
                        
                        console.log("startDate: "+startDate);   
                        console.log("endDate: "+newEndDate);
                        console.log("endDateReadyCalculator: "+endDateReadyCalculator);
                        console.log("rolltype: "+rolltype);
                        console.log("depositID: "+depositID);
                        console.log("fdinterestPaymentMode: "+fdinterestPaymentMode)
                        console.log("oldrolltypeR: "+oldrolltypeR);
                        alertify.confirm(AppTitle,"Are you sure about this?",
                          function(){

                            var obj = { 
                                    startDate: startDate,
                                    endDate: newEndDate,
                                    startDate: startDate,
                                    rolltype: rolltype,
                                    depositID: depositID,
                                    newfundedDep: newfundedDep,
                                    fdinterestPaymentMode: fdinterestPaymentMode,
                                    oldrolltypeR: oldrolltypeR,
                            }; 
                            console.log(JSON.stringify(obj));
                            $.ajax({
                                type: "POST",
                                contentType: "application/json",
                                url: "${createLink(controller:'deposit', action: 'newchangeRolloverFormAjax')}",
                                data: JSON.stringify(obj),

                                success: function(data){
                                    if(data.length > 0){

                                        alertify.alert(AppTitle,"You have Successfully Updated Deposit Rollover", function(){
                                            var t_url = '/icbs/deposit/viewManualFdRollover/${depositInstance?.id}';
                                            location.href=t_url;
                                        });
                                    }
                                },
                                error: function(data){
                                    console.log(data);
                                },

                            });
                          },
                          function(){
                            alertify.error('Cancel');
                          }
                        ); // alertify close                        
                    }
            //==============================================
        </g:javascript>
    </head>
    <body>
        <content tag="main-content">
           <div class="row">
                <div class="col-md-12">
                        <!-- ================================================================== -->

<fieldset>
<div id="rolloverForm">
    
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.type', 'has-error')} required">
            <label class="control-label col-sm-4" for="status">
                    <g:message code="rollover.type.label" default="Rollover Type" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:select onchange="changeRolloverForm();" id="currentRollover" name="currentRollover.type.id" from="${icbs.lov.RolloverType.list()}" optionKey="id" optionValue="description" value="${depositInstance? depositInstance.currentRollover?.type?.id:currentRollover.type?.id}" class="many-to-one form-control"/>
                <g:hiddenField id="oldRolltype" name="oldRolltype" value="${depositInstance? depositInstance.currentRollover?.type?.id:currentRollover.type?.id}" />
                <g:hasErrors bean="${depositInstance}" field="currentRollover.type">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>  
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.startDate', 'has-error')} required">
            <label class="control-label col-sm-4" for="startDate">
                    <g:message code="rollover.startDate.label" default="Start Date" />
                    <span class="required-indicator">*</span>
            </label>
          
            <div class="col-sm-8"><g:customDatePicker format="date" disabled="disabled" name="currentRollover.startDate" precision="day" class="form-control"  value="${depositInstance ? depositInstance?.currentRollover?.startDate?:Branch?.get(1).runDate:currentRollover?.startDate}"  />

                <g:hasErrors bean="${depositInstance}" field="currentRollover.startDate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.startDate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.endDate', 'has-error')} required">
            <label class="control-label col-sm-4" for="endDate">
                    <g:message code="rollover.endDate.label" default="End Date" />
                    <span class="required-indicator">*</span>
            </label> 
            <g:hiddenField id="endDateCalculator" name="endDateCalculator" value="${depositInstance ? depositInstance?.currentRollover?.endDate?:Branch?.get(1).runDate +depositInstance?.fixedDepositTermScheme?.value.toInteger():currentRollover?.endDate}"/>
            <div class="col-sm-8"><g:customDatePicker name="currentRollover.endDate" id="currEndDate" precision="day" class="form-control"  value="${depositInstance?.currentRollover?.endDate}"  />
                <g:hasErrors bean="${depositInstance}" field="currentRollover.endDate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.endDate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.interestPaymentMode', 'has-error')} ">
        <div id="rollovetype1">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.interestPaymentMode', 'has-error')} ">
            <label class="control-label col-sm-4" for="interestPaymentMode">
                <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
            </label>
            <div class="col-sm-8">
                <g:select onchange='getTransferForm(this.value);' id="currentRolloverInterestPaymentModeTypeA" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([2,3])}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
            </div>
            </div>
        </div>
        <div id="rollovetype2">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.interestPaymentMode', 'has-error')} ">
            <label class="control-label col-sm-4" for="interestPaymentMode">
                <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
            </label>
            <div class="col-sm-8">
                <g:select onchange='getTransferForm(this.value);' id="currentRolloverInterestPaymentModeTypeB" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([3])}" optionKey="id" optionValue="description" value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
            </div>
            </div>
        </div>
        <div id="rollovetype3">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.interestPaymentMode', 'has-error')} ">
            <label class="control-label col-sm-4" for="interestPaymentMode">
                <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
            </label>
            <div class="col-sm-8">
                <g:select onchange='getTransferForm(this.value);' id="currentRolloverInterestPaymentModeTypeC" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([1,2])}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
            </div>
            </div>
        </div>
        <div id="rollovetypeEmpty">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.interestPaymentMode', 'has-error')} ">
            <label class="control-label col-sm-4" for="interestPaymentMode">
                <g:message onchange='getTransferForm(this.value);' code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
            </label>
            <div class="col-sm-8">
                <g:select id="currentRolloverInterestPaymentModeTypeD" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.getAll()}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
            </div>
            </div>
        </div> 
        
        

                <g:hasErrors bean="${depositInstance}" field="currentRollover.interestPaymentMode">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.interestPaymentMode">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            <!--</div>-->          
    </div>
    <div id="transfertoDepositBlaBla">
        <g:hiddenField name="currentRollover.fundedDeposit" id="currentRollover.fundedDeposit.id" value="${currentRollover?.fundedDeposit?.id}"/>
        <g:hiddenField name="oldfundedDeposit" id="oldfundedDeposit.id" value="${currentRollover?.fundedDeposit?.id}"/>
        <g:hiddenField id="newFundedDeposit" name="newFundedDeposit" value="" />
        <g:hiddenField id="depositId" name="depositId" value="${params.id}" />
         <fieldset class="form-group">
            <div id="rollbackDepositDetailsDiv">
                <g:render template='/deposit/details/depositDetails' model="[depositInstance:depositInstance?.currentRollover?.fundedDeposit,boxName:'Transfer to Deposit Account']"/>
            </div>
            <input type="button" href="#"class="btn btn-secondary"onclick="initializeRollbackToDepositModal();modal.show()"value="Search"/>
        </fieldset>
     </div>   
</div> 
</fieldset>
                        <!-- ================================================================== -->
  
                </div>
            </div>
            </br>
  
            
            
            
        </content>
        
        <content tag="main-actions">
            <ul>
                <g:if test="${depositInstance}">
                    <li><a href="#" onclick="saveUpdateRollover();">Save</a></li>
                </g:if>
                
                <li>
                    <a href=# onclick="alertify.confirm(AppTitle,'Are you sure you want to exit this page?',
                                    function(){
                                    var t_url = '/icbs/deposit/viewManualFdRollover/${depositInstance?.id}';
                                    location.href=t_url;},
                                    function(){});">Cancel</a>
                </li>
            </ul>                                        
        </content>
    </body>
</html>
