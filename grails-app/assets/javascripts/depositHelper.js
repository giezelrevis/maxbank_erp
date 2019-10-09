/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

ns("icbs.Deposit.Form");
icbs.Deposit.Events = function(){
    icbs.Dependencies.Ajax.addLoadEvent(function(){
        //Load Event ng 
    })
}
icbs.Deposit.fundTransfer = function(callThis,url,params){
    var changeFundedAcctFormCallback=function(data,params){
        $('#transactionDetailsDiv').html(data.txnDetails);
        $('#creditAccountDiv').html(data.creditAcct);
    }
     var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='changeFundedAcctFormCallback'){ajax.run({url:url,params:params,callback:changeFundedAcctFormCallback,dataType:'json'});}
    };
    sendUpdate(callThis,url,params);
}
icbs.Deposit.interestRateMaintenance = function(callThis,url,params){
    var changeInterestRateViewCallback = function(data,params){
        jQuery('#allAcctDiv').html(data);
    }
    var editAllAcctsCallback = function(data,params){
        jQuery('#editAllAcctModal .modal-body').html(data);
        $('#editAllAcctModal').modal({show:true});
    } 
    var editSpecificAcctsCallback = function(data,params){
        jQuery('#editSpecificAcctModal .modal-body').html(data);
        $('#editSpecificAcctModal').modal({show:true});
    }
    
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='changeInterestRateViewCallback'){ajax.run({url:url,params:params,callback:changeInterestRateViewCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editPassbookCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updatePassbookCallback});}
    };
     sendUpdate(callThis,url,params);
}
ns("icbs.Deposit.DepositInterestScheme.Form");
icbs.Deposit.DepositInterestScheme.Form.getForm=function(callThis,url,choice){
    var graduatedCallback=function(data,params){
        jQuery('#graduatedList').append(data);
        icbs.Deposit.DepositInterestScheme.Form.getForm.graduatedCount++;
    }
    var get = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='graduated'){ajax.run({url:url,params:{i:icbs.Deposit.DepositInterestScheme.Form.getForm.graduatedCount},callback:graduatedCallback});}
    }
    get(callThis,url,choice);
}

