
<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Create Batch Transactions</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
    </head>
    <body>
      
        <content tag="main-content">
            
            <div id="batch">
        
            <div class="row">
              <div class="col-sm-8">

                <div class="form-group">
                  <label class="control-label col-sm-4" for="batchID">Batch ID</label>
                  <div class="controls col-sm-8">
                    <input type="text" id="batchID" class="form-control">
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-sm-4" for="template">Template</label>
                  <div class="controls col-sm-8">
                    <select name="template" id="template" class="form-control">
                      <option>Select Template</option>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-sm-4" for="batchName">Batch Name</label>
                  <div class="controls col-sm-8">
                    <input type="text" id="batchName" class="form-control">
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-sm-4" for="batchCurrency">Batch Currency</label>
                  <div class="controls col-sm-8">
                    <select name="template" id="batchCurrency" class="form-control">
                      <option>Select Currency</option>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <label class="control-label col-sm-4" for="valueDate">Value Date</label>
                  <div class="controls col-sm-8">
                    <div class="input-group date">
                      <input type="text" id="valueDate" class="form-control" value="" name="valueDate">
                      <div class="input-group-addon">
                        <span class="fa fa-calendar"></span>
                      </div>
                    </div>

                  </div>
                </div>

              </div><!--end col-sm-8 -->
            </div><!-- end row -->

        <br/><br/>
            <div class="row">
              <div class="col-sm-8">
                <table class="table table-striped table-bordered">
                  <thead>
                    <tr>
                      <th>line</th>
                      <th>Debit</th>
                      <th>Credit</th>
                      <th>Debit Amount</th>
                      <th>Credit Amount</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-repeat="transaction: transactions">
                      <td>{{ transaction.transaction }}</td>
                      <td>{{ transaction.transactionType }}</td>
                      <td></td>
                      <td>{{ transaction.transactionType }}</td>
                      <td></td>
                    </tr>
                  </tbody>
                </table>

                <table border="0">
                  <tr>
                    <td width="200">Total Debit</td>
                    <td><strong>99,999,999.99</strong></td>
                  </tr>
                  <tr>
                    <td>Total Credit</td>
                    <td><strong>99,999,999.99</strong></td>
                  </tr>
                  <tr>
                    <td>Difference</td>
                    <td><strong>0</strong></td>
                  </tr>
                </table>
              </div>

              <div class="col-sm-4">
              <form v-on="submit: addTransaction">
           
                                    %{-- <div class="form-group">
                                        <input v-model="newTransaction"
                                               class="form-control"
                                               placeholder="I need to..."></input>
                                    </div>

                                    <div class="form-group">
                                        <input v-model="newTransactionType"
                                               class="form-control"
                                               placeholder="I need to..."></input>
                                    </div>

                                    <button class="btn btn-primary">
                                        Add Transaction
                                    </button> --}%
          
                <strong>Transaction Details</strong>
                <div class="graycontainer">

                  <div class="form-group">
                    <label for="transactionType">Transaction Type</label>
                    <select  id="transactionType" class="form-control">
                      <option  value="da"> Select Transaction Type</option>
                    </select>
                  </div>

                  <div class="form-group">
                    <label for="account">Account</label>
                    <select id="account" class="form-control" v-model="newTransaction">
                      <option>Select Account</option>
                      <option>12345</option>
                    </select>
                  
                                  
    {{ newTransaction }}     
                  </div>

                  <div class="form-group">
                    <label for="amount">Amount</label>
                    <input   stype="text" id="amount" class="form-control">
                    <div class="checkbox">
                      <label>
                        <input type="checkbox"> Breakdown
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="control-label col-sm-4" for="transactionType">Principal</label>
                    <div class="controls col-sm-9">
                      <input type="text" id="amount" class="form-control" v-model="newTransactionType">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="control-label col-sm-4" for="interest">Interest</label>
                    <div class="controls col-sm-9">
                      <input  type="text" id="interest" class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="control-label col-sm-4" for="penalty">Penalty</label>
                    <div class="controls col-sm-9">
                      <input type="text" id="penalty" class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="control-label col-sm-4" for="serviceCharge">Service Charge</label>
                    <div class="controls col-sm-9">
                      <input type="text" id="serviceCharge" class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="control-label col-sm-4" for="GRT">GRT</label>
                    <div class="controls col-sm-9">
                      <input type="text" id="GRT" class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="account">Reference</label>
                    <input type="text" id="reference" class="form-control">
                  </div>

                  <div class="form-group">
                    <label for="account">Particulars</label>
                    <input type="text" id="particulars" class="form-control">
                  </div>

                  <div class="form-group">
                    <button class="btn btn-primary">
                        Add Transaction
                    </button>
                  </div> 

                </div>
              </form>
              </div>

             </div>

             <div class="row">
              <div class="col-sm-12">

                <label class="control-label">Particulars</label>
                <textarea rows="3" class="col-sm-12"></textarea>

              </div>
             </div>
             <pre> {{$data | json }} </pre>

        </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><g:link class="" action="Save" resource="">Save</g:link></li>
                <li><g:link class="" action="" resource="">Exit</g:link></li>
            </ul>
        </content>
    </body> 
</html>
