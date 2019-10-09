/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*Javascript helper for one to many forms*/
    var target;
    var relatedTarget;
    var ajax = false;
    var willShow = false;
    var bypass = false;
$(document).ready(function () {
    /* Find Div With Errors and HighLight*/
    icbs.Customer.Form.Validation.focusError();
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
        console.log("umabot sa show");
        /*If no errors then on to the next tab*/
        //alert("on show and willShow"+willShow+"ajax:"+ajax);
        if(willShow===true){
            willShow = false;
            return true;
        } 
        target = e.target;
        targetHref = $(e.target).attr("href"); // activated tab
        relatedTarget = e.relatedTarget;
        relatedTargetHref =  $(e.relatedTarget).attr("href"); // activated tab
        if (target===relatedTarget){alert("pumasok sa same target");return false;}
        if(ajax===false){
             //alert("run Ajax again!");
            if(!bypass){
                if(relatedTargetHref==="#tab_1"){  
                    ajax = true;
                    customerVerificationValidation();
                }
            }else{
                console.log("umabot dito");
                bypass=false;
                callback(true);
            }
   
            if(relatedTargetHref==="#tab_2"){
                ajax = true;
                customerOtherDetailsValidation();
            }
            if(relatedTargetHref==="#tab_3"){  
                ajax = true;
                customerContactDetailsValidation();
            }
            if(relatedTargetHref==="#tab_4"){  
                ajax = true;
                customerAddressValidation();
            }
            if(relatedTargetHref==="#tab_5"){  
                ajax = true;
                customerBusinessAndEmploymentValidation();
            }
            if(relatedTargetHref==="#tab_6"){  
                ajax = true;
                customerFamilyValidation();
                            //callback(true);
            }
            if(relatedTargetHref==="#tab_7"){  
                ajax = true;
                customerEducationValidation();
            }
            if(relatedTargetHref==="#tab_8"){  
                callback(true);
            }
            if(relatedTargetHref==="#tab_9"){
                ajax = true;
                customerPresentedIdAndOtherAcctValidation();
            }
            if(ajax===true){
                willShow = false;
            }             
        }
        return willShow;
                    //return true;
    });
   
});
ns("icbs.Customer");
ns("icbs.Customer.Form");
ns("icbs.Customer.Form.Validation");
icbs.Customer.Form.Validation.focusError=function(tabNo){
    var hasError =false;
    var focusError=null;
    var focusTarget = null;
    if(tabNo!=null){
        $('div,input', $('#tab_'+tabNo+'')).each(function () {
            if($(this).hasClass( 'has-error' ))
            {
                                //alert("may errors dito");
                hasError = true;
                $('#tabLi'+tabNo+'').addClass("red");
                if(focusTarget===null){
                    focusTarget =$(this);
                }
            }
        });
        if (hasError === false){
            $('#tabLi'+tabNo+'').removeClass("red");
        }else{
            focusTarget.focus();
        }
        return hasError;
    }else{
        /*Loop Through the Tabs*/
        for (i = 1; i < 10; i++) { 
            hasError = false;
            $('div,input', $('#tab_'+i+'')).each(function () {
                //alert(this.value); // "this" is the current element in the loop
                if($(this).hasClass( 'has-error' ))
                {
                //alert("may errors dito");
                    hasError = true;
                    $('#tabLi'+i+'').addClass("red");
                    if(focusError===null){
                        focusError = '#tabLi'+i+'';
                    }
                                    
                }
            });
            if (hasError === false){
                $('#tab_'+i+'').removeClass("red");
            }
        }
        if(focusError!==null){
            $(focusError).tab('show');
        }
            return;
    } 
};
 function callback(success){
    if(success){
        //alert("success callback!");
        willShow = true;
        ajax = false;
        $('#errorList').empty();
        $(target).tab('show');
    }else{
        //alert("error callback!");
        willShow = false;
        ajax = false;
    }
}
//AJAX VALIDATION FOR EACH TAB CUSTOMER
icbs.Customer.Form.Validation.validateForm = function(url,data,choice,onsubmit){
    var url = url;
    var data = data;
    var choice = choice;
    var onsubmit = onsubmit||false;
    var validateCallback = function(data,params){
        console.log(params);
        console.log(data);
        if(params.choice&&params.choice!==1){
           $('#tab_'+params.choice).html(data);
           var withError = icbs.Customer.Form.Validation.focusError(params.choice);
           callback(!withError);
           datepickerInitializer();
        }else if(params.choice){
            if(params.choice===1&&!params.onsubmit){
                $('#tab_1').html(data.html);
                var withError = icbs.Customer.Form.Validation.focusError(params.choice);
                if(data.possibleDuplicate===true){
                    $('#customerDuplicateModal').modal('show');
                }else{
                    callback(!withError);
                }
                datepickerInitializer();
            }
            //onsubmit test
             if(params.choice===1&&params.onsubmit){
                $('#tab_1').html(data.html);
                if(data.possibleDuplicate===true){
                    bypass = true;
                    $('#tabLi1').tab('show');
                    $('#customerDuplicateModal').modal('show');
                }else{
                    $('#saveCustomerForm').submit();
                }
            }
        }else{
            alert("Something is wrong, contact kr for information");
        }
    };
    this.validate = function(){
        if(choice===1){
            icbs.Dependencies.Ajax.run({url:url,params:data,callback:validateCallback,callbackParams:{choice:choice,onsubmit:onsubmit},dataType:'json'});
        }else{
            icbs.Dependencies.Ajax.run({url:url,params:data,callback:validateCallback,callbackParams:{choice:choice}});
        }
    }; 
    this.validate();
};
icbs.Customer.Form.Events = function(){
    
};
icbs.Customer.Form.getForm = function(callThis,url,choice){
    var changeVerificationFormCallback = function(data,params){
        jQuery('#tab_1').html(data);
    };
    var contactCallback = function(data,params){
        if(params.choice===0){
            jQuery('#phoneList').append(data);
        }
        if(params.choice===1){
            jQuery('#emailList').append(data);
        }
        if(params.choice===2){
            jQuery('#socialMediaList').append(data);
        }
        icbs.Customer.Form.getForm.contactCount++;
    };
    var addressCallback = function(data,params){
        jQuery('#addressList').append(data);
    };
    var attachmentCallback = function(data,params){
        if(params.choice===0){
            //expansion
        }
        if(params.choice===1){
            //expansion
        }
        if(params.choice===2){
            jQuery('#otherList').append(data);
        }    
        icbs.Customer.Form.getForm.attachmentCount++;
    };
    var otheracctCallback = function(data,params){
        jQuery('#otherAcctList').append(data);
        icbs.Customer.Form.getForm.otherAcctCount++;
    };
    var presentedidCallback = function(data,params){
        jQuery('#presentedIdList').append(data);
        datepickerInitializer();
        icbs.Customer.Form.getForm.presentedIdCount++;
    };
    var relationCallback = function(data,params){
        if(data.i){
            jQuery('#relation'+data.i).html(data.html);
        }else{
            if(params.choice===0){
                jQuery("#spouseList").append(data.html);
            }
            if(params.choice===1){
                jQuery("#fatherList").append(data.html);
            }
            if(params.choice===2){
                jQuery("#motherList").append(data.html);
            }
            if(params.choice===3){
                jQuery("#otherRelationList").append(data.html);
            }
            if(params.choice===4){
                jQuery("#businessRelationList").append(data.html);
            }
            icbs.Customer.Form.getForm.relationCount++;
        }
         datepickerInitializer();
    };
    var educationCallback = function(data,params){
        if(params.choice===0){
            jQuery("#primaryList").append(data);
        }
        if(params.choice===1){
            jQuery('#secondaryList').append(data);
        }
        if(params.choice===2){
            jQuery('#collegeList').append(data);
        }
        if(params.choice===3){
            jQuery('#vocationalList').append(data);
        }
        if(params.choice===4){
            jQuery('#postGradList').append(data);
        }
        icbs.Customer.Form.getForm.educationCount++;
    };
    var relationTestHelper = function(choice){
        var spouseLimit = 1;//change this as needed
        var fatherLimit = 1;//change this as needed
        var motherLimit = 1;//change this as needed
        var count;
        if(choice===0){
            count = $('.relation-spouse').length;
            if(count>=spouseLimit){
                alert("maximum allowed, cannot add more");
                return false;
            }
            if(count===spouseLimit-1||count===spouseLimit){
                document.getElementById("spouseAddButton").disabled = true; 
                //disableButton
            }
            return true;
        }
        if(choice===1){
            count = $('.relation-father').length;
            if(count>=fatherLimit){
                alert("maximum allowed, cannot add more");
                return false;
            }
            if(count===fatherLimit-1||count===fatherLimit){
                document.getElementById("fatherAddButton").disabled = true; 
                //disableButton
            }
            return true;
        }
        if(choice===2){
            count = $('.relation-mother').length;
            if(count>=motherLimit){
                alert("maximum allowed, cannot add more");
                return false;
            }
            if(count===motherLimit-1||count===motherLimit){
                document.getElementById("motherAddButton").disabled = true; 
                //disableButton
            }
            return true;
        }
        return true;
    };
    var get = function(callThis,url,choice){
        //initialize count if not set.
        var count;
        var l_count = $('.'+callThis+'-div').length;
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='changeVerificationForm'){ajax.run({url:url,params:choice,callback:changeVerificationFormCallback});}
        if(callThis==='contact'){
            count = icbs.Customer.Form.getForm.contactCount;
            if(l_count>count){
                count = l_count;
            }
            ajax.run({url:url,params:{i:count,choice:choice},callback:contactCallback,callbackParams:{choice:choice}});
        }
        if(callThis==='address'){
            count = icbs.Customer.Form.getForm.addressCount;
             if(l_count>count){
                count = l_count;
            }
            ajax.run({url:url,params:{i:count,choice:choice},callback:addressCallback});
        }
        if(callThis==='attachment'){
            count = icbs.Customer.Form.getForm.attachmentCount;
             if(l_count>count){
                count = l_count;
            }
            ajax.run({url:url,params:{i:count,choice:choice},callback:attachmentCallback,callbackParams:{choice:choice}});
        } 
        if(callThis==='otherAcct'){
            count = icbs.Customer.Form.getForm.otherAcctCount;
             if(l_count>count){
                count = l_count;
            }
            ajax.run({url:url,params:{i:count},callback:otheracctCallback});
        } 
        if(callThis==='presentedId'){
            count = icbs.Customer.Form.getForm.presentedIdCount;
             if(l_count>count){
                count = l_count;
            }
            ajax.run({url:url,params:{i:count},callback:presentedidCallback});
        } 
        if(callThis==='knownRelation'){
            if(choice&&choice.i!=null&&choice.customer2!=null){
                ajax.run({url:url,params:{i:choice.i,customer2:choice.customer2,choice:choice.choice},callback:relationCallback,dataType:'json'});
            }
        }
        if(callThis==='relation'){
            count = icbs.Customer.Form.getForm.relationCount;
             if(l_count>count){
                count = l_count;
            }
            if(relationTestHelper(choice.choice)){ajax.run({url:url,params:{i:count,choice:choice.choice},callback:relationCallback,callbackParams:{choice:choice.choice},dataType:'json'});}
        }
        if(callThis==='education'){
            count = icbs.Customer.Form.getForm.educationCount;
             if(l_count>count){
                count = l_count;
            }
            ajax.run({url:url,params:{i:count,choice:choice},callback:educationCallback,callbackParams:{choice:choice}});
        } 
    };
    get(callThis,url,choice);
};
icbs.Customer.Form.getForm.contactCount = 0;
icbs.Customer.Form.getForm.attachmentCount = 0;
icbs.Customer.Form.getForm.addressCount = 0;
icbs.Customer.Form.getForm.relationCount = 0; 
icbs.Customer.Form.getForm.otherAcctCount = 0;
icbs.Customer.Form.getForm.presentedIdCount = 0;
icbs.Customer.Form.getForm.educationCount = 0;

