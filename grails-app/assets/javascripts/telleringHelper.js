ns("icbs.Tellering.Form");

icbs.Tellering.Form.getForm = function(callThis,url,choice){
    if (callThis == '') {
        callThis = 'txnCustomerDetails'
    }
    var getCustomerDetailsCallback = function(data,params){
        $('#' + callThis).html(data);
    };
    
    var get = function(callThis,url,params){
        //initialize count if not set.
        var count = $('#' + callThis).length;
        var ajax = icbs.Dependencies.Ajax;
        ajax.run({url:url,params:{customer:params.customer2, field: params.field},callback:getCustomerDetailsCallback});
   };
    get(callThis,url,choice);
};

icbs.Tellering.depositDetails = function(callThis,url,params){
    var getDepositDetailsCallback=function(data,params){
        //$('#transactionDetailsDiv').html(data.txnDetails);
        $('#depositDetDiv').html(data);
    }
     var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='getDepositDetailsCallback'){
            ajax.run({url:url,params:params,callback:getDepositDetailsCallback});
        }
    };
    sendUpdate(callThis,url,params);
}

icbs.Tellering.loanDetails = function(callThis,url,params){
    var getLoanDetailsCallback=function(data,params){
        //$('#transactionDetailsDiv').html(data.txnDetails);
        $('#loanDetDiv').html(data);
    }
     var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='getLoanDetailsCallback'){
            ajax.run({url:url,params:params,callback:getLoanDetailsCallback});
        }
    };
    sendUpdate(callThis,url,params);
}