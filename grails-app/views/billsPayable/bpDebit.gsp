<%@ page import="icbs.gl.BillsPayable" %>
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<title>Bills Payable Subsidiary Ledger Debit Transactions</title>
    </head>
    <body>

        <content tag="main-content">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <tbody>
                    <tr>
                        <legend>${billsPayableInstance?.accountName} - ${billsPayableInstance?.glContra}</legend>
                    </tr>
                    <tr>
                        <td style="width:30%"><label>Branch</label></td>
                        <td>${billsPayableInstance?.branch?.name}</td> 
                    </tr>  
                    <tr>
                        <td style="width:30%"><label>Creditor Name</label></td>
                        <td>${billsPayableInstance?.creditorName}</td> 
                    </tr>  
                    <tr>
                        <td style="width:30%"><label>Date Opened</label></td>
                        <td><g:formatDate  format="MM/dd/yyyy" date="${billsPayableInstance?.dateOpened}" /></td> 
                    </tr> 
                     <tr>
                            <td><label>Balance</label></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${billsPayableInstance?.principal}"/></td>    
                        </tr> 
                                               
                </tbody>
            </table>
             <div class="panel panel-default">
                <div class = "panel-heading">
                    <h4>Transaction Details</h4>
                </div>
                    <div class="panel-body">
                        <g:form id="deposit" url="[resource:billsPayableInstance, action:'savebpDebit']" method="PUT" >
                            <fieldset class="form">
                                <div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'txnType', 'has-error')} required">
                                    <label class="control-label col-sm-4" for="txnType">Txn Template<span class="required-indicator">*</span></label>
                                    
                                    <div class="col-sm-8"><g:select id="txnType" name="txnType" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(51),icbs.lov.MemoTxnType.read(1))}"   optionKey="id" optionValue="description" required="" value="" onchange="getcode();" class="many-to-one form-control"/>
                                    </div>             
                                </div>
                                
                                <g:hiddenField name="bpDebitId" id="bpDebitId" value="${params.id}" />
                                <div class="fieldcontain form-group">
                                    <label class="control-label col-sm-4" for="intRate">Debit Amount <span class="required-indicator">*</span></label> 
                                    <div class="col-sm-8">
                                        <g:field class="form-control truncated" id="debitAmt" name="debitAmt" value="" />
                                    </div>             
                                </div>    
                                <div class="fieldcontain form-group">
                                    <label class="control-label col-sm-4" for="intRate">Reference <span class="required-indicator">*</span></label>
                                    <div class="col-sm-8">
                                        <g:field class="form-control" type="Text"  id="reference"  name="reference" value="" />
                                    </div>             
                                </div>   
                                <div class="fieldcontain form-group">
                                    <label class="control-label col-sm-4" for="intRate">Particulars <span class="required-indicator">*</span></label>     
                                    <div class="col-sm-8">
                                        <g:field class="form-control" type="Text" id="particulars"   name="particulars" value="" />
                                    </div>             
                                </div>   
                            </fieldset>
                        </g:form>  
                    </div>
            </div>
        </content>	

        <content tag="main-actions">
            <ul>
                <li><g:actionSubmit class="save" id="savebpDebit" name="savebpDebit" action="savebpDebit" value="${message(code: 'default.button.Save.label', default: 'Save')}" onclick="
                        alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                function(){
                                     checkIfAllowed('CFG00303', 'form#deposit', 'Override edit cash in bank.', null); 
                                },
                                function(){
                                    return;
                                });                      
                    "/></li>
                <li><g:link action="show" id="${billsPayableInstance.id}">Cancel</g:link></li>            
            </ul>
        </content>
    </body>
</html>
