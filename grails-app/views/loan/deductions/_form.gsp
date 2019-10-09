<script type="text/javascript">
    updateDeductionForm();
</script>

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
    <g:hasErrors bean="${deduction}"> 
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

    <div name="add-deduction-form">
        <div class="fieldcontain form-group ${hasErrors(bean: deduction, field: 'scheme', 'has-error')}">
            <label for="deductionScheme" class="control-label col-sm-4">Scheme</label>
            <div class="col-sm-8">
                <g:select class="form-control" id="deductionScheme" name="scheme.id" from="${product?.loanDeductionSchemes?.findAll{it.status.id == 2}}" optionKey="id" optionValue="name" value="${deduction?.scheme?.id}" class="many-to-one form-control" onchange="updateDeductionForm()" />

                <g:hasErrors bean="${deduction}" field="scheme">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${deduction}" field="scheme">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
		<div id="deduction-amount-form-group" class="fieldcontain form-group ${hasErrors(bean: deduction, field: 'amount', 'has-error')}" style="display:none">
			<label for="deductionAmount" class="control-label col-sm-4">Amount <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
                                
                   <g:field  id="deductionAmount" name="deductionAmount" value="${deduction?.amount}" onkeyup="AddComma()" class="form-control truncated"/>
				<g:hasErrors bean="${deduction}" field="amount">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${deduction}" field="amount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
			</div>
		</div>
        <div id="deduction-rate-form-group" style="display:none">
		<div class="fieldcontain form-group ${hasErrors(bean: deduction, field: 'rate', 'has-error')}">
			<label for="deductionRate" class="control-label col-sm-4">Rate (%) <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
				<g:field class="form-control truncated" name="deductionRate" value="${deduction?.rate}" onkeyup="updateDeductionAmount(2)"/>
                                

                <g:hasErrors bean="${deduction}" field="rate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${deduction}" field="rate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
			</div>			
		</div>
        <div class="fieldcontain form-group">
            <label for="deductionRateAmount" class="control-label col-sm-4">Amount</label>
            <div class="col-sm-8">
                <g:field class="form-control" name="deductionRateAmount" readonly="true" />
            </div>          
        </div>   
        </div>       
    </div>
</div>




