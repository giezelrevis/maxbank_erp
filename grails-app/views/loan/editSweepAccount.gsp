<%@ page import="icbs.loans.Loan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'loan.label', default: 'Loan')}" />
		<g:if test="${module == 'loan'}">		
                <title>Edit Loan Sweep Account </title>
                        
                </g:if>
                <g:javascript>
                    function backToLoanInquiry(){
                        var loanAccountId = $('#loanAccountIds').val() 
                        var locationUrl = "/icbs/loan/show/"+loanAccountId
                        window.location = locationUrl;
                    }
                    
                    function deleteSweepAccountAjax(swppId){
                        var loanId = $('#loanAccountId').val()
                        
                        alertify.confirm(AppTitle,"Are you sure you want to remove this ?",
                        function(){
                            //=========================
                            var obj = { 
                                loanIdValue: loanId,
                                sweepIdValue: swppId,
                            }; 

                             console.log(JSON.stringify(obj));
                             console.log("Object Loaded iwth data...");

                            $.ajax({
                                type: "POST",
                                contentType: "application/json",
                                url: "${createLink(controller:'Loan', action:'removeLoanSweepAccountAjax')}",
                                data: JSON.stringify(obj),

                                success: function(data){
                                    alertify.alert(AppTitle,"Loan Sweep Account Successfully Deleted!", function(){      
                                    var x1 = "/icbs/loan/editSweepAccount/"+loanId
                                    console.log("x1: "+x1);
                                    window.location = x1;
                                    });  
                                },
                                error: function(data){

                                    console.log(data);
                                    console.log("error updating");

                                },

                            }); 
                            //=========================
                        }, // function ending code
                        function(){
                          alertify.error('Cancel');
                        });

                    }
                </g:javascript>    
	</head>
	<body>
        <content tag="main-content"> 
            <h4 style="padding-bottom:20px;"><strong>Customer:</strong> &nbsp; ${loanApplicationInstance?.customer?.displayName} &nbsp;&nbsp;&nbsp;&nbsp;  <strong>Account Number:</strong> &nbsp; ${loanInstance?.accountNo}</h4>    
            <g:textField name="loanid" id="loanid" value="${params?.id}" style="display:none"/>
            <div id="show-loan" class="content scaffold-show" role="main">
                <g:if test="${flash.message}">
                    <div class="box-body">
                        <div class="alert alert-info alert-dismissable">
                            <i class="fa fa-info"></i>
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <b>Message</b> <div class="message" role="status">${flash.message}</div>
                        </div>
                    </div>
                </g:if>
            </div>

            <div class="section-container">
                <legend class="section-header">Loan Sweep Account Details</legend>
                <div class="table-responsive">
                    <table class="table table-hover table-condensed table-bordered table-striped">
                    <tbody>
                                <tr>
                                        <td><label>Deposit Account No.</label></td>
                                        <td><label>Account Name</label></td>
                                        <td><label>Type</label></td>
                                        <td><label>Rule</label></td>
                                        
                                        <td><label>Remarks</label></td>
                                        
                                        <td><label>Action</label></td>
                                </tr>
                        </tbody>
                        <tbody>
                                        <g:set var="i" value="${0}" />
                                        <g:each var="sweepAccounts" in="${session["sweeplist"]}">
                                                <tr>
                                                        <td>${sweepAccounts?.depositAccount?.acctNo}</td>
                                                        <td>${sweepAccounts?.depositAccount?.acctName}</td>
                                                        <td>${sweepAccounts?.type?.description}</td>
                                                        <td>${sweepAccounts?.rule?.description}</td>
                                                        
                                                        <td>${sweepAccounts?.remarks}</td>						
                                                        
                                                        <g:hiddenField name="loanSweepId" id="loanSweepId" value="${sweepAccounts?.id}" />
                                                        <g:hiddenField name="loanAccountId" id="loanAccountId" value="${params?.id}" />
                                                        <td><a href="#" class="btn btn-primary" onclick="showUpModalEditSweep('${i}');">Edit</a> 
                                                        <a href="#" class="btn btn-danger" onclick="deleteSweepAccountAjax('${sweepAccounts?.id}')">Remove</a>                                                       
                                                        <g:hiddenField name="actionPage" id="actionPage" value="${session["pageAction"]}" />
                                                        </td>
                                                        <div id="updateSweepModal${i}" onload="dddd();" class="modal fade" role="dialog">
                                                          <div class="modal-dialog">
                                                            <g:hiddenField name="loopcounterId" id="loopcounterId" value="${i}" />  
                                                            <!-- Modal content-->
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                    <h4 class="modal-title" style="color: black;">Edit Sweep Requirement Fields</h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="fieldcontain form-group">
                                                                        <label class="control-label col-sm-4" style="color: gray;">Deposit Account <span class="required-indicator">*</span></label>
                                                                        <div class="col-sm-6">
                                                                            <g:field class="form-control" id="editaccountNo${i}" name="editaccountNo" value="${sweepAccounts?.depositAccount?.acctNo}"  readonly="true" />
                                                                            <g:hiddenField id="editdepositAccount${i}" name="editdepositAccount.id" value="${sweepAccount?.depositAccount?.id}" />
                                                                            <g:hiddenField id="editloanIdvalue${i}" name="editloanIdvalue" value="${params?.id}" />
                                                                            <g:hiddenField id="editdepositAccountId${i}" name="editdepositAccountId" value="${sweepAccounts?.depositAccount?.id}" />
                                                                            <g:hiddenField id="loanRecoveryId${i}" name="loanRecoveryId" value="${sweepAccounts?.id}" />
                                                                        </div>
                                                                        <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showDepositSearch2('${i}')" value="Search"/></div>
                                                                    </div>
                                                                    <div class="fieldcontain form-group">
                                                                        <label class="control-label col-sm-4" style="color: gray;">Type: </label>
                                                                        <div class="col-sm-8"><g:select class="form-control" id="edittype${i}" name="edittype.id" from="${icbs.lov.SweepType.list().sort{it.id}}" optionKey="id" optionValue="description" value="${sweepAccounts?.type?.id}" onchange="updateSweepForm()"/></div>
                                                                    </div>
                                                                    <div class="fieldcontain form-group">
                                                                        <label class="control-label col-sm-4" style="color: gray;">Rule: </label>
                                                                        <div class="col-sm-8"><g:select class="form-control" id="editrule${i}" name="editrule.id" from="${icbs.lov.SweepRule.list().sort{it.id}}" optionKey="id" optionValue="description" value="${sweepAccount?.rule?.id}" onchange="updateSweepForm1('${i}')"/></div>
                                                                    </div>
                                                                    <div id="fund-limit-amount-form-group1${i}" class="fieldcontain form-group">
                                                                        <label class="control-label col-sm-4" style="color: gray;">Fund Limit Amount <span class="required-indicator">*</span></label>
                                                                        <div class="col-sm-8"><g:field id="editfundLimitAmt${i}" name="editfundLimitAmt" value="${sweepAccounts?.fundLimitAmt}" class="form-control truncated"/> </div>
                                                                    </div>
                                                                    <div id="fund-limit-percentage-form-group1${i}" class="fieldcontain form-group">
                                                                        <label class="control-label col-sm-4" style="color: gray;">Fund Limit Percent <span class="required-indicator">*</span></label>
                                                                        <div class="col-sm-8"><g:field id="editfundLimitPercentage${i}" name="editfundLimitPercentage" value="${sweepAccounts?.fundLimitPercentage}" required="" class="form-control"/></div>
                                                                    </div>
                                                                    <div class="fieldcontain form-group">
                                                                        <label class="control-label col-sm-4" style="color: gray;">Remarks <span class="required-indicator">*</span></label>
                                                                        <div class="col-sm-8"><g:textArea id="editremarks${i}" name="remarks" cols="40" rows="5" maxlength="255" value="${sweepAccounts?.remarks}"class="form-control"/></div>
                                                                    </div>

                                                                </div>
                                                                <br /><br /><br /><br /><br />
                                                                <div class="modal-footer">
                                                                    <a href='#' onclick="validateFields('${i}');" class="btn btn-info" value="">Update Sweep Account</a>
                                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>

                                                                </div>
                                                                <g:javascript>
                                                                    
                                                                            function showUpModalEditSweep(x){
                                                                                console.log("x: "+x);
                                                                                  document.getElementById('fund-limit-amount-form-group1'+x).style.display = 'none';
                                                                                  document.getElementById('fund-limit-percentage-form-group1'+x).style.display = 'none';
                                                                                $('#updateSweepModal'+x).modal('show');
                                                                            }
                                                                            function updateSweepForm1(x) {
                                                                            
                                                                                var rule = $('#editrule'+x).val();
                                                                                console.log("rule: "+rule);

                                                                                if (rule == 1 || rule == 2) {
                                                                                    document.getElementById('fund-limit-amount-form-group1'+x).style.display = 'none';
                                                                                    document.getElementById('fund-limit-percentage-form-group1'+x).style.display = 'none';
                                                                                } else if (rule == 3) {
                                                                                    document.getElementById('fund-limit-amount-form-group1'+x).style.display = 'block';
                                                                                    document.getElementById('fund-limit-percentage-form-group1'+x).style.display = 'none';
                                                                                } else if (rule == 4) {
                                                                                        document.getElementById('fund-limit-amount-form-group1'+x).style.display = 'none';
                                                                                        document.getElementById('fund-limit-percentage-form-group1'+x).style.display = 'block';
                                                                                }
                                                                               }
                                                                    var counterLooper=""
                                                                    function showDepositSearch2(xx){
                                                                        counterLooper = xx
                                                                        console.log("counterLooper: "+counterLooper);
                                                                        modal = new icbs.UI.Modal({id:"searchDepositModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit"])}",title:"Search Deposit Accounts",onCloseCallback:updateDepositAccount2});
                                                                        modal.show();
                                                                    }
                                                                    function validateFields(xxx){
                                                                        console.log("createValidateFields function entered....");
                                                                        //editaccountNo/edittype/editrule/editfundLimitAmt/editfundLimitPercentage/editremarks
                                                                        var saccountNo = $('#editaccountNo'+xxx).val()
                                                                        var sdepositAccount = $('#editdepositAccountId'+xxx).val()
                                                                        var stype = $('#edittype'+xxx).val()
                                                                        var srule = $('#editrule'+xxx).val()
                                                                        var sfundLimitAmt = parseFloat($('#editfundLimitAmt'+xxx).val().replace(",","")); 
                                                                        var sfundLimitPercentage = parseFloat($('#editfundLimitPercentage'+xxx).val().replace(",","")); 
                                                                        var loanrecoveryid = $('#loanRecoveryId'+xxx).val()
                                                                        var sremarks = $('#editremarks'+xxx).val()
                                                                        var isValidateAll = false;
                                                                        var loanAccountIds = $('#editloanIdvalue'+xxx).val()

                                                                        

                                                                        if(srule == 3){                
                                                                            if(sfundLimitAmt == null || sfundLimitAmt=="" || isNaN(sfundLimitAmt)){
                                                                                notify.message('Fixed Amount cannot be null if Rule is Fixed Amount!|error|alert');
                                                                                isValidateAll = false
                                                                            }else if(sfundLimitAmt < 0){
                                                                                notify.message('Fixed Amount cannot be negative|error|alert');
                                                                                isValidateAll = false
                                                                            }else{
                                                                                sfundLimitPercentage = 0
                                                                                isValidateAll = true
                                                                            }
                                                                        }
                                                                        if(srule == 4){
                                                                            if(sfundLimitPercentage == "" || sfundLimitPercentage == null || isNaN(sfundLimitPercentage)){
                                                                                 notify.message('Fund limit Percentage cannot be null if Rule is Percentage!|error|alert');
                                                                                 isValidateAll = false
                                                                            }
                                                                            else if(sfundLimitPercentage < 0){
                                                                                notify.message('Fund limit Percentage cannot be negative, minimum value must be 0|error|alert');
                                                                                isValidateAll = false
                                                                            }
                                                                            else if(sfundLimitPercentage > 100){
                                                                                notify.message('Fund limit Percentage cannot exceed the maximum value of 100 |error|alert');
                                                                                isValidateAll = false
                                                                            }else{
                                                                                sfundLimitAmt = 0
                                                                                isValidateAll = true
                                                                            } 
                                                                        }
                                                                        if(srule==1 || srule==2){
                                                                            sfundLimitAmt = 0
                                                                            sfundLimitPercentage = 0
                                                                            isValidateAll = true
                                                                        }
                                                                        if(saccountNo==null || saccountNo==""){
                                                                            notify.message('Deposit Account is Required! |error|alert');
                                                                            isValidateAll = false
                                                                        }
                                                                        if(sremarks==null || sremarks==""){
                                                                            notify.message('Remarks Field Cannot be null! |error|alert');
                                                                            isValidateAll = false
                                                                        }
                                                                        if(isValidateAll == true){
                                                                            console.log("saccountNo: "+saccountNo);
                                                                            console.log("sdepositAccount: "+sdepositAccount);
                                                                            console.log("stype: "+stype);
                                                                            console.log("srule: "+srule);
                                                                            console.log("sfundLimitAmt: "+sfundLimitAmt);
                                                                            console.log("sfundLimitPercentage: "+sfundLimitPercentage);
                                                                            console.log("sremarks: "+sremarks);     
                                                                            console.log("loanAccountIds: "+loanAccountIds);
                                                                            console.log("okay you can proceed");
                                                                            alertify.confirm(AppTitle,"Are you sure you want to Update this Record?",
                                                                            function(){
                                                                                var obj = { 

                                                                                    saccountNo: saccountNo,
                                                                                    sdepositAccount: sdepositAccount,
                                                                                    stype: stype,
                                                                                    srule: srule,
                                                                                    sfundLimitAmt: sfundLimitAmt,
                                                                                    sfundLimitPercentage: sfundLimitPercentage,
                                                                                    sremarks: sremarks,
                                                                                    loanAccountIds:loanAccountIds,
                                                                                    loanrecoveryid:loanrecoveryid
                                                                                }; 

                                                                                console.log(JSON.stringify(obj));
                                                                                console.log("Object Loaded iwth data...");
                                                                                

                                                                               $.ajax({
                                                                                   type: "POST",
                                                                                   contentType: "application/json",
                                                                                   url: "${createLink(controller:'Loan', action:'editLoanSweepAccountAjaxx')}",
                                                                                   data: JSON.stringify(obj),

                                                                                   success: function(data){
                                                                                       alertify.alert(AppTitle,"Loan Sweep Account Successfully Updated!", function(){   
                                                                                            $('#updateSweepModal'+xxx).modal('hide');
                                                                                            var x1 = "/icbs/loan/editSweepAccount/"+loanAccountIds
                                                                                            console.log("x1: "+x1);
                                                                                            window.location = x1;
                                                                                       });   


                                                                                   },
                                                                                   error: function(data){

                                                                                   },

                                                                               });
                                                                            },
                                                                            function(){
                                                                              alertify.error('Cancel');
                                                                            });
                                                                            
                                                                                                


                                                                        }                                                                     
                                                                    
                                                                    } // close curly for validateFields
                                                                    function updateDepositAccount2(params){
                                                                        if (params.deposit) {
                                                                            $.ajax({
                                                                                        type: 'POST',
                                                                                        data: {id:params.deposit},
                                                                                        url: "${createLink(controller:'loan', action:'showDepositAccountInfo')}",
                                                                                        success: function(msg){
                                                                                          console.log("deposit account number ss: "+$(msg).find('#account-no').html());  
                                                                                          var depositAccountNo = $(msg).find('#account-no').html()
                                                                                          var loanAccountId = $('#editloanIdvalue'+counterLooper).val();
                                                                                          var depositAccountId = $('#editdepositAccountId'+counterLooper).val();
                                                                                          console.log("depositAccountId: "+depositAccountId);
                                                                                          var obj = { 
                                                                                              depositAccountNo: depositAccountNo,
                                                                                              loanAccountId: loanAccountId,
                                                                                              depositAccountId: depositAccountId,
                                                                                          }; 

                                                                                           console.log(JSON.stringify(obj));
                                                                                           console.log("Object Loaded iwth data...");

                                                                                          $.ajax({
                                                                                              type: "POST",
                                                                                              contentType: "application/json",
                                                                                              url: "${createLink(controller:'Loan', action:'validateDuplicateSweepDepositAcctNoAjax')}",
                                                                                              data: JSON.stringify(obj),

                                                                                              success: function(data){
                                                                                                  var validator = ""  
                                                                                                  if(data.length>0){
                                                                                                        $.each(data, function (_key, _value) {
                                                                                                            console.log("cfgdetid: "+_value.deposit_account_id);
                                                                                                            validator = _value.deposit_account_id
                                                                                                        });
                                                                                                        if(validator == $('#editdepositAccountId'+counterLooper).val()){
                                                                                                          
                                                                                                        }else{
                                                                                                            notify.message('Sorry, There was an existing Deposit Account no |error|alert'); 
                                                                                                        }
                                                                                                  }else{
                                                                                                      $('#editaccountNo'+counterLooper).val($(msg).find('#account-no').html());
                                                                                                      $('#editdepositAccountId'+counterLooper).val(params.deposit);
                                                                                                  }
                                                                                              },
                                                                                              error: function(data){

                                                                                              },

                                                                                          });


                                                                                        },
                                                                                        error:function(XMLHttpRequest,textStatus,errorThrown){
                                                                                    alert(XMLHttpRequest+textStatus+errorThrown);
                                                                            }
                                                                                    });

                                                                    }
                                                                    }
   		
                                                                </g:javascript>    
                                                            </div>

                                                          </div>
                                                        </div>  
                                                        <!-- modal close -->                                                        
                                                </tr>
                                                <g:set var="i" value="${i = i + 1}" />
                                        </g:each>
       
                        </tbody>
                        </table>
                </div> <!-- div close class table responsive -->
            </div>  <!-- div close class section container -->          
                        

        </content>
       
        <content tag="main-actions">
            <ul>
                <g:if test="${loanInstance?.status.id<7}">
                    <li><a href='#' data-toggle="modal" data-target="#addLoanSweepAccount">Add New Sweep Account</a></li>
                </g:if>
                <li><a href='#' onClick="backToLoanInquiry();">Back to Loan Account Inquiry</a></li>
            </ul>
