<div class="fieldcontain form-group ${hasErrors(bean: pdcInstance, field: 'accountNo', 'has-error')}">
    <label class="control-label col-sm-4" for="accountNo">
        Account No. 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="accountNo" value="${pdcInstance?.accountNo}" class="form-control"/>
        <g:hasErrors bean="${pdcInstance}" field="accountNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${pdcInstance}" field="accountNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: pdcInstance, field: 'checkNo', 'has-error')}">
    <label class="control-label col-sm-4" for="checkNo">
        Check No. 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="checkNo" value="${pdcInstance?.checkNo}" class="form-control"/>
        <g:hasErrors bean="${pdcInstance}" field="checkNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${pdcInstance}" field="checkNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: pdcInstance, field: 'amount', 'has-error')}">
    <label class="control-label col-sm-4" for="amount">
        Amount 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
         <g:field type="number" name="amount" value="${pdc?.amount}" class="form-control truncated"/>
        <g:hasErrors bean="${pdcInstance}" field="amount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${pdcInstance}" field="amount">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: pdcInstance, field: 'bank', 'has-error')}">
    <label class="control-label col-sm-4" for="bank">
        Bank 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="bank" value="${pdcInstance?.bank}" class="form-control"/>
        <g:hasErrors bean="${pdcInstance}" field="bank">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${pdcInstance}" field="bank">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: pdcInstance, field: 'onUs', 'has-error')}">
    <label class="control-label col-sm-4" for="onUs">
        On Us
    </label>
    <div class="col-sm-8">    
        <g:checkBox class="form-control" name="onUs" value="${pdcInstance?.onUs}" />
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: pdcInstance, field: 'pdcDate', 'has-error')}">
    <label class="control-label col-sm-4" for="pdcDate">
        PDC Date 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:customDatePicker name="pdcDate" precision="day" 
    class="form-control" value="${pdcInstance?.pdcDate}" />

        <g:hasErrors bean="${pdcInstance}" field="pdcDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${pdcInstance}" field="pdcDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>