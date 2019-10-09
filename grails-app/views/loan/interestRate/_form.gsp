

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
    <g:hasErrors bean="${loanInstance}"> 
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
    <g:form name="update-interest-rate-form">
        <g:hiddenField name="id" id="id" value="${loanInstance?.id}"/>
        <g:hiddenField name="activity" value="Repricing" />
        <g:if test="${loanInstance?.interestIncomeScheme?.advInterestType?.id == 1}">
        <div class="form-group fieldcontain ${hasErrors(bean: loanInstance, field: 'interestRate', 'has-error')} ">
            <label class="control-label col-sm-4" for="interestRate">Interest Rate</label>
            <div class="col-sm-8">
                <g:field class="form-control" type="numeric" id="interestRate" name="interestRate" value="${fieldValue(bean: loanInstance, field: 'interestRate')}"  />
                <g:hasErrors bean="${loanInstance}" field="interestRate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanInstance}" field="interestRate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        </g:if>
        <g:else>
            <g:field class="form-control" type="numeric" id="interestRate" name="interestRate" readonly="readonly" value="${fieldValue(bean: loanInstance, field: 'interestRate')}"  />
        </g:else>
        
    </g:form>  
</div>
<script>
     $('#interestRate').numeric({
                                allowMinus   : false,
                                allowPlus    : false,
                                maxDecimalPlaces : 2
                                });
                                </script>
