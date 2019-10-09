new Vue({

    el: '#batch',

    data: {
       transactions : [],
       batchDetails: [],
       transaction : '',
       newCurrency: '1',
       totalCredit: 0,
       totalDebit: 0,
       newAccount: '',
       newAmount: '',
       newPrincipal: '',
       newInterest: '',
       newPenalty: '',
       newServiceCharge: '',
       breakdown: false,
       lineNo: 0,
       newLineNo: 0,
       newDebit: '',
       newCredit: '',
       newCreditAccount: '',
       newDebitAccount: '',
       url: '',
       newBatchId: new Date().getTime().toString(),
       newValueDate: '',
       newBatchName: '',
       transactionParticulars: '',
       transactionReference: '',
       branch: '',
       glAccountList: [],
       loanAccountList: [],
       depositAccountList: [],
       newLoans: '',
       newTemplate: '1',
       checkNo: '',
       glName: ''       
    },

    computed: {
        
    },

    methods: {
       
       // Add the transaction to the table and transactions array
       addTransaction: function(e) {
            
            e.preventDefault();
            console.log(e);

           // console.log(this.data.newAmount);
            
            this.newAccount = $("#glBatchAccountHidden").val();

            if (this.transaction == 9 || this.transaction == 10) {
                console.log("pasok sa txn 9");
                this.newAmount = $('#apamount').val();
            }
            console.log("New Account:" + this.newAccount);
            console.log("Txn Type:" + this.transaction);
            console.log("New Amount:" + this.newAmount);

            if ( !this.transaction || !this.newAccount || !this.newAmount  ) {
                alert("Please check the fields");
                return;
            }
            //console.log("this.newAmount: "+this.newAmount);
            this.newAmount = this.newAmount.toString();
            this.newAmount = parseFloat(this.newAmount.replace(/,/g , ""));
            //If breakdown is selected
            if(this.breakdown) {
                if (!this.newInterest) {
                    this.newInterest = 0; 
                }else{
                    if(this.newInterest == 0){
                       this.newInterest = 0;
                    }else{
                       this.newInterest = this.newInterest.toString(); 
                       this.newInterest = parseFloat(this.newInterest.replace(/,/g , ""));
                    }
                }
                if (!this.newPenalty) {
                    this.newPenalty = 0;
                }else{
                    if(this.newPenalty == 0){
                        this.newPenalty = 0;
                    }else{
                        this.newPenalty = this.newPenalty.toString(); 
                        this.newPenalty = parseFloat(this.newPenalty.replace(/,/g , ""));
                    }
                }
                if (!this.newPrincipal) {
                    this.newPrincipal = 0;
                }else{
                    if(this.newPrincipal == 0){
                        this.newPrincipal = 0;
                    }else{
                        this.newPrincipal = this.newPrincipal.toString(); 
                        this.newPrincipal = parseFloat(this.newPrincipal.replace(/,/g , ""));
                    }
                }
                if (!this.newServiceCharge) {
                    this.newServiceCharge = 0
                }else{
                    if(this.newServiceCharge == 0){
                        this.newServiceCharge = 0;
                    }else{
                        this.newServiceCharge = this.newServiceCharge.toString(); 
                        this.newServiceCharge = parseFloat(this.newServiceCharge.replace(/,/g , ""));
                    }
                }
                this.newInterest = +this.newInterest.toFixed(2);
                this.newPenalty = +this.newPenalty.toFixed(2);
                this.newPrincipal = +this.newPrincipal.toFixed(2);
                this.newServiceCharge = +this.newServiceCharge.toFixed(2);
                var sum = this.newInterest + this.newPenalty + this.newPrincipal + this.newServiceCharge;
                sum = +sum.toFixed(2);       
                //console.log("sum: "+sum+" newAmount: "+this.newAmount);
                if ( sum !== this.newAmount ) {
                    alert("Please check amount breakdown");
                    return;
                }
            }

            if (isNaN(this.newAmount)) {
                alert("Invalid amount [Character]");
                return;                
            }
            if ( parseFloat(this.newAmount) <= 0 ) {
                alert("Invalid amount [Negative]");
                return;
            }       
            
            this.lineNo++;
            
            this.newLineNo = "000" + this.lineNo;
            
            var type = this.transaction;
            var drName = '';
            var crName = '';
            //Debit
            if (type == 1 || type == 3 || type == 4 || type == 7 || type == 9) {
                
                this.totalDebit +=  this.newAmount;
                this.newDebit = this.newAmount;
                this.newDebitAccount = this.newAccount;
                this.totalDebit = +this.totalDebit.toFixed(2);
                drName = '(' + $("#glName").val() + ')';
            }

            else {
                
                this.totalCredit += this.newAmount;
                this.newCredit = this.newAmount;
                this.newCreditAccount = this.newAccount;
                this.totalCredit = +this.totalCredit.toFixed(2);
                crName = '(' + $("#glName").val() + ')';
            }


            this.transactions.push({
            
                currency: this.newCurrency,
                account: this.newAccount,
                amount: this.newAmount,
                principal: this.newPrincipal,
                interest: this.newInterest,
                penalty: this.newPenalty,
                serviceCharge: this.newServiceCharge,
                lineNo: this.newLineNo,
                credit: this.newCredit,
                debit: this.newDebit,
                creditAccount: this.newCreditAccount,
                debitAccount: this.newDebitAccount,
                transaction: this.transaction,
                batchId: this.newBatchId,
                batchName: this.newBatchName,
                transactionParticulars: this.transactionParticulars,
                transactionReference: this.transactionReference,
                checkNo: this.checkNo,
                glCreditName: this.newCreditAccount != '' ? crName : '',
                glDebitName: this.newDebitAccount != '' ? drName  : '',
                glName: $("#glName").val()


            });
            
            this.newAmount = '';
            this.newPrincipal = '';
            this.newInterest = '';
            this.newPenalty = '';
            this.newServiceCharge = '';
            this.newCreditAccount = '';
            this.newDebitAccount = '';
            this.newCredit = '';
            this.newDebit = '';
            this.breakdown = false;
            this.newAccount = '';
            this.transactionReference = '';
            this.transactionParticulars = '';
            
            $("#account").select2('val','');
            $("#transaction").select2('val','');
            $("#addNewTransactionModal").modal('hide');  
             
        }, 

        saveTransactions: function () {

        },

        saveBatchTransactions: function (e) {
            
            e.preventDefault();
           
            if(this.transactions.length <= 0 ) {
                alert("Add transactions first");
                return;
            }

            if(!this.newBatchName) {
                alert("No batch name");
                return;                
            }
            var self = this
            
            var type = this.transaction;
            

            self.batchDetails = {

                batchId: self.newBatchId,
                batchName: self.newBatchName,
                currency: self.newCurrency,
                totalDebit: self.totalDebit,
                totalCredit: self.totalCredit,
                branch: self.branch,
                loanAcct: self.newLoans,
                template: self.newTemplate,
                valueDate: $("#valueDate").val()
            
            };
            
            //Create
            if(typeof batchId == 'undefined') {
                $.ajax({
                    type: 'POST',
                    url: saveBatchTransactionsAjaxLink,
                    data: {transactions:JSON.stringify(self.transactions), batchDetails: JSON.stringify(self.batchDetails)},
                    success: function(){
                        //alert("Save Sucessful");
                        alertify.alert(AppTitle,"Save Successful!", function(){
                            self.transactions = [];
                            self.batchDetails = [];
                            window.location.replace("/icbs/glBatch");
                        });

                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                });
            }
            //Update
            else {
                $.ajax({
                    type: 'POST',
                    url: updateBatchTransactionsAjaxLink,
                    data: {batchId: batchId, transactions:JSON.stringify(self.transactions), batchDetails: JSON.stringify(self.batchDetails)},
                    success: function(){
                        alert("Update Sucessful");
                        window.location.replace("/icbs/glBatch");
                    },
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                        alert(XMLHttpRequest+textStatus+errorThrown);
                    }
                }); 

            }
            
        },

        getAccounts: function () {
            
            var type = this.transaction;
            console.log("Transaction Type No: " + type);
            // Deposit Accounts
            if (type == 1 || type == 2){
                return 1
            }
            //Loan Accounts
            else if (type == 4 || type == 5 || type == 6) {
                return 2
            }
            // GL Accounts
            // 
            else if (type == 3){
                return 4
            }
            //AP
            else if (type == 9 || type == 10) {
                return 9
            }
            else {  

                return 3
            }

        },

        editTransaction: function (transaction) {
            
            this.transaction = transaction.transaction;
            this.newAccount = transaction.account;
         
            if(transaction.principal || transaction.interest || transaction.serviceCharge || transaction.penalty)
            {
                
                this.breakdown = true;
                this.newPrincipal = transaction.principal;
                this.newInterest = transaction.interest;
                this.newPenalty = transaction.penalty;
                this.newServiceCharge = transaction.serviceCharge;


            }

            this.newAmount = transaction.amount;
        },


        clearBreakdown: function (e) {
            this.newPrincipal = '';
            this.newInterest = '';
            this.newServiceCharge = '';
            this.newPenalty = '';
        },

        removeTransaction: function (transaction) {

            //Update balances
            
            if( transaction.debit != null ) {
               this.totalDebit -= transaction.debit;
            }

            if ( transaction.credit != null ) {
                this.totalCredit -= transaction.credit;
            }
             
            this.transactions.$remove(transaction);

        
        },

        updateAccounts: function () {
           var self = this;
           
           self.glAccountList = [];
           self.loanAccountList = [];
           self.depositAccountList = [];
            
           if(self.branch == 'null') { return; }
           //Update GL Account List 
           $.ajax({
                type: 'GET',
                url: getGlAccountsAjaxLink,
                data: {branch_id: this.branch},
                
                success: function(data){
                     
                    jQuery.each(data, function(i, val) {
                        self.glAccountList.push({
                            text: val.name+" ("+val.code+")",
                            value: val.code 
                        });
                    }); 
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });

            //Update Deposit Accounts
            $.ajax({
                type: 'GET',
                url: getDepositAccountsAjaxLink,
                data: {branch_id: this.branch},
                
                success: function(data){
                     
                    jQuery.each(data, function(i, val) {
                        self.depositAccountList.push({
                            text: val.acctName+" ("+val.acctNo+")",
                            value: val.acctNo 
                        });
                    }); 
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });


             $.ajax({
                type: 'GET',
                url: getLoanAccountsAjaxLink,
                data: {branch_id: this.branch},
                
                success: function(data){
                     
                    jQuery.each(data, function(i, val) {
                        self.loanAccountList.push({
                            text: val.message.accountNo,
                            value: val.message.accountNo 
                        }); 
                    });

                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });
        },

        showAddNewTransactionModal: function () {
           $("#addNewTransactionModal").modal('show'); 
        },

        processBatch: function (batchId) {

            $.ajax({
                type: 'POST',
                url: processBatchTransactionAjaxLink,
                data: {batchId: batchId},
                success: function(data){
                  
                   var status = data.status;
                   
                   if (status == "1")
                   {
                       //alert("Batch not yet approved");
                       notify.message('Batch not yet approved|error|alert'); 
                   } else if (status == "2")
                   {
                       //alert("Batch already posted");
                       notify.message('Batch already posted|error|alert');
                   } else if (status == "3")
                   {
                       //alert("Batch already cancelled");
                       notify.message('Batch already cancelled|error|alert');
                   } else
                   {
                       //alert("Success");
                       alertify.alert(AppTitle,"Sucess!", function(){
                        location.reload();
                      });
                   }
                   
                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });

        },

        retrieveBatch: function () {
            
            var self = this;
            var drName = '';
            var crName = '';
            $.ajax({
                type: 'GET',
                url: getBatchAjaxLink,
                data: {batchId: batchId},
                success: function(data){

                    
                    jQuery.each(data, function(i, val) {
                        drName = '';
                        crName = '';
                        if (val.batchType == 1 || val.batchType == 3 || val.batchType == 4 || val.batchType == 7) {
                            drName = '(' + val.accountName + ')';
                        } else {
                            crName = '(' + val.accountName + ')';
                        }
                        self.transactions.push({
                            lineNo: val.lineNo,
                            debitAccount: val.debitAccount,
                            creditAccount: val.creditAccount,
                            debit: val.debit,
                            credit: val.credit,
                            batchId: val.batchId,
                            amount: val.amount,
                            transaction: val.batchType,
                            transactionParticulars: val.particulars,
                            transactionReference: val.reference,
                            account: val.account,
                            checkNo: val.checkNo,
                            glCreditName: val.creditAccount != '' ? crName  : '',
                            glDebitName: val.debitAccount != '' ?  drName  : '',
                            glName: val.accountName,
                            principal: val.principal,
                            interest: val.interest,
                            penalty: val.penalty
                        });

                        self.lineNo = parseInt(val.lineNo);
                    });



                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });
        },

    retrieveBatchDetails: function () {
            var self = this;
            $.ajax({
                type: 'GET',
                url: getBatchDetailsAjaxLink,
                data: {batchId: batchId},
                success: function(data){
                    self.newBatchId = data.batchDetails.batchId;
                    self.newBatchName = data.batchDetails.batchName;
                    self.totalDebit = data.batchDetails.totalDebit;
                    self.totalCredit = data.batchDetails.totalCredit;
                    self.currency = data.batchDetails.batchCurrency.id;
                    self.branch = data.batchDetails.branch.id;
                    self.newTemplate = data.batchDetails.batchType;
                    //self.newValueDate = data.batchDetails.valueDate;
                    $("#valueDate").val(new Date (data.batchDetails.valueDate).toLocaleDateString());
//                    console.log(new Date(data.batchDetails.valueDate).toLocaleDateString());
                    if(data.loanId) {
                       self.updateAccounts();
                       self.newLoans = data.batchDetails.loanId
                       $("#loans").select2('val',data.batchDetails.loanId)
                    }
                    //For select2 plugin
                    $("#branch").select2('val',data.batchDetails.branch.id);
                    $("#currency").select2('val',data.batchDetails.batchCurrency.id);
                    $("#template").select2('val',data.batchDetails.batchType);

                },
                error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });
        }
    },

    ready: function() {
        
        
        var self = this;
        var e = document.createEvent('HTMLEvents')
        e.initEvent('change', true, true)
        
        $(this.$el)
            .find('select')
            .select2({ width: 'resolve' })
            .on('change', function() {
                this.dispatchEvent(e)
            });


        if(typeof batchId != 'undefined') {
            
            

            this.retrieveBatchDetails();
            this.retrieveBatch();
            console.log("done loading values");

        }

        
      

      
        
        //Get Gl Accounts
    
    },
});