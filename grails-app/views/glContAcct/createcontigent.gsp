<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.gl.GlContigentAccount" %>
<!DOCTYPE html>


<html>
    <head>

	<meta name="layout" content="main">
	
        <g:set var="entityName" value="${message(code: 'ContigentAccount.label', default: 'Contigent Account')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
                
       <script>
           function validateInputs(){
           
                var contigentTypevalue = $('#contigent').val().toString();
                var creditAmountvalue = $('#creditAmt').val().replace(/,/g , "")
                var debitAmountvalue = $('#debitAmt').val().replace(/,/g , "")
                var particularsvalue = $('#particulars').val()
                var txnDatevalue = $('#txnDate').val()   
                var referencevalue = $('#reference').val() 
                
                 document.getElementById('spancontigent').innerHTML = "";
                 document.getElementById('spancreditamt').innerHTML = "";
                 document.getElementById('spandebitamt').innerHTML = "";
                 document.getElementById('spanparticular').innerHTML = "";
                 document.getElementById('spantxndate').innerHTML = "";
                  document.getElementById('spanreference').innerHTML = "";
                
                
                var validatorMessageOnOff = "off";
               if (isNaN(contigentTypevalue)==true ) {
   
                    validatorMessageOnOff="on";
                    document.getElementById('spancontigent').innerHTML = "Field Contigent Type Cannot be empty!";
               }
              
               if(creditAmountvalue=="" && debitAmountvalue==""){
                    
                    validatorMessageOnOff="on";
                    console.log("hahaha");
                    document.getElementById('spandebitamt').innerHTML = "Fill up atleast one Field for Debit or Credit";
               }
 
               if(particularsvalue==""){
                    validatorMessageOnOff="on";
                    document.getElementById('spanparticular').innerHTML = "Field Particulars Cannot be empty!";
               }
               if(txnDatevalue==""){
                    validatorMessageOnOff="on";
                    document.getElementById('spantxndate').innerHTML = "Field Transaction Date Cannot be empty!";
               }
               if(referencevalue==""){
                    validatorMessageOnOff="on";
                    document.getElementById('spanreference').innerHTML = "Field Reference Cannot be empty!";
               }
                var convertedcredit =0;
                var converteddebit=0 ;
                
               
               if(!creditAmountvalue=="" ){
                    if(!/^[0-9].+$/.test(creditAmountvalue)){
                        validatorMessageOnOff="on";
                        document.getElementById('spancreditamt').innerHTML = "Field Credit Amount Cannot accept letters!";
                    }
                }
               if(!debitAmountvalue==""){
                     if(!/^[0-9].+$/.test(debitAmountvalue)){
                         validatorMessageOnOff="on";
                         document.getElementById('spandebitamt').innerHTML = "Field Debit Amount Cannot accept letters!";
                     }
               
               }

                convertedcredit = parseFloat(creditAmountvalue)
                converteddebit = parseFloat(debitAmountvalue)
                
               if(convertedcredit == 0){
                 document.getElementById('spancreditamt').innerHTML =""
               }
               if(converteddebit == 0){
                 document.getElementById('spandebitamt').innerHTML =""
               }
               
               if(convertedcredit<0){
                    validatorMessageOnOff="on";
                    document.getElementById('spancreditamt').innerHTML = "Field Credit Amount Cannot be less than zero!";
               }
               if(converteddebit<0){
                    validatorMessageOnOff="on";
                    document.getElementById('spandebitamt').innerHTML = "Field Debit Amount Cannot be less than zero!";
               }
               if(!txnDatevalue==""){
                    
                    var today = new Date() //get current date
                    var newtxbdate = new Date(txnDatevalue) //date conversion javascript
                    if(newtxbdate>today){
                         validatorMessageOnOff="on";
                         document.getElementById('spantxndate').innerHTML = "Field Transaction Date Cannot be greather than the current date!";             
                    }
                    
               }     
               
               
               if(validatorMessageOnOff=="on"){
                   alertify.alert(AppTitle,'sdfsdfsdf').set('message', 'There was an Error with the Fields').show(); 
               }
               
               if(validatorMessageOnOff=="off"){
                     sendValidatedFields(referencevalue,contigentTypevalue,creditAmountvalue,debitAmountvalue,particularsvalue,txnDatevalue);
               }
               
               
                
                
           }
           function sendValidatedFields(referencevalue,contigentTypevalue,creditAmountvalue,debitAmountvalue,particularsvalue,txnDatevalue){
                console.log(""+referencevalue+" "+contigentTypevalue+" "+creditAmountvalue+" "+debitAmountvalue+" "+particularsvalue+" "+txnDatevalue);
            alertify.confirm(AppTitle,'Are you sure you want to create this contigent account?',
                    function(){
                                $.ajax({
                                    type: 'POST',
                                    data: {reference:referencevalue,contigenttype:contigentTypevalue,creditamt:creditAmountvalue,debitamt:debitAmountvalue,particulars:particularsvalue,txndate:txnDatevalue},
                                    url: "${createLink(controller:'GlContAcct', action:'savecontigent')}",
                                    success: function(){                  
                                        console.log("sucessful");
                                         alertify.alert(AppTitle,'sdfsdfsdf').set('message', 'Created Successfully').show(); 
                                         showcontigentdetailsnow();
                                    },
                                    error:function(XMLHttpRequest,textStatus,errorThrown){
                                        alert(XMLHttpRequest+textStatus+errorThrown);
                                    }
                                });
                        },
                    function(){
                        return;
                    });    
           }
           function formatCreditNumber(){

                 var number1 = document.getElementsByName("creditAmt")[0].value;
                 var number
                number = number1.toString();
                number += '';
                number = number.replace(/,/g , "");
               
                x = number.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                
               
                var fieldvalue = x1 + x2;
              
                
                document.getElementsByName("creditAmt")[0].value = fieldvalue;

            }
            function formatDebitNumber(){

                 var number1 = document.getElementsByName("debitAmt")[0].value;
                 var number
                number = number1.toString();
                number += '';
                number = number.replace(/,/g , "");
               
                x = number.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                
               
                var fieldvalue = x1 + x2;
              
                
                document.getElementsByName("debitAmt")[0].value = fieldvalue;

            }
            
            function showcontigentdetailsnow(){   
                 document.getElementById("myForm").submit();    
            }
       </script>    
    </head>
    <body>
        
  		<content tag="breadcrumbs">
          <span class="fa fa-chevron-right"></span><span class="current">Create Contigent Account</span>
		</content>

        <content tag="main-content">  
