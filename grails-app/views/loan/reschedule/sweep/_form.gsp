
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
    <g:hasErrors bean="${sweepAccount}"> 
        <div class="box-body">
            <div class="alert alert-danger alert-dismissable">
                <i class="fa fa-ban"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Alert!</b> 
                <ul class="errors" role="alert">
                    There are errors
                </ul>            
            </div>
        </div>
    </g:hasErrors>

    <div name="add-sweep-account-form">
        <div class="fieldcontain form-group ${hasErrors(bean: sweepAccount, field: 'depositAccount', 'has-error')}">
            <label for="depositAccount" class="control-label col-sm-4">Deposit Account <span class="required-indicator">*</span></label>
            <div class="col-sm-6">
                <g:field class="form-control" name="accountNo" value="${sweepAccount?.depositAccount?.acctNo}"  readonly="true" />
                <g:hiddenField id="depositAccount" name="depositAccount.id" value="${sweepAccount?.depositAccount?.id}" />

                <g:hasErrors bean="${sweepAccount}" field="depositAccount">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepAccount}" field="depositAccount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>        

            <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showDepositSearch()" value="Search"/></div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: sweepAccount, field: 'rule', 'has-error')}">
            <label for="deductionScheme" class="control-label col-sm-4">Rule</label>
            <div class="col-sm-8">
                <g:select class="form-control" id="rule" name="rule.id" from="${icbs.lov.SweepRule.list().sort{it.id}}" optionKey="id" optionValue="description" value="${sweepAccount?.rule?.id}"/>
            </div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: sweepAccount, field: 'fundLimitAmt', 'has-error')}">
            <label class="control-label col-sm-4" for="fundLimitAmt">Fund Limit Amount</label>
            <div class="col-sm-8">
                <g:field name="fundLimitAmt" value="${fieldValue(bean: sweepAccount, field: 'fundLimitAmt')}" class="form-control"/>
            </div>
        </div>             

        <div class="fieldcontain form-group ${hasErrors(bean: sweepAccount, field: 'fundLimitPercentage', 'has-error')} required">
            <label class="control-label col-sm-4" for="fundLimitPercentage">Fund Limit Percentage <span class="required-indicator">*</span></label>
            <div class="col-sm-8">
                <g:field name="fundLimitPercentage" value="${fieldValue(bean: sweepAccount, field: 'fundLimitPercentage')}" required="" class="form-control"/>

                <g:hasErrors bean="${sweepAccount}" field="fundLimitPercentage">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepAccount}" field="fundLimitPercentage">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>             
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: sweepAccount, field: 'ordinalNum', 'has-error')} required">
            <label class="control-label col-sm-4" for="ordinalNum">Ordinal No. <span class="required-indicator">*</span></label>
            <div class="col-sm-8">
                <g:field name="ordinalNum" type="number" min="0" value="${sweepAccount?.ordinalNum}" required="" class="form-control"/>

                <g:hasErrors bean="${sweepAccount}" field="ordinalNum">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${sweepAccount}" field="ordinalNum">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>             
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: sweepAccount, field: 'remarks', 'has-error')} ">
            <label class="control-label col-sm-4" for="remarks">Remarks</label>
            <div class="col-sm-8">
                <g:textArea name="remarks" cols="40" rows="5" maxlength="255" value="${sweepAccount?.remarks}"class="form-control"/>
            </div>             
        </div>
    </div>    
</div>




