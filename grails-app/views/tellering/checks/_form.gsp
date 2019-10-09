<%@ page import="icbs.lov.ConfigItemStatus" %>

<div>
    <g:if test="${message}">
        <div class="box-body">
            <div class="alert alert-info alert-dismissable">
                <i class="fa fa-info"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Message</b> <div class="message" role="status">${message}</div>
            </div>
        </div>
    </g:if>
    <g:hasErrors bean="${txnCOCIInstance}"> 
        <div class="box-body">
            <div class="alert alert-danger alert-dismissable">
                <i class="fa fa-ban"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Alert!</b> 
                <ul class="errors" role="alert">
                    <strong>There are errors</strong>
                </ul>            
            </div>
        </div>
    </g:hasErrors>
    
    <div name="add-txn-coci-form">
        <g:hiddenField name="deposit_id" id="deposit_id" value="" />
        <div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'checkType', 'has-error')}">
        <label for="checkType" class="control-label col-sm-4">Check Type <span class="required-indicator">*</span></label>
        <div class="col-sm-8">
            <g:select id="checkType" name="checkType.id" from="${icbs.admin.CheckDepositClearingType.list()}" optionKey="id" optionValue="description" required="" value="${txnCOCIInstance?.checkType?.id}" onChange="validateOnUs();" noSelection="['': '']" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnCOCIInstance}" field="checkType">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${txnCOCIInstance}" field="checkType">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    
        
    <div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'bank', 'has-error')}">
        <label for="bank" class="control-label col-sm-4">Bank <span class="required-indicator">*</span></label>
        <div class="col-sm-8">
           <g:select id="bank" name="bank.id" from="${icbs.admin.ClearingBank.findAllByConfigItemStatus(ConfigItemStatus.get(2))}" optionKey="id" required="" optionValue="name" value="${txnCOCIInstance?.bank?.id}" noSelection="['': '']" class="many-to-one form-control"/>

        <g:hasErrors bean="${txnCOCIInstance}" field="bank">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${txnCOCIInstance}" field="bank">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
        </div>			
    </div>
    
    <div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'acctNo', 'has-error')}">
        <label for="acctNo" class="control-label col-sm-4">Acct No. <span class="required-indicator">*</span></label>
        <div class="col-sm-8">
            <g:textField name="acctNo" required="" value="${txnCOCIInstance?.acct}"class="form-control"/>

        <g:hasErrors bean="${txnCOCIInstance}" field="acct">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${txnCOCIInstance}" field="acct">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
        </div>			
    </div>
      
    <div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'checkDate', 'has-error')}">
        <label for="checkDate" class="control-label col-sm-4">Check Date <span class="required-indicator">*</span></label>
        <div class="col-sm-8">
            <g:customDatePicker id="checkDate" name="checkDate" precision="day" class="form-control"  value="${txnCOCIInstance?.checkDate}" default="none" noSelection="['': '']" />
            <!-- input type="date" name="checkDate" precision="day" class="form-control"  value="${txnCOCIInstance?.checkDate}" default="none" noSelection="['': '']" / -->
            <g:javascript>
                // this will prevent resetting of date picker on reload
                // #
            $(function(){
                //Date range picker with time picker
                $('#checkDate').datepicker();
            });
            </g:javascript>
            <g:hasErrors bean="${txnCOCIInstance}" field="checkDate">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${txnCOCIInstance}" field="checkDate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>			
    </div>
    
    <div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'checkNo', 'has-error')}">
        <label for="checkNo" class="control-label col-sm-4">Check No. <span class="required-indicator">*</span></label>
        <div class="col-sm-8">
            <g:textField name="checkNo" required="" value="${txnCOCIInstance?.checkNo}"class="form-control"/>

        <g:hasErrors bean="${txnCOCIInstance}" field="checkNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${txnCOCIInstance}" field="checkNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
        </div>			
    </div>
    
   
    <div class="fieldcontain form-group ${hasErrors(bean: txnCOCIInstance, field: 'checkAmt', 'has-error')}">
        <label for="checkAmt" class="control-label col-sm-4">Check Amount <span class="required-indicator">*</span></label>
        <div class="col-sm-8">
            <g:textField type="number" name="checkAmt" required="" value="${txnCOCIInstance?.checkAmt}"class="form-control"/>

        <g:hasErrors bean="${txnCOCIInstance}" field="checkAmt">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${txnCOCIInstance}" field="checkAmt">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
        </div>			
    </div>
    </div>
</div>




