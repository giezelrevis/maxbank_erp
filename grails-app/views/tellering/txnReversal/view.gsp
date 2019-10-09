<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Reverse/Cancel Transaction</title>
        
        <g:javascript>
            function updateTxnAjax(params) {
                $('#txnID').val(params.txnFile2);

                $.ajax({
                    type: 'POST',
                    data: {id:params.txnFile2},
                    url: "${createLink(controller:'tellering', action:'showTxnAjax')}",
                    success: function(msg){
                                $('#txnType').html($(msg).find('#txnType').html());
                                $('#txnDate').html($(msg).find('#txnDate').html());
                                $('#acctNo').html($(msg).find('#acctNo').html());
                                $('#branch').html($(msg).find('#branch').html());
                                $('#txnCode').html($(msg).find('#txnCode').html());
                                $('#txnTemplateDesc').html($(msg).find('#txnTemplateDesc').html());
                                $('#reference').html($(msg).find('#reference').html());
                                $('#status').html($(msg).find('#status').html());
                                $('#user').html($(msg).find('#user').html());
                                $('#txnAmt').html($(msg).find('#txnAmt').html());
                                $('#sender').html($(msg).find('#sender').html());
                                $('#beneficiary').html($(msg).find('#beneficiary').html());
                                $('#particulars').html($(msg).find('#particulars').html());
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        //alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }
            function showTxnSearch() {				
                modal = new icbs.UI.Modal({id:"txnFileModal", url:"${createLink(controller: 'tellering', action:'search')}", title:"Search Transaction ID", onCloseCallback:updateTxnAjax});
                modal.show();
            }
            function callvalidateparticulars(){
                var getparticulars = $('#txnParticulars').val();
                var getreference = $('#txnReference').val();

                if(getparticulars=="" || getparticulars==null){
                
                    var messgaeError = "Field Particulars cannot be empty!";
                    notify.message('Field Particulars cannot be empty!|error|alert'); 
                    
                }else if (getreference=="" || getreference==null){
                   notify.message('Field Reference cannot be empty!|error|alert'); 
              
                }else{
                    alertify.confirm(AppTitle,"Are you sure you want to Reverse this transaction?",
                      function(){
                         checkIfAllowed('TLR02200', 'form#reverseForm', 'txnReversal', $('#txnAmt').val());
                      },
                      function(){

                      });                 
                }
                
            }
        </g:javascript>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                                
                         
                          
                        });
                </script>
               
            </g:if>
                
                
<g:form action="reverseTxn" controller="tellering" name="reverseForm">
    <div class="fieldcontain form-group">
        <label class="control-label">
            Transaction ID
        </label>
        <div class="col-md-6">
            <g:textField readonly="true" name="txnID" value="" class="form-control" />
        </div>
        <input type="button" href="#" class="btn btn-primary" onclick="showTxnSearch()" value="Search"/>
    </div>
                

                                   

            
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-6">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Transaction Details</legend>
                                    <tr>
                                        <td> Transaction Type </td>
                                        <td id="txnType">
                                            
                                        </td>
                                    </tr>   
                                    <tr>
                                        <td> Account Number </td>
                                        <td id="acctNo">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Branch </td>
                                        <td id="branch">
                                            
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td> Transaction Date </td>
                                        <td id="txnDate">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Amount </td>
                                        <td id="txnAmt">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Code </td>
                                        <td id="txnCode">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Transaction Description </td>
                                        <td id="txnTemplateDesc">
                                            
                                        </td>
                                    </tr>  
                                   
                                    <tr>
                                        <td> Reference </td>
                                        <td id="reference">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Particulars </td>
                                        <td id="particulars">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> Status </td>
                                        <td id="status">
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td> User </td>
                                        <td id="user">
                                            
                                        </td>
                                    </tr>

                            </table>
                        </div>
                    </div>
                
                    <!-- <div class="col-md-6">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">GL Transaction</legend>
                                    <tr>
                                        <td> Debit </td>
                                        <td> Credit </td>
                                    </tr>
                                    <tr>
                                        <td> N/A </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td> N/A </td>
                                    </tr>
                            </table>
                        </div>
                    </div> -->
                </div>
            </div>
                      
<div class="fieldcontain form-group ${hasErrors(bean: txnCashDepositInstance, field: 'txnRef', 'has-error')} required" >
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnCashDeposit.txnRef.label" default="Particulars" />
    </label>
    <div class="col-sm-6">
        <g:textArea class="form-control" id="txnParticulars" name="txnParticulars" value="" rows="5" cols="40"/>
    </div>             
</div>                       
<div class="fieldcontain form-group ${hasErrors(bean: txnCashDepositInstance, field: 'txnRef', 'has-error')} required" >
    <label class="control-label col-sm-4" for="txnRef">
        <g:message code="txnCashDeposit.txnRef.label" default="Transaction Reference" />
    </label>
    <div class="col-sm-6">
        <g:textField id="txnReference" name="txnReference" value="" class="form-control" />
    </div>             
</div>
                        
                    </g:form>
            
            <br><br>            
            
            <!-- <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Other Transaction Information</legend>
                            </table>
                        </div>
                    </div>
                </div>
            </div> -->
        </content>           
        <content tag="main-actions">
            <ul>
                <li><a href="#" onClick="callvalidateparticulars();">Reverse</a></li>
                
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to tellering index Page?');">Return to Tellering Index Page</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
