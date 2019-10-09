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
        <div class="fieldcontain form-group">
            <label for="deductionScheme" class="control-label col-sm-4">Scheme</label>
            <div class="col-sm-8">
                <g:select class="form-control" id="deductionScheme" name="scheme.id" from="${product?.loanDeductionSchemes?.sort{it.id}}" optionKey="id" optionValue="name" value="${deduction?.scheme?.id}" onchange="updateDeductionForm()" />
            </div>
        </div>

		<div id="deduction-amount-form-group" class="fieldcontain form-group ${hasErrors(bean: deduction, field: 'amount', 'has-error')}" style="display:none">
			<label for="deductionAmount" class="control-label col-sm-4">Amount <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
				<g:field class="form-control" name="deductionAmount" value="${deduction?.amount}" />

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
        <div id="deduction-fixed-amount-form-group" class="fieldcontain form-group" style="display:none">
            <label for="deductionFixedAmount" class="control-label col-sm-4">Amount</label>
            <div class="col-sm-8">
                <g:field class="form-control" name="deductionFixedAmount" value="${deduction?.scheme?.amount}" readonly="true" />
            </div>          
        </div>          
		<div id="deduction-rate-form-group" class="fieldcontain form-group" style="display:none">
			<label for="deductionRate" class="control-label col-sm-4">Rate (%)</label>
			<div class="col-sm-8">
				<g:field class="form-control" name="deductionRate" value="${deduction?.scheme?.rate}" readonly="true" />
			</div>			
		</div>			
    </div>
</div>