<legend></legend>
<g:form id="myForm" name="myForm" controller="GlContAcct" action="viewdetails"  method="post">
    <g:hiddenField id="fromcreate"  name="fromcreate" value="showcreate"  />  
</g:form>    
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'birthDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="birthDate">
		<g:message code="customer.birthDate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:customDatePicker name="txnDate" value="${customerInstance?.txnDAte}"class="form-control"  />
                    <div class="controls">
                        <span style="color: red;" class="help-block" id="spantxndate">
                          
                        </span>
                    </div>   
        </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'customerCode1', 'has-error')} ">
            <label class="control-label col-sm-4" for="dosriCode">
                    <g:message code="customer.customerCode1.label" default="Contigent Type" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:select id="contigent" name="contigent" from="${icbs.lov.ContigentAccount.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.customerCode1?.id}" class="form-control" noSelection="['null': '']" />
                
                    <div class="controls">
                        <span style="color: red;" class="help-block" id="spancontigent">
                          
                        </span>
                    </div>
                 
            </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'sssNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="sssNo">
                    <g:message code="creditAmt.label" default="Credit Amount" />
                    <span class="required-indicator">*</span>
            </label>
             <div class="col-sm-8">
                <g:textField   name="creditAmt" id="creditAmt" onkeyup="formatCreditNumber();" maxlength="50" value="${customerInstance?.sssNo}"  class="form-control"/>
               
                    <div class="controls">
                        <span style="color: red;" class="help-block" id="spancreditamt">
                          
                        </span>
                    </div>
                   
             </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'sssNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="sssNo">
                    <g:message code="debitAmt.label" default="Debit Amount" />
                    <span class="required-indicator">*</span>
            </label>
             <div class="col-sm-8">
                <g:textField name="debitAmt" id="debitAmt" maxlength="50" onkeyup="formatDebitNumber();" value="${customerInstance?.sssNo}" class="form-control"/>
                    <div class="controls">
                        <span style="color: red;" class="help-block" id="spandebitamt">
                          
                        </span>
                    </div>  
             </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'sssNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="sssNo">
                    <g:message code="reference.label" default="Reference" />
                    <span class="required-indicator">*</span>
            </label>
             <div class="col-sm-8">
                <g:textField name="reference" id="reference" maxlength="50"  value="${customerInstance?.sssNo}"class="form-control"/>
                    <div class="controls">
                        <span style="color: red;" class="help-block" id="spanreference">
                          
                        </span>
                    </div>  
             </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'sssNo', 'has-error')} ">
            <label class="control-label col-sm-4"for="sssNo">
                    <g:message code="particulars.label" default="Particulars" />
                    <span class="required-indicator">*</span>
            </label>
             <div class="col-sm-8">
                <g:textArea name="particulars" id="particulars" value="${customerInstance}" rows="5" cols="40" class="form-control"/>
                    <div class="controls">
                        <span style="color: red;" class="help-block" id="spanparticular">
                          
                        </span>
                    </div>  
             </div>
</div>



</content>
        <!-- Action menus Right side menus -->
        <content tag="main-actions">
            <ul>
                <li><a href="#" onclick="validateInputs();">Create New Contigent Account</a></li>
                <li><g:link action="index" >Contigent Account List</g:link></li>
            </ul>
        </content>
    </body>
</html>           
            
            
