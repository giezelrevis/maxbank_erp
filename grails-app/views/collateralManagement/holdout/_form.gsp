
 <div class="fieldcontain form-group ${hasErrors(bean: holdoutInstance, field: 'accountNo', 'has-error')}">
            <label for="depositAccount" class="control-label col-sm-4">Deposit Account <span class="required-indicator">*</span></label>
            <div class="col-sm-6">
                <g:field class="form-control" name="accountNo" value="${holdoutInstance?.accountNo}"  readonly="true" />
                <g:hiddenField id="depositAccount" name="depositAccount.id" value="${sweepAccount?.depositAccount?.id}" />

                <g:hasErrors bean="${holdoutInstance}" field="accountNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${holdoutInstance}" field="accountNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
                </g:hasErrors>
            </div>        

            <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showDepositSearch()" value="Search"/></div>
        </div>

<div class="fieldcontain form-group ${hasErrors(bean: holdoutInstance, field: 'holdoutDate', 'has-error')}">
    <label class="control-label col-sm-4" for="holdoutDate">
        Holdout Date 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:customDatePicker name="holdoutDate" precision="day" 
    class="form-control" value="${holdoutInstance?.holdoutDate}" />

        <g:hasErrors bean="${holdoutInstance}" field="holdoutDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${holdoutInstance}" field="holdoutDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>