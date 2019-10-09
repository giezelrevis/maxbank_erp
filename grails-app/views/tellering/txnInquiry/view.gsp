<%@ page contentType="text/html;charset=UTF-8" import="icbs.deposit.Deposit" %>


<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Transaction Inquiry</title>
        
        <g:javascript>
            function updateTxnAjax(params) {
                $('#txnID').val(params.txnFile2);
                

                $.ajax({
                    type: 'POST',
                    data: {id:params.txnFile2},
                    url: "${createLink(controller:'tellering', action:'showTxnAjax')}",
                    success: function(msg){
                                console.log(msg);
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
                                $('#senderBirthDate').html($(msg).find('#senderBirthDate').html());
                                $('#senderAddress').html($(msg).find('#senderAddress').html());
                                $('#senderPhoto').html($(msg).find('#senderPhoto').html());
                                $('#beneficiary').html($(msg).find('#beneficiary').html());
                                $('#beneficiaryBirthDate').html($(msg).find('#beneficiaryBirthDate').html());
                                $('#beneficiaryAddress').html($(msg).find('#beneficiaryAddress').html());
                                $('#beneficiaryPhoto').html($(msg).find('#beneficiaryPhoto').html());
                                $('#reference').html($(msg).find('#reference').html());
                                $('#particulars').html($(msg).find('#particulars').html());
                                $('#indic').html($(msg).find('#indic').html());
                                $('#create_report_id').val(params.txnFile2);
                                $('#status').html($(msg).find('#status').html());
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
        </g:javascript>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            
            <div class="row">
                <div class="form-horizontal">
                    <g:form action="show">
                        <div class="fieldcontain form-group">
                            <label class="control-label col-sm-4">
                                Transaction ID
                            </label>
                            <div class="col-sm-5">
                                <g:textField name="txnID" value="" class="form-control" />
                            </div>
                            <input type="button" href="#" class="btn btn-primary" onclick="showTxnSearch()" value="Search"/>
                        </div>
                    </g:form>
                </div>
            </div>
            
            <br> <br>
          
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-8">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Transaction Details</legend>
                                    <tr>
                                        <td> Transaction Type </td>
                                        <td id="txnType">
                                            
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
                            <div class="section-container">
                                <fieldset>
                                    <legend class="section-header">Sender Details</legend>
                                    <div class="col-xs-8 col-sm-8 col-md-8">
                                        <div class="infowrap">
                                            <dl class="dl-horizontal">
                                                   <dt>Name</dt>
                                                   <dd id="sender"></dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Date Of Birth</dt>
                                                   <dd id="senderBirthDate"></dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Address</dt>
                                                   <dd id="senderAddress"></dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="infowrap">
                                        <dl class="dl-horizontal">
                                           <dd id="senderPhoto"></dd>
                                        </dl>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="section-container">
                                <fieldset>
                                    <legend class="section-header">Beneficiary Details</legend>
                                    <div class="col-xs-8 col-sm-8 col-md-8">
                                        <div class="infowrap">
                                            <dl class="dl-horizontal">
                                                   <dt>Name</dt>
                                                   <dd id="beneficiary"></dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Date Of Birth</dt>
                                                   <dd id="beneficiaryBirthDate"></dd>
                                            </dl>
                                            <dl class="dl-horizontal">
                                                   <dt>Address</dt>
                                                   <dd id="beneficiaryAddress"></dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <div class="infowrap">
                                        <dl class="dl-horizontal">
                                           <dd id="beneficiaryPhoto"></dd>
                                        </dl>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </div>
                    <!--               
                    <div class="col-md-4">
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
                    </div>
                    -->
                </div>
            </div>
            <!--
            <div class="row">
                <div class="form-horizontal">
                    <div class="col-md-12">
                        <div class="infowrap">
                            <table class="table table-bordered table-striped">
                                <legend class="section-header">Other Transaction Information</legend>
                                <tr>
                                    <td id="indic">
                                        
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            -->
            <!--
            <g:form action="createReport">
                <g:hiddenField name="_format" value="PDF"/>
                <g:hiddenField name="_name" value="Teller Transaction Report"/>
                <g:hiddenField name="_file" value="txn_inquiry"/>
                <g:hiddenField name="tid" value="" id="create_report_id"/>
                <import value="icbs.cif.Customer"/>
                <import value="icbs.admin.TxnTemplate"/>
                <input type="submit" class="btn btn-primary" value="Generate Report">
            </g:form>
            -->
        </content>
        
        <content tag="main-actions">
            <ul>
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to tellering index Page?');">Return to Tellering Index Page</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
