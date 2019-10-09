<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Teller Checks to COCI Transaction</title>


        <g:javascript>
            $.ajax({
                    type: 'POST',
                    data: { id:$('#id').val(), checkType:$('#checkType').val(), bank:$('#bank').val(), acctNo:$('#acctNo').val(), checkDate:$('#checkDate').val(), checkNo:$('#checkNo').val(), clearingDate:$('#clearingDate').val(), checkAmt:$('#checkAmt').val()},
                    error:function(XMLHttpRequest,textStatus,errorThrown){
                    alert(XMLHttpRequest+textStatus+errorThrown);
                }
            });
        </g:javascript>
        <script type="text/javascript">
        $(function(){

                $('#btnAddMore').click(function(){
                    var lastRow = $('.check-table tbody > tr:last');
                    var lastIndex = parseInt(lastRow.attr('data-index'));
                    lastRow.find('select').select2('destroy');
                    var clonedRow = lastRow.clone();
                    
                    clonedRow.attr('data-index', lastIndex + 1);
                    $.each(clonedRow.find('[data-name]'), function(index,data) {
                        data = $(data);
                        data.attr('name', 'coci[' + (lastIndex + 1) + '].' + data.attr('data-name'));
                    });
                                   
                    <!--Gets the last row and appends appendRow when correct row is found-->
                    $('.check-table tbody > tr:last').after(clonedRow);

                    $('.check-table tbody').find('select').select2({allowClear: true});
                    datepickerInitializer();
                });

                <!--Deletes a row-->
                $(document).on('click', '.deleteThisRow',function(){
                    var rowLength = $('.check-table tbody > tr').size();

                    if(rowLength > 1){
                        deleteRow($(this));
                    }
                });

                function deleteRow(currentNode){
                    currentNode.parent().parent().remove();
                }
            });
        </script>
    <script type="text/javascript">

    function do_this(){

        var checkboxes = document.getElementsByName('cleared');
        var button = document.getElementById('toggle');

        if(button.value == 'Select All'){
            for (var i in checkboxes){
                checkboxes[i].checked = 'FALSE';
            }
            button.value = 'Deselect All'
        }else{
            for (var i in checkboxes){
                checkboxes[i].checked = '';
            }
            button.value = 'Select All';
        }
        btnCompute()
    }
    </script>        
    </head>
    
    <body>
        <content tag="main-content">
        <g:if test="${flash.message}">
                <script>
                        $(function(){
                            var x = '${flash.message}';
                                notify.message(x);
                                $('#SlipTransaction').hide();
                                if(x.indexOf('|success') > -1){
                                $('#SlipTransaction').show();
                            }
                           // console.log(x)
                           // setTimeout(function(){ notify.success(x); }, 3000);
                        });
                </script>
                <div id="SlipTransaction" class="alert alert-success alert-dismissable" role="alert">
                   <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                           <div> 

                                <a onclick="
                                    var w = window.open('printValidationSlip', '_blank')
                                        w.print();
                                    ">
                                <g:img dir="images" file="validate.png" width="35" height="35"/>
                                Validation Slip
                            </a>
                           </div>
                </div>
            </g:if>
            <g:hasErrors bean="${txnCheckToCOCIInstance}">
              <g:eachError bean="${txnCashTransferInstance}" var="error">
                  <script>
                      $(function(){
                          var x = '${it}';
                          notify.error(x);
                         // console.log(x)
                         // setTimeout(function(){ notify.success(x); }, 3000);
                      });
                  </script>
              </g:eachError>    
                <div id= "addCustomerRelatedError" class="box-body">
<!--                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                            </div>
                            <g:eachError bean="${txnCheckToCOCIInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>-->
                </div>
            </g:hasErrors>
                    
            <g:form name="txnCheckToCOCIForm" action="saveTellerCheckToCOCITxn" controller="tellering">
                <g:render template='txnCheckToCOCI/form' model="[txnCheckToCOCIInstance:txnCheckToCOCIInstance]"/>
            </g:form>
 
        </content>
        
         <!--Grails tag for jasper plugin-->
         <g:jasperReport action="printSLIP"  controller="tellering" format="PDF" name="TRANSACTION"  jasper="SLIP">
         </g:jasperReport>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="if(!$('#txnTemplate').val()||!$('#txnRef').val()){ notify.message('Transaction type/Reference  empty!|error|alert');return;};
                                             if($('#txnAmt').val()==0){ notify.message('Zero amount not allowed!|error|alert'); return; }
                                             if(parseFloat($('#txnAmt').val()) != parseFloat($('#totalChecks').val())){ notify.message('Total Checks and Check Control do not match!|error|alert'); return;}
                                             alertify.confirm(AppTitle,'Are you sure you want to continue this transaction?',
                                             function(){
                                                //jQuery('#txnCheckToCOCIForm').submit();
                                                checkIfAllowed($('#txnTemplate option:selected').data('code'), 'form#txnCheckToCOCIForm', 'txnCheckToCOCIOverride', $('#txnAmt').val());
                                             },function(){
                                                return;
                                             });
                                             
                                                          ">${message(code: 'default.button.create.label', default: 'Create')}</a></li></li>
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to the Tellering Index page?');">Tellering Index</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
