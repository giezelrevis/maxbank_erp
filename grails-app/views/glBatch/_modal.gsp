<div class="modal" id="addNewTransactionModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Ã—</button>
                <h4 class="modal-title">Transaction Details</h4>
            </div>
            <div class="modal-body">

          <div class="graycontainer">
            <g:hiddenField name="glName" id="glName" v-model="glName"/>
            <div v-if="newTemplate == 1" class="form-group">
              <label for="transaction">Transaction Type</label>
              <g:select id="transaction" name="transaction.id" from="${icbs.gl.GlBatchTransactionType.list(sort: "description")}" optionKey="id" optionValue="description" class="many-to-one form-control" noSelection="['null': '']" v-model="transaction"/>
            </div>

            <div v-if="newTemplate != '1'" class="form-group">
              <label for="transaction">Transaction Type</label>
              <g:select id="transaction" name="transaction.id" from="${icbs.gl.GlBatchTransactionType.findAllByIdGreaterThanEquals(7)}" optionKey="id" optionValue="description" class="many-to-one form-control" noSelection="['null': '']" v-model="transaction"/>
            </div>

            <div v-if=" getAccounts() == '1' || getAccounts() == '4' " class="form-group">

              <div class="col-sm-12">
                <label for="account">Deposit Account</label>
                <br>
              </div>

              <div class="col-sm-10">
                <g:hiddenField name="glCode" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glCode" type="text" readonly="true">
              </div>

              <div class="col-sm-2">
                <input type="button" href="#"
                  class="btn btn-secondary"
                  onclick="showGlCodesSearchModal()"
                value="Search"/>
              </div>
              <div class="col-sm-12">  
                <label for="glname">Account Name</label>
                <br>
              </div>  
              <div class="col-sm-10">
                <g:hiddenField name="glname" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glname" type="text" readonly="true">
              </div>
            </div>

            <div v-if=" getAccounts() == '2' " class="form-group">

              <div class="col-sm-12">
                <label for="account">Loan Account</label>
                <br>
              </div>

              <div class="col-sm-10">
                <g:hiddenField name="glCode" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glCode" type="text" readonly="true">
              </div>

              <div class="col-sm-2">
                <input type="button" href="#"
                  class="btn btn-secondary"
                  onclick="showGlCodesSearchModal()"
                value="Search"/>
              </div>
              <div class="col-sm-12">  
                <label for="glname">Account Name</label>
                <br>
              </div>
              <div class="col-sm-10">
                <g:hiddenField name="glname" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glname" type="text" readonly="true">
              </div>              
            </div>

           <div v-if=" getAccounts() == '3' " class="form-group">

              <div class="col-sm-12">
                <label for="account">GL Account</label>
                <br>
              </div>

              <div class="col-sm-10">
                <g:hiddenField name="glCode" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glCode" type="text" readonly="true">
              </div>
              
              <div class="col-sm-2">
                <input type="button" href="#"
                  class="btn btn-secondary"
                  onclick="showGlCodesSearchModal()"
                value="Search"/>
              </div>
              
              <div class="col-sm-12">  
                <label for="glname">GL Account Name</label>
                <br>
              </div>

              <div class="col-sm-10">
                <g:hiddenField name="glname" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glname" type="text" readonly="true">
              </div>

           </div>

           <div v-if=" getAccounts() == '9' || getAccounts() == '10' " class="form-group">

              <div class="col-sm-12">
                <label for="account">GL Account</label>
                <br>
              </div>

              <div class="col-sm-10">
                <g:hiddenField name="glCode" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glCode" type="text" readonly="true">
              </div>
              
              <div class="col-sm-2">
                <input type="button" href="#"
                  class="btn btn-secondary"
                  onclick="showGlCodesSearchModal()"
                value="Search"/>
              </div>
              
              <div class="col-sm-12">  
                <label for="glname">GL Account Name</label>
                <br>
              </div>

              <div class="col-sm-10">
                <g:hiddenField name="glname" id="glBatchAccountHidden" v-model="newAccount"/>
                <input class="form-control" id="glname" type="text" readonly="true">
              </div>

              <div class="col-sm-12">  
                <label for="apamount">AP Amount</label>
                <br>
              </div>

              <div class="col-sm-10">

                <input class="form-control" id="apamount" type="text" readonly="true" v-model="newAmount" number>
              </div>

              <div class="col-sm-2">
                <input type="button" href="#" id="cAPamount" 
                  class="btn btn-secondary"
                  onclick="copyAPamount()"
                value="Copy"/>
              </div>
           </div>

            <div v-if=" getAccounts() == '4' "class="form-group">
                <label for="amount">Check No</label>
              <input type="text" id="amount" class="form-control" v-model="checkNo" number>
            </div>

            <div class="form-group">
              <label for="amount">Amount</label>
              <input type="text" id="amount" class="form-control truncated" v-model="newAmount" number>
              <div class="checkbox">
                <label>
                  <input type="checkbox" v-model="breakdown" v-on="click: clearBreakdown"> Breakdown

                </label>
              </div>
            </div>
            <div v-show="breakdown">
              <div class="form-group">
                <label class="control-label col-sm-4" for="amount">Principal</label>
                <div class="controls col-sm-9">
                  <input type="text" id="amount" class="form-control truncated" v-model="newPrincipal" number>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-4" for="interest">Interest</label>
                <div class="controls col-sm-9">
                  <input type="text" id="interest" class="form-control truncated" v-model="newInterest" number>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-4" for="penalty">Penalty</label>
                <div class="controls col-sm-9">
                  <input type="text" id="penalty" class="form-control truncated" v-model="newPenalty" number>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-4" for="serviceCharge">Service Charge</label>
                <div class="controls col-sm-9">
                  <input type="text" id="serviceCharge" class="form-control truncated" v-model="newServiceCharge" number>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="account">Reference</label>
              <input type="text" id="reference" class="form-control" v-model="transactionReference">
            </div>

            <div class="form-group">
              <label for="account">Particulars</label>
              <input type="text" id="particulars" class="form-control" v-model="transactionParticulars">
            </div>

              <g:javascript>
                  var getGlAccountsAjaxLink = "${createLink(controller:'glBatch',action:'getGLAcctByBranch')}";
                  var getDepositAccountsAjaxLink = "${createLink(controller:'glBatch',action:'getDepositAcctByBranch')}";
                  var getLoanAccountsAjaxLink = "${createLink(controller:'glBatch',action:'getLoanAcctByBranch')}";
              </g:javascript>

            </div>

            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <button class="btn btn-info"> Add Transaction </button>
            </div>
        </div>
    </div>
</div>