<!-- Modal for adding loan sweep account -->        
<div id="addLoanSweepAccount" class="modal fade" role="dialog">
<div class="modal-dialog">

  <!-- Modal content-->
  <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title" style="color: black;">Create new Sweep Account</h4>
      </div>
      <div class="modal-body">
          <div class="fieldcontain form-group">
              <label class="control-label col-sm-4" style="color: gray;">Deposit Account ${sweepAccount?.depositAccount?.id}<span class="required-indicator">*</span></label>
              <div class="col-sm-6">
                  <g:field class="form-control" id="accountNo" name="accountNo" value="${sweepAccounts?.depositAccount?.acctNo}"  readonly="true" />
                  <g:hiddenField id="depositAccount" name="depositAccount.id" value="${sweepAccount?.depositAccount?.id}" />
                  <g:hiddenField id="loanAccountIds" name="loanAccountIds" value="${params?.id}" />
              </div>
              <div class="col-sm-2"><input type="button" href="#" class="btn btn-primary" onclick="showDepositSearch()" value="Search"/></div>
          </div>
          <div class="fieldcontain form-group"> 
              <label class="control-label col-sm-4" style="color: gray;">Type: </label>
              <div class="col-sm-8"><g:select class="form-control" id="type" name="type.id" from="${icbs.lov.SweepType.list().sort{it.id}}" optionKey="id" optionValue="description" value="" onchange="updateSweepForm()"/></div>
          </div>
          <div class="fieldcontain form-group"> 
              <label class="control-label col-sm-4" style="color: gray;">Rule: </label>
              <div class="col-sm-8"><g:select class="form-control" id="addrule" name="rule.id" from="${icbs.lov.SweepRule.list().sort{it.id}}" optionKey="id" optionValue="description" value="" onchange="updateSweepForm();"/></div>
          </div>
          <div id="fund-limit-amount-form-group" class="fieldcontain form-group"> 
              <label class="control-label col-sm-4" style="color: gray;">Fund Limit Amount</span></label>
              <div class="col-sm-8"><g:field id="fundLimitAmt" name="fundLimitAmt" value="" class="form-control truncated"/> </div>
          </div>
          <div id="fund-limit-percentage-form-group" class="fieldcontain form-group">
              <label class="control-label col-sm-4" style="color: gray;">Fund Limit Percent</span></label>
              <div class="col-sm-8"><g:field id="fundLimitPercentage" name="fundLimitPercentage" value="" required="" class="form-control"/></div>
          </div> 

          <div class="fieldcontain form-group">
              <label class="control-label col-sm-4" style="color: gray;">Remarks <span class="required-indicator">*</span></label>
              <div class="col-sm-8"><g:textArea id="remarks" name="remarks" cols="40" rows="5" maxlength="255" value=""class="form-control"/></div>
          </div>

      </div>
      <br /><br /><br /><br /><br />
      <div class="modal-footer">
          <a href='#' onclick="createValidateFields();" class="btn btn-primary" value=""> Add Sweep Account </a>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>

      </div>
      <g:javascript>
        $( document ).ready(function() {
            console.log( "ready!" );
            document.getElementById('fund-limit-amount-form-group').style.display = 'none';
            document.getElementById('fund-limit-percentage-form-group').style.display = 'none';

        });  
        function updateSweepForm() {
            var rule = $('#addrule').val();
            console.log("rule: "+rule);
            
            if (rule == 1 || rule == 2) {
                document.getElementById('fund-limit-amount-form-group').style.display = 'none';
                document.getElementById('fund-limit-percentage-form-group').style.display = 'none';
            } else if (rule == 3) {
                document.getElementById('fund-limit-amount-form-group').style.display = 'block';
                document.getElementById('fund-limit-percentage-form-group').style.display = 'none';
            } else if (rule == 4) {
                    document.getElementById('fund-limit-amount-form-group').style.display = 'none';
                    document.getElementById('fund-limit-percentage-form-group').style.display = 'block';
            }
           }
          function createValidateFields(){
                console.log("createValidateFields function entered....");
                
                var saccountNo = $('#accountNo').val()
                var sdepositAccount = $('#depositAccount').val()
                var stype = $('#type').val()
                var srule = $('#addrule').val()
                var sfundLimitAmt = parseFloat($('#fundLimitAmt').val().replace(",","")); 
                var sfundLimitPercentage = parseFloat($('#fundLimitPercentage').val().replace(",","")); 
                
                var sremarks = $('#remarks').val()
                var isValidateAll = false;
                var loanAccountIds = $('#loanAccountIds').val()
                

                
                if(srule == 3){                
                    if(sfundLimitAmt == null || sfundLimitAmt=="" || isNaN(sfundLimitAmt)){
                        notify.message('Fixed Amount cannot be null if Rule is Fixed Amount!|error|alert');
                        isValidateAll = false
                    }else if(sfundLimitAmt < 0){
                        notify.message('Fixed Amount cannot be negative|error|alert');
                        isValidateAll = false
                    }else{
                        sfundLimitPercentage = 0
                        isValidateAll = true
                    }
                }
                if(srule == 4){
                    if(sfundLimitPercentage == "" || sfundLimitPercentage == null || isNaN(sfundLimitPercentage)){
                         notify.message('Fund limit Percentage cannot be null if Rule is Percentage!|error|alert');
                         isValidateAll = false
                    }
                    else if(sfundLimitPercentage < 0){
                        notify.message('Fund limit Percentage cannot be negative, minimum value must be 0|error|alert');
                        isValidateAll = false
                    }
                    else if(sfundLimitPercentage > 100){
                        notify.message('Fund limit Percentage cannot exceed the maximum value of 100 |error|alert');
                        isValidateAll = false
                    }else{
                        sfundLimitAmt = 0
                        isValidateAll = true
                    } 
                }
                if(srule==1 || srule==2){
                    sfundLimitAmt = 0
                    sfundLimitPercentage = 0
                    isValidateAll = true
                }
                if(saccountNo==null || saccountNo==""){
                    notify.message('Deposit Account is Required! |error|alert');
                    isValidateAll = false
                }
                if(sremarks==null || sremarks==""){
                    notify.message('Remarks Field Cannot be null! |error|alert');
                    isValidateAll = false
                }
                if(isValidateAll == true){
                    console.log("saccountNo: "+saccountNo);
                    console.log("sdepositAccount: "+sdepositAccount);
                    console.log("stype: "+stype);
                    console.log("srule: "+srule);
                    console.log("sfundLimitAmt: "+sfundLimitAmt);
                    console.log("sfundLimitPercentage: "+sfundLimitPercentage);
                    console.log("sremarks: "+sremarks);     
                    console.log("loanAccountIds: "+loanAccountIds);
                    console.log("okay you can proceed");
                    var obj = { 
                        
                        saccountNo: saccountNo,
                        sdepositAccount: sdepositAccount,
                        stype: stype,
                        srule: srule,
                        sfundLimitAmt: sfundLimitAmt,
                        sfundLimitPercentage: sfundLimitPercentage,
                        sremarks: sremarks,
                        loanAccountIds,loanAccountIds
                        
                    }; 

                    console.log(JSON.stringify(obj));
                    console.log("Object Loaded iwth data...");

                   $.ajax({
                       type: "POST",
                       contentType: "application/json",
                       url: "${createLink(controller:'Loan', action:'addLoanSweepAccountAjaxx')}",
                       data: JSON.stringify(obj),

                       success: function(data){
                           alertify.alert(AppTitle,"Loan Sweep Account Successfully Created!", function(){     
                                $('#addLoanSweepAccount').modal('hide');
                                var x1 = "/icbs/loan/editSweepAccount/"+loanAccountIds
                                console.log("x1: "+x1);
                                window.location = x1;
                           });      
                       },
                       error: function(data){

                       },

                   });                    
                    
                    
                } 
          }
          function showDepositSearch(){
              modal = new icbs.UI.Modal({id:"searchDepositModal",url:"${createLink(controller : 'search', action:'search', params:[searchDomain: "deposit"])}",title:"Search Deposit Accounts",onCloseCallback:updateDepositAccount});
              modal.show();
          }

          function updateDepositAccount(params){
              if (params.deposit) {
                      $.ajax({
                                  type: 'POST',
                                  data: {id:params.deposit},
                                  url: "${createLink(controller:'loan', action:'showDepositAccountInfo')}",
                                  success: function(msg){
                                    console.log("deposit account number ss: "+$(msg).find('#account-no').html());  
                                    var depositAccountNo = $(msg).find('#account-no').html()
                                    var loanAccountId = $('#loanAccountIds').val();
                                    var depositAccountId = $('#depositAccount').val();
                                    console.log("depositAccountId: "+depositAccountId);
                                    var obj = { 
                                        depositAccountNo: depositAccountNo,
                                        loanAccountId: loanAccountId,
                                        depositAccountId: depositAccountId,
                                    }; 

                                     console.log(JSON.stringify(obj));
                                     console.log("Object Loaded iwth data...");

                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json",
                                        url: "${createLink(controller:'Loan', action:'validateDuplicateSweepDepositAcctNoAjax')}",
                                        data: JSON.stringify(obj),

                                        success: function(data){
                                            if(data.length>0){
                                                notify.message('Sorry, There was an existing Deposit Account no |error|alert'); 
                                            }else{
                                                $('#accountNo').val($(msg).find('#account-no').html());
                                                $('#depositAccount').val(params.deposit);
                                            }
                                        },
                                        error: function(data){

                                        },

                                    });


                                  },
                                  error:function(XMLHttpRequest,textStatus,errorThrown){
                              alert(XMLHttpRequest+textStatus+errorThrown);
                      }
                              });

              }
          }

      </g:javascript>    
  </div>

</div>
</div>  
<!-- modal close -->
        </content>
         
	</body>
</html>