ns("icbs.Customer.Form.Utilities");
icbs.Customer.Form.Utilities= {
    /*Converts checkbox to radio type*/
    radioCheckBox:function(e, choice){
        e = e || event;
        var cb = e.srcElement || e.target;
        //if (cb.type !== 'checkbox') {return true;}
        var cbxs; 
        var alwaysHasPrimary= true;
        if (choice === 1){
            cbxs = document.getElementsByClassName('phone-radio');
        }
        if (choice === 2){
            cbxs = document.getElementsByClassName('email-radio');
            alwaysHasPrimary = false;
        }
        if (choice === 3){
            cbxs = document.getElementsByClassName('address-radio');
        }
        i=cbxs.length;
        while(i--) {
            if (cbxs[i].type && cbxs[i].type === 'checkbox' && cbxs[i].id !== cb.id) {
                cbxs[i].checked = false;
             }
        }
        if(alwaysHasPrimary){
            cb.checked = true;
        }
    },
    appendToDisplayName:function(choice){
        choice = choice||1;
        var initial="";
        if(choice===2){
            $('#displayName').attr('value', $('#name1').val());
        }else{
            if($('#name4').val()!==""){
                 initial = "(" +$('#name4').val()+")";
            }
            $('#displayName').attr('value',  $('#name1').val()+" "+ 
            $('#name2').val()+" "+
            $('#name3').val()+" "+ initial);
        }
        $("h1 .customerName" ).empty();
        $("h1 .customerName").append($('#displayName').val());                          
    },
    
    /*Bind Delete button to one to many forms*/
     bindDelete:function(caller,parentClass)
    {
        var temp = confirm('Are you sure you want to delete this item?');
        if(!temp)return false;
        var prnt = $(caller).parents(parentClass);
        var delInput = prnt.find("input[id$=deleted]");
        var newValue = prnt.find("input[id$=new]").attr('value');
        /*Prevent primary deleting*/
        if(prnt.hasClass("address-div")){
            var radio = prnt.find(".address-radio").first().is(":checked");
            if(radio){
                alert('You Cannot delete the Primary Address, Please choose another Address as Primary Before Deleting');
                return false;
            }
        }
        if(prnt.hasClass("contact-div")){
             var radio = prnt.find(".phone-radio").first().is(":checked");
            if(radio){
                alert('You Cannot delete the Primary Contact Number,Please choose another Contact Number as Primary Before Deleting');
                return false;
            }
           var radio = prnt.find(".email-radio").first().is(":checked");
           if(radio){
                alert('You Cannot delete the Primary Email Address,Please choose another Email Address as Primary or UNSET this Email Address as Primary before Deleting');
                return false;
                    //this is the primary
                    //can delete primary?
            }
        }
        /*Spouse and Parents extra Validation*/
        if($(caller).hasClass('relation-spouse-delete')){
            var child = prnt.find(".relation-spouse");
            $(child).removeClass("relation-spouse");
            document.getElementById("spouseAddButton").disabled = false;
        }
        if($(caller).hasClass('relation-father-delete')){
            var child = prnt.find(".relation-parent");
            $(child).removeClass("relation-parent");
            document.getElementById("fatherAddButton").disabled = false;
        }
        if($(caller).hasClass('relation-mother-delete')){
            var child = prnt.find(".relation-parent");
            $(child).removeClass("relation-parent");
            document.getElementById("motherAddButton").disabled = false;
        }
        if(newValue === 'true'){
            prnt.remove();
        }else{
            delInput.attr('value','true');
            prnt.hide();
        }
    }
 };
 ns("icbs.Customer");
 icbs.Customer.Reports = function(callThis,url,params){
     
    var get = function(callThis,url,params){
        var ajax = icbs.Dependencies.Ajax;
        if(callThis==='creditLimit'){ajax.run({url:url,params:params,callback:getCreditLimitFormCallback});}
        if(callThis==='status'){ajax.run({url:url,params:params,callback:getStatusFormCallback});}
     };
 };
 ns("icbs.Customer.Inquiry");
 icbs.Customer.Inquiry.Update = function(callThis,url,params){
     var inquiryFormCallback = function(data,params){
         jQuery('#customerInquiryFormDiv').html(data.inquiryForm);
         jQuery('#actionsDiv').html(data.actions);
     };
     var statusUpdateCallback = function(data,params){
         jQuery('#updateStatusDiv').html(data);
     };
     var creditLimitUpdateCallback = function(data,params){
         jQuery('#updateCreditLimitDiv').html(data);
     };
     
     var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='inquiryForm'){ajax.run({url:url,params:params,callback:inquiryFormCallback,dataType:'json'});}
         if(callThis==='creditLimit'){ajax.run({url:url,params:params,callback:creditLimitUpdateCallback});}
         if(callThis==='status'){ajax.run({url:url,params:params,callback:statusUpdateCallback});}
     };
     sendUpdate(callThis,url,params);
};
icbs.Customer.Inquiry.Update.getForm = function(callThis,url,params){
     var getCreditLimitFormCallback = function(data,params){
         jQuery('#updateCustomerCreditLimitModal .modal-body #updateCreditLimitDiv').html(data);
          $('#updateCustomerCreditLimitModal').modal({show:true});
     };
     var getStatusFormCallback = function(data,params){
         jQuery('#updateCustomerStatusModal .modal-body #updateStatusDiv').html(data);
          $('#updateCustomerStatusModal').modal({show:true});
     };
     var get = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='creditLimit'){ajax.run({url:url,params:params,callback:getCreditLimitFormCallback});}
         if(callThis==='status'){ajax.run({url:url,params:params,callback:getStatusFormCallback});}
     };
     get(callThis,url,params);
};


