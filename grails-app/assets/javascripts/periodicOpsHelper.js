/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


ns("icbs.PeriodicOps");
icbs.PeriodicOps.StartOfDay= function(callThis,url,params){
    var progressCallback = function(data,params){
        console.log(data);
        var $bar = $('#startOfDayModal .bar');
        if (data.flag&&data.flag==="end") {
            // complete
            //$('#startOfDayModal').modal('hide');
            $('#processStartOfDay1').attr("disabled", false);
            $('#processStartOfDay2').attr("disabled", false);
            $('#startOfDayModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
            //$bar.width(data.progress);   
            //$('.progress').removeClass('active');
            clearInterval(icbs.PeriodicOps.StartOfDay.Interval);
            _idleTimeoutDisable = window.setInterval(CheckIdleTime, 1000);
            document.getElementById('getReportsStartOfDay').click();
            //$bar.width(0);
        }else if(data.flag&&data.flag==="error") {
            // complete
            //$('#startOfDayModal').modal('hide');
            $('#processStartOfDay1').attr("disabled", false);
            $('#processStartOfDay2').attr("disabled", false);
            $('#startOfDayModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
            //$bar.width(data.progress);   
            //$('.progress').removeClass('active');
            clearInterval(icbs.PeriodicOps.StartOfDay.Interval);
            //$bar.width(0);
        }else {
            console.log(data);
            $('#startOfDayModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
        }
        $bar.text(data.progress+ "%"); 
    };
    var processCallback = function(data,params){
        console.log(data);
        if(data.flag==='start'){
            $('#processStartOfDay1').attr("disabled", true);
            $('#processStartOfDay2').attr("disabled", true);
            $('#startOfDayModal .modal-body #message').html(data.message);
            progressBar(0);
        }
    };
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='process'){ajax.run({url:url,params:params,callback:processCallback,dataType:'json'});}
        if(callThis==='progress'){ajax.run({url:url,params:params,callback:progressCallback,dataType:'json'});}
    };
     sendUpdate(callThis,url,params);
};

icbs.PeriodicOps.EndOfDay= function(callThis,url,params){
    var progressCallback = function(data,params){
        console.log(data);
        var $bar = $('#endOfDayModal .bar');
        if (data.flag&&data.flag==="end") {
            // complete
            //$('#startOfDayModal').modal('hide');
            $('#processEndOfDay1').attr("disabled", false);
            $('#processEndOfDay2').attr("disabled", false);
            $('#endOfDayModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
            //$bar.width(data.progress);   
            //$('.progress').removeClass('active');
            clearInterval(icbs.PeriodicOps.EndOfDay.Interval);
            _idleTimeoutDisable = window.setInterval(CheckIdleTime, 1000);
            //$bar.width(0);
            document.getElementById('getReportsEndOfDay').click();
        } else if(data.flag&&data.flag==="error") {
            // complete
            //$('#startOfDayModal').modal('hide');
            $('#processEndOfDay1').attr("disabled", false);
            $('#processEndOfDay2').attr("disabled", false);
            $('#endOfDayModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
            //$bar.width(data.progress);   
            //$('.progress').removeClass('active');
            clearInterval(icbs.PeriodicOps.EndOfDay.Interval);
            //$bar.width(0);
        }else {
            $('#endOfDayModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
        }
        $('#endOfDayModal .modal-body #message').html(data.message);
        $bar.text(data.progress+ "%"); 
    };
    var processCallback = function(data,params){
        if(data.flag==='start'){
            $('#processEndOfDay1').attr("disabled", true);
            $('#processEndOfDay2').attr("disabled", true);
            $('#endOfDayModal .modal-body #message').html(data.message);
            progressBar(1);
        }
    };
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='process'){ajax.run({url:url,params:params,callback:processCallback,dataType:'json'});}
        if(callThis==='progress'){ajax.run({url:url,params:params,callback:progressCallback,dataType:'json'});}
    };
    sendUpdate(callThis,url,params);
};
icbs.PeriodicOps.EndOfMonth= function(callThis,url,params){
    var progressCallback = function(data,params){
        var $bar = $('#endOfMonthModal .bar');
        if (data.flag&&data.flag==="end") {
            // complete
            //$('#startOfDayModal').modal('hide');
            $('#processEndOfMonth1').attr("disabled", false);
            $('#processEndOfMonth2').attr("disabled", false);
            $('#endOfMonthModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
            //$bar.width(data.progress);   
            //$('.progress').removeClass('active');
            clearInterval(icbs.PeriodicOps.EndOfMonth.Interval);
            //$bar.width(0);
        }else {
            $bar.css("width", data.progress+"%");
        }
        $('#endOfMonthModal .modal-body #message').html(data.message);
        $bar.text(data.progress+ "%"); 
    };
    var processCallback = function(data,params){
        if(data.flag==='start'){
            $('#processEndOfMonth1').attr("disabled", true);
            $('#processEndOfMonth2').attr("disabled", true);
            $('#endOfMonthModal .modal-body #message').html(data.message);
            progressBar(2);
        }
    };
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='process'){ajax.run({url:url,params:params,callback:processCallback,dataType:'json'});}
        if(callThis==='progress'){ajax.run({url:url,params:params,callback:progressCallback,dataType:'json'});}
    };
    sendUpdate(callThis,url,params);
};
icbs.PeriodicOps.EndOfYear= function(callThis,url,params){
    var progressCallback = function(data,params){
        var $bar = $('#endOfYearModal .bar');
        if (data.flag&&data.flag==="end") {
            // complete
            //$('#startOfDayModal').modal('hide');
            $('#processEndOfYear1').attr("disabled", false);
            $('#processEndOfYear2').attr("disabled", false);
            $('#endOfYearModal .modal-body #message').html(data.message);
            $bar.css("width", data.progress+"%");
            //$bar.width(data.progress);   
            //$('.progress').removeClass('active');
            clearInterval(icbs.PeriodicOps.EndOfYear.Interval);
            //$bar.width(0);
        }else {
            $bar.css("width", data.progress+"%");
        }
        $('#endOfYearModal .modal-body #message').html(data.message);
        $bar.text(data.progress+ "%"); 
    };
    var processCallback = function(data,params){
        if(data.flag==='start'){
            $('#processEndOfYear1').attr("disabled", true);
            $('#processEndOfYear2').attr("disabled", true);
            $('#endOfYearModal .modal-body #message').html(data.message);
            progressBar(3);
        }
    };
    var sendUpdate = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='process'){ajax.run({url:url,params:params,callback:processCallback,dataType:'json'});}
        if(callThis==='progress'){ajax.run({url:url,params:params,callback:progressCallback,dataType:'json'});}
    };
    sendUpdate(callThis,url,params);
};
icbs.PeriodicOps.EndOfMonth.Interval = 0;
icbs.PeriodicOps.StartOfDay.Interval = 0;
icbs.PeriodicOps.EndOfDay.Interval = 0;
icbs.PeriodicOps.EndOfYear.Interval = 0;