icbs.Deposit.DepositInterestScheme.Form.getForm.graduatedCount = 0;
icbs.Deposit.Form.getForm = function(callThis,url,choice){
    var changeTypeCallback = function(data,params){
        $('#typeAndProductSchemeDiv').html(data)
    }
    var changeProductCallback =function(data,params){
        $('#typeAndProductSchemeDiv').html(data)
    }
    var signatoryCallback = function(data,params){
        $('#signatoryTable > tbody:last').append(data);
    };
    var getRolloverDepositDetailsCallback = function(data,params){
          $('#rollbackDepositDetailsDiv').html(data);
          document.getElementById('currentRollover.fundedDeposit.id').value = document.getElementById('depositFromSearch').value;
    };
    var getCustomerDetailsCallback = function(data,params){
          $('#customerDetailsDiv').html(data);
    };
     var changeRollbackCallback = function(data,params){
          $('#tab_4').html(data);
    };
    
    var get = function(callThis,url,params){
        //initialize count if not set.
        var count = $('.'+callThis+'-div').length;
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='type'){ajax.run({url:url,params:params+"&changeType=type",callback:changeTypeCallback});}
        if(callThis==='product'){ajax.run({url:url,params:params+"&changeType=product",callback:changeProductCallback});}
        //if(callThis==='scheme'){if(params.customer2){ajax.run({url:url,params:{},callback:changeSchemeCallback});}}
        if(callThis==='customerDetails'){ajax.run({url:url,params:{customer:params.customer2,boxName:params.boxName},callback:getCustomerDetailsCallback});}
        if(callThis==='rolloverDepositDetails'){ajax.run({url:url,params:{deposit:params.deposit,boxName:params.boxName},callback:getRolloverDepositDetailsCallback});}
        if(callThis==='signatory'){if(params.customer2){ajax.run({url:url,params:{deposit:params.deposit,signatory:params.customer2,i:count},callback:signatoryCallback});}}
        if(callThis==='rollback'){ajax.run({url:url,params:params,callback:changeRollbackCallback});}
    };
    get(callThis,url,choice);
};
icbs.Deposit.Infobase = function(callThis,url,params){
    var changeRemittanceFormCallback=function(data,params){
        $('#remittanceForm').html(data)
    }
    var changeAdjustmentFormCallback=function(data,params){
        $('#adjustmentForm').html(data)
    }
    var changeBillsPaymentFormCallback=function(data,params){
        $('#bilsPaymentForm').html(data)
    }
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='remForm'){ajax.run({url:url,params:params,callback:changeRemittanceFormCallback});}
        if(callThis==='adjForm'){ajax.run({url:url,params:params,callback:changeAdjustmentFormCallback});}
        if(callThis==='billsForm'){ajax.run({url:url,params:params,callback:changeBillsPaymentFormCallback});}
    }
    sendUpdate(callThis,url,params);
}
icbs.Deposit.ClearChecks = function(callThis,url,params){
    var editChecksCallback=function(data,params){
        $('#remittanceForm').html(data)
    }
    var updateChecksCallback=function(data,params){
        $('#adjustmentForm').html(data)
    }
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='edit'){ajax.run({url:url,params:params,callback:editChecksCallback});}
        if(callThis==='update'){ajax.run({url:url,params:params,callback:updateChecksCallback});}
    }
    sendUpdate(callThis,url,params);
}
icbs.Deposit.Memo = function(callThis,url,params){
    var changeRemittanceFormCallback=function(data,params){
        $('#remittanceForm').html(data)
    }
    var changeAdjustmentFormCallback=function(data,params){
        $('#adjustmentForm').html(data)
    }
    var changeBillsPaymentFormCallback=function(data,params){
        $('#bilsPaymentForm').html(data)
    }
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='remForm'){ajax.run({url:url,params:params,callback:changeRemittanceFormCallback});}
        if(callThis==='adjForm'){ajax.run({url:url,params:params,callback:changeAdjustmentFormCallback});}
        if(callThis==='billsForm'){ajax.run({url:url,params:params,callback:changeBillsPaymentFormCallback});}
    }
    sendUpdate(callThis,url,params);
}   
icbs.Deposit.CTD = function(callThis,url,params){
    var ctdFormCallback = function(data,params){
        jQuery('#showCTDFormDiv').html(data);
    };
    var addCTDCallback = function(data,params){
        jQuery('#addCTDModal .modal-body #add').html(data);
        $('#addCTDModal').modal({show:true});
     };
    var saveCTDCallback = function(data,params){
        jQuery('#addCTDModal .modal-body #add').html(data);
    };
    var editCTDCallback = function(data,params){
        jQuery('#editCTDModal .modal-body #edit').html(data);
        $('#editCTDModal').modal({show:true});
    };
    var updateCTDCallback = function(data,params){
        jQuery('#editCTDModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='ctdForm'){ajax.run({url:url,params:params,callback:ctdFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addCTDCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveCTDCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editCTDCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateCTDCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.Passbook = function(callThis,url,params){
    var passbookFormCallback = function(data,params){
        jQuery('#showPassbookFormDiv').html(data);
    };
    var addPassbookCallback = function(data,params){
        jQuery('#addPassbookModal .modal-body #add').html(data);
        $('#addPassbookModal').modal({show:true});
     };
    var savePassbookCallback = function(data,params){
        jQuery('#addPassbookModal .modal-body #add').html(data);
    };
    var editPassbookCallback = function(data,params){
        jQuery('#editPassbookModal .modal-body #edit').html(data);
        $('#editPassbookModal').modal({show:true});
    };
    var updatePassbookCallback = function(data,params){
        jQuery('#editPassbookModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='passbookForm'){ajax.run({url:url,params:params,callback:passbookFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addPassbookCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:savePassbookCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editPassbookCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updatePassbookCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.Checkbook = function(callThis,url,params){
    var viewChecksCallback = function(data,params){
        jQuery('#viewChecksModal').html(data);
        $('#viewChecksModal').modal({show:true});
    };
    var checkbookFormCallback = function(data,params){
        jQuery('#showCheckbookFormDiv').html(data);
    };
    var addCheckbookCallback = function(data,params){
        jQuery('#addCheckbookModal .modal-body #add').html(data);
        $('#addCheckbookModal').modal({show:true});
     };
    var saveCheckbookCallback = function(data,params){
        jQuery('#addCheckbookModal .modal-body #add').html(data);
    };
    var editCheckbookCallback = function(data,params){
        jQuery('#editCheckbookModal .modal-body #edit').html(data);
        $('#editCheckbookModal').modal({show:true});
    };
    var updateCheckbookCallback = function(data,params){
        jQuery('#editCheckbookModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='viewChecks'){ajax.run({url:url,params:params,callback:viewChecksCallback});}
         if(callThis==='checkbookForm'){ajax.run({url:url,params:params,callback:checkbookFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addCheckbookCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveCheckbookCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editCheckbookCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateCheckbookCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.Hold = function(callThis,url,params){
    var holdFormCallback = function(data,params){
        jQuery('#showHoldFormDiv').html(data);
    };
    var addHoldCallback = function(data,params){
        jQuery('#addHoldModal .modal-body #add').html(data);
        datepickerInitializer();
        $('#addHoldModal').modal({show:true});
     };
    var saveHoldCallback = function(data,params){
        jQuery('#addHoldModal .modal-body #add').html(data);
    };
    var editHoldCallback = function(data,params){
        jQuery('#editHoldModal .modal-body #edit').html(data);
        $('#editHoldModal').modal({show:true});
    };
    var updateHoldCallback = function(data,params){
        jQuery('#editHoldModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='holdForm'){ajax.run({url:url,params:params,callback:holdFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addHoldCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveHoldCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editHoldCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateHoldCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.StandingOrder = function(callThis,url,params){
    var standingOrderFormCallback = function(data,params){
        jQuery('#showStandingOrderFormDiv').html(data);
    };
    var addStandingOrderCallback = function(data,params){
        jQuery('#addStandingOrderModal .modal-body #add').html(data);
        datepickerInitializer();
        $('#addStandingOrderModal').modal({show:true});
     };
    var saveStandingOrderCallback = function(data,params){
        jQuery('#addStandingOrderModal .modal-body #add').html(data);
    };
    var editStandingOrderCallback = function(data,params){
        jQuery('#editStandingOrderModal .modal-body #edit').html(data);
        $('#editStandingOrderModal').modal({show:true});
    };
    var updateStandingOrderCallback = function(data,params){
        jQuery('#editStandingOrderModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='standingOrderForm'){ajax.run({url:url,params:params,callback:standingOrderFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addStandingOrderCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveStandingOrderCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editStandingOrderCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateStandingOrderCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.StopPaymentOrder = function(callThis,url,params){
    var stopPaymentOrderFormCallback = function(data,params){
        jQuery('#stopPaymentOrderFormDiv').html(data);
    };
    var addStopPaymentOrderCallback = function(data,params){
        jQuery('#addStopPaymentOrderModal .modal-body #add').html(data);
        datepickerInitializer();
        $('#addStopPaymentOrderModal').modal({show:true});
     };
    var saveStopPaymentOrderCallback = function(data,params){
        jQuery('#addStopPaymentOrderModal .modal-body #add').html(data);
    };
    var editStopPaymentOrderCallback = function(data,params){
        jQuery('#editStopPaymentOrderModal .modal-body #edit').html(data);
        $('#editStopPaymentOrderModal').modal({show:true});
    };
    var updateStopPaymentOrderCallback = function(data,params){
        jQuery('#editStopPaymentOrderModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='stopPaymentOrderForm'){ajax.run({url:url,params:params,callback:stopPaymentOrderFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addStopPaymentOrderCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveStopPaymentOrderCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editStopPaymentOrderCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateStopPaymentOrderCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.Sweep = function(callThis,url,params){
    var sweepFormCallback = function(data,params){
        jQuery('#sweepFormDiv').html(data);
    };
    var addSweepCallback = function(data,params){
        jQuery('#addSweepModal .modal-body #add').html(data);
        datepickerInitializer();
        $('#addSweepModal').modal({show:true});
     };
    var saveSweepCallback = function(data,params){
        jQuery('#addSweepModal .modal-body #add').html(data);
    };
    var editSweepCallback = function(data,params){
        jQuery('#editSweepModal .modal-body #edit').html(data);
        $('#editSweepModal').modal({show:true});
    };
    var updateSweepCallback = function(data,params){
        jQuery('#editSweepModal .modal-body #edit').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         console.log('sweepsendupdate '+callThis+' params '+params)
         console.log('sweepsendupdate '+callThis+' url '+url)
         if(callThis==='sweepForm'){ajax.run({url:url,params:params,callback:sweepFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addSweepCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveSweepCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editSweepCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateSweepCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Deposit.ManualRollover = function(callThis,url,params){
    var addRolloverCallback = function(data,params){
        jQuery('#addRolloverModal .modal-body #add').html(data);
        $('#addRolloverModal').modal({show:true});
     };
    var saveRolloverCallback = function(data,params){
        jQuery('#addRolloverModal .modal-body #add').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addRolloverCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveRolloverCallback});}
    };
     sendUpdate(callThis,url,params);
};