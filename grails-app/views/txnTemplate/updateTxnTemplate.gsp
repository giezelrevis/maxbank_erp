<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'txnTemplate.label', default: 'TxnTemplate')}" />
		<title>Update TxnTemplate</title>
	</head>
	<body>
 
            <content tag="main-content">
		<div id="create-txnTemplate" class="content scaffold-create" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${txnTemplateInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${txnTemplateInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:txnTemplateInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="formEdit"/>
				</fieldset>
                                <g:javascript>
                                    // this global variable is use to validate na fields
                                    
                                    $( document ).ready(function() {
                                        document.getElementById('depcontraid').style.display = "none";
                                        document.getElementById('glaccountdescription').style.display = "none";
                                        makeDepContra();
                                        validateGlCode();
                                        var systemOnlyyyy = $('#systemOnlyttxn').val();
                                        
                                        if(systemOnlyyyy=="true"){
                                            document.getElementById("systemOnlyTxn").checked = true;
                                        }else{
                                            document.getElementById("systemOnlyTxn").checked = false;
                                        }
										 var typeValue = $('#txnType').val();
										 document.getElementById('requirePassbookDiv').style.display = "none";
                                             document.getElementById('atmOnlyTxnDiv').style.display = "none";
                                            if(typeValue==3 || typeValue==4 || typeValue==5){
                                               document.getElementById('requirePassbookDiv').style.display = "block";
                                               
                                            }
                                            if(typeValue==5){
                                               document.getElementById('atmOnlyTxnDiv').style.display = "block";
                                            }
                                           
                                        
                                    });
                                    var codeUniversal=""
                                    function getcode(){
                                        var typeValue = $('#txnType').val();
                                        if(typeValue=="" || typeValue==null){
                                            console.log("null");
                                        }else{

                                             document.getElementById('requirePassbookDiv').style.display = "none";
                                             document.getElementById('atmOnlyTxnDiv').style.display = "none";
                                            if(typeValue==3 || typeValue==4 || typeValue==5){
                                               document.getElementById('requirePassbookDiv').style.display = "block";
                                               
                                            }
                                            if(typeValue==5){
                                               document.getElementById('atmOnlyTxnDiv').style.display = "block";
                                            }
                                            console.log("typeValue: "+typeValue);
                                            var obj = { 
                                                typevalue: typeValue,
                                            }; 
                                            console.log(JSON.stringify(obj));
                                            console.log("Object Loaded iwth data...");
                                            $.ajax({
                                                type: "POST",
                                                contentType: "application/json",
                                                url: "${createLink(controller:'TxnTemplate', action:'getTxnTypeCodeAjax')}",
                                                data: JSON.stringify(obj),

                                                success: function(data){
                                                
                                                    $.each(data, function (_key, _value) {
                                                        console.log(JSON.stringify(data));
                                                        $('#code').val(_value.code);
                                                        codeUniversal = _value.code;
                                                        
                                                    });
                                                },
                                                error: function(data){

                                                },

                                            });                                    
                                        }
                 
                                     
                                    }
									var isCodeExist = 0;
                                    function validateExistingCodeAjax(){
                                       var codevalue = $('#code').val();
                                       var txntypevalue = $('#txnType').val();
                                       console.log('codevalue: '+codevalue);
                                       console.log('txntypevalue: '+txntypevalue);
                                      
                                       if(codeUniversal==codevalue){
                                         notify.message('Please Insert unique additional three digit in field Code beside '+codeUniversal+' |error|alert'); 
                                       }else{
                                          var validatorcodess = $('#codevalidator').val();  
                                          if(validatorcodess==codevalue){
                                            
                                          }else{
                                          //=================== AJAX FUNCTION to validate code if existing
                                                var obj = { 
                                                    codevalue: codevalue,
                                                    txntypevalue: txntypevalue,
                                                }; 
                                                console.log(JSON.stringify(obj));
                                                console.log("Object Loaded iwth data...");
                                                $.ajax({
                                                    type: "POST",
                                                    contentType: "application/json",
                                                    url: "${createLink(controller:'TxnTemplate', action:'validateExistingCodeAjax')}",
                                                    data: JSON.stringify(obj),

                                                success: function(data){
                                                    if(data.length >=1){
                                                        isCodeExist = 1;
                                                        notify.message('Code Already Exists!|error|alert'); 
                                                    }else{
                                                        isCodeExist = 0;
                                                    }
                                                   
                                                    
                                                },
                                                error: function(data){

                                                },


													  
																		  

													  

                                            });     
                                            }
                                       }
                                    }
                                    function makeDepContra(){
                                    
                                        var memoTxnType = $('#memoTxnType').val();
                                        var otherCashTxn = $('#txnType').val();
                                            if(memoTxnType!=10){
                                                document.getElementById('depcontraid').style.display = "block";
                                            }else{
                                                if (otherCashTxn==19 || otherCashTxn==20 || otherCashTxn==21) {
                                                    document.getElementById('depcontraid').style.display = "block";
                                                } else {
                                                    document.getElementById('depcontraid').style.display = "none";
                                                }    
                                            } 
                                    }
                                    var onoff=""
                                    function validateGlCode(){
                                        var depcontra = $('#depContra').val();
                                        var financialYear = $('#financialYear').val();
                                        console.log("financialYear: "+financialYear);
                                        if(depcontra==""){
                                        
                                        }else{
                                          //=================== AJAX FUNCTION to validate code if existing
                                            var obj = { 
                                                depcontra: depcontra,
                                                financialYear: financialYear,
                                            }; 
                                            console.log(JSON.stringify(obj));
                                            console.log("Object Loaded iwth data...");
                                            $.ajax({
                                                type: "POST",
                                                contentType: "application/json",
                                                url: "${createLink(controller:'TxnTemplate', action:'validateExistingGlCodeAjax')}",
                                                data: JSON.stringify(obj),

                                                success: function(data){
                                                    if(data.length >=1){
                                                        onoff = ""
                                                        document.getElementById('glaccountdescription').style.display = "block";
                                                        $.each(data, function (_key, _value) {
                                                            console.log(JSON.stringify(obj))
                                                            console.log(_value.gl_code);
                                                            console.log(_value.name);
                                                            $('#gldescription').val(_value.name);
                                                            
                                                        });
                                                        
                                                    }else{
                                                        onoff = "invalidGlCode";
                                                        document.getElementById('glaccountdescription').style.display = "none";
                                                        notify.message('Sorry, Invalid Gl Code!|error|alert');
                                                        
                                                    }
                                                    console.log("onoff: "+onoff);
                                                   
                                                    
                                                },
                                                error: function(data){

                                                },

                                            });                                            
                                        }
                                        
                                    }
                                    // function that submits information to controller
                                    function validateFields(){

                                        var txntype = $('#txnType').val();
                                        var code = $('#code').val();
                                        var description = $('#description').val();
                                        var shortDescription = $('#shortDescription').val();
                                        var amlaCode = $('#amlaCode').val();
                                        var memoTxnType = $('#memoTxnType').val();
                                        // dep contra optional========= 
                                        var depContra = $('#depContra').val();
                                        //=============================
                                        var minAmt = $('#minAmt').val();
                                        var maxAmt = $('#maxAmt').val();
                                        var requireTxnReference = document.getElementById('requireTxnReference').checked;
                                        var requireTxnDescription = document.getElementById('requireTxnDescription').checked;
                                        var validationCopyNo = $('#validationCopyNo').val();
                                        var validationFormCode = $('#validationFormCode').val();
                                        var currency = $('#currency').val();
                                        var requirePassbook = $('#requirePassbook').val();
                                        var txnModule = $('#txnModule').val();
                                        var atmOnlyTxn = $('#atmOnlyTxn').val();
                                        var interbranchTxn = $('#interbranchTxn').val();
                                        var systemOnlyTxn = document.getElementById('systemOnlyTxn').checked;
                                        var batchTxn = $('#batchTxn').val();
                                        var appType = $('#appType').val();
                                        var configitem = $('#configItemStatus').val();
                                        var idtxntemplate = $('#idtxntemplate').val();
                                        console.log("txntype: "+txntype);
                                        console.log("code: "+code);
                                        console.log("description: "+description);
                                        console.log("shortDescription: "+shortDescription);
                                        console.log("amlaCode: "+amlaCode);
                                        console.log("memoTxnType: "+memoTxnType);
                                        console.log("depContra: "+depContra);
                                        console.log("minAmt: "+minAmt);
                                        console.log("maxAmt: "+maxAmt);
                                        console.log("requireTxnReference: "+requireTxnReference);
                                        console.log("requireTxnDescription: "+requireTxnDescription);
                                        console.log("validationCopyNo: "+validationCopyNo);
                                        console.log("validationFormCode: "+validationFormCode);
                                        console.log("currency: "+currency);
                                        console.log("requirePassbook: "+requirePassbook);
                                        console.log("txnModule: "+txnModule);
                                        console.log("atmOnlyTxn: "+atmOnlyTxn);
                                        console.log("interbranchTxn: "+interbranchTxn);
                                        console.log("systemOnlyTxn: "+systemOnlyTxn);
                                        console.log("batchTxn: "+batchTxn); 
                                        console.log("appType: "+appType);
                                        
                                        if(txntype==3 || txntype==4 || txntype==5){
                                            if(requirePassbook==""){
                                                requirePassbook=2
                                            }
                                            if(atmOnlyTxn==""){
                                                atmOnlyTxn=2
                                            }
                                        }
                                        else{
                                            requirePassbook=2
                                            atmOnlyTxn=2
                                        }
                                        console.log("new pss: "+requirePassbook+" atmonly: "+atmOnlyTxn);
                                        if(txntype=="" || code=="" || description=="" || shortDescription=="" || memoTxnType=="" || currency=="" || requirePassbook=="" || txnModule=="" || atmOnlyTxn=="" || interbranchTxn=="" || batchTxn=="" || appType==""){
                                        
                                            notify.message('Sorry, Cannot Proceed With Empty Required (*) Fields! |error|alert'); 
                                        
                                        }else if(memoTxnType != 10 && depContra==""){
                                            
                                            notify.message('Sorry, Cannot Proceed With Empty Fields! |error|alert');
                                        }
                                        else{
                                            var stopper=""
                                            if(codeUniversal==code){
                                                stopper="stop"
                                                notify.message('Please Insert unique additional three digit in field Code beside '+codeUniversal+' |error|alert'); 
                                                
                                            }
                                            else if(isCodeExist == 1){
                                                notify.message('Code Already Exists!|error|alert'); 
                                            }
                                            else if(onoff=="invalidGlCode" && stopper==""){
                                                console.log("pasok sa bangs");
                                                notify.message('Sorry, Invalid Gl Code!|error|alert');
                                            }
                                            else{
                                                if(stopper=="stop"){
                                                
                                                }else{
                                                
                                                alertify.confirm(AppTitle,'Are you sure you want to create this transaction template?',    
                                                function(){
                                                    var obj = { 
                                                        idtxntemplate:idtxntemplate,
                                                        txntype: txntype,
                                                        code: code,
                                                        description: description,
                                                        shortDescription: shortDescription,
                                                        amlaCode: amlaCode,
                                                        memoTxnType: memoTxnType,
                                                        depContra: depContra,
                                                        //minAmt: minAmt,
                                                        //maxAmt: maxAmt,
                                                        //requireTxnReference: requireTxnReference,
                                                        //requireTxnDescription: requireTxnDescription,
                                                        //validationCopyNo: validationCopyNo,
                                                        //validationFormCode: validationFormCode, 
                                                        currency: currency,
                                                        requirePassbook: requirePassbook,
                                                        txnModule: txnModule,
                                                        atmOnlyTxn: atmOnlyTxn,
                                                        interbranchTxn: interbranchTxn,
                                                        systemOnlyTxn: systemOnlyTxn,
                                                        batchTxn: batchTxn,   
                                                        appType: appType,
                                                        configitem: configitem,
                                                    }; 
                                                    console.log(JSON.stringify(obj));
                                                    console.log("Object Loaded iwth data...");
                                                    $.ajax({
                                                        type: "POST",
                                                        contentType: "application/json",
                                                        url: "${createLink(controller:'TxnTemplate', action:'updateTxnTemplateAjax')}",
                                                        data: JSON.stringify(obj),

                                                        success: function(data){
                                                        var txnTemplateId=""
                                                        $.each(data, function (_key, _value) {
                                                            txnTemplateId=_value.id
                                                        });
                                                        alertify.alert(AppTitle,"Txn Template Successfully Updated!",
                                                            function(){
                                                                window.location.href="/icbs/txnTemplate/show/"+txnTemplateId;
                                                            });               
                                                        },
                                                        error: function(data){

                                                        },

                                                    });
                                                },
                                                function(){
                                                   return;
                                                });
                                                
                                            }
                                            
                                        }
                                     
                                        }//else
                                    }
                                    //====== this function activates undeletable prefix :) jm codes here
                                    $('#code').keydown(function(e) {
                                        var oldvalue=$(this).val();
                                        var field=this;
                                        setTimeout(function () {
                                            if(field.value.indexOf(codeUniversal) !== 0) {
                                                $(field).val(oldvalue);
                                            } 
                                        }, 1);
                                    });
                                </g:javascript>   
			</g:form>
		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><a href="#" onClick='validateFields();' >Update </a></li>
                    <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                </ul>
            </content>
	</body>
</html>