icbs.Customer.Relation = function(callThis,url,params){
    var relationFormCallback = function(data,params){
        jQuery('#showRelatedFormDiv').html(data);
    };
    var addRelationCallback = function(data,params){
        jQuery('#createRelatedDiv').html(data);
        $('#addRelationshipModal').modal({show:true});
     };
    var saveRelationCallback = function(data,params){
        jQuery('#createRelatedDiv').html(data);
    };
    var editRelationCallback = function(data,params){
        jQuery('#editRelatedDiv').html(data);
        $('#editRelationshipModal').modal({show:true});
    };
    var updateRelationCallback = function(data,params){
        jQuery('#editRelatedDiv').html(data);
    };
    var sendUpdate = function(callThis,url,params){
         var ajax = icbs.Dependencies.Ajax;
         if(callThis==='relationForm'){ajax.run({url:url,params:params,callback:relationFormCallback});}
         if(callThis==='add'){ajax.run({url:url,params:params,callback:addRelationCallback});}
         if(callThis==='save'){ajax.run({url:url,params:params,callback:saveRelationCallback});}
         if(callThis==='edit'){ajax.run({url:url,params:params,callback:editRelationCallback});}
         if(callThis==='update'){ajax.run({url:url,params:params,callback:updateRelationCallback});}
     };
     sendUpdate(callThis,url,params);
};
 
