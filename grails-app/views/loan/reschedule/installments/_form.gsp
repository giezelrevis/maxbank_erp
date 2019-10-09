
<script type="text/javascript">
    $('#installmentDate').datepicker({
        format: "mm/dd/yyyy",
        todayBtn: "linked",
        multidate: false,
        autoclose: true,
        todayHighlight: true
  });
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
    <g:hasErrors bean="${installment}"> 
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

    <div name="add-installment-form">
		<div class="fieldcontain form-group ${hasErrors(bean: installment, field: 'installmentDate', 'has-error')}">
			<label for="installmentDate" class="control-label col-sm-4">Installment Date <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
                <g:customDatePicker name="installmentDate" precision="day" class="form-control" value="${installment?.installmentDate}"  />

				<g:hasErrors bean="${installment}" field="installmentDate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${installment}" field="installmentDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
			</div>
		</div>
		<div class="fieldcontain form-group ${hasErrors(bean: installment, field: 'principalInstallmentAmount', 'has-error')}">
			<label for="principalInstallmentAmount" class="control-label col-sm-4">Principal <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
				<g:field class="form-control" name="principalInstallmentAmount" value="${installment?.principalInstallmentAmount}" />

				<g:hasErrors bean="${installment}" field="principalInstallmentAmount">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${installment}" field="principalInstallmentAmount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
			</div>			
		</div>	
        <div class="fieldcontain form-group ${hasErrors(bean: installment, field: 'interestInstallmentAmount', 'has-error')}">
            <label for="interestInstallmentAmount" class="control-label col-sm-4">Interest <span class="required-indicator">*</span></label>
            <div class="col-sm-8">
                <g:field class="form-control" name="interestInstallmentAmount" value="${installment?.interestInstallmentAmount}" />

                <g:hasErrors bean="${installment}" field="interestInstallmentAmount">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${installment}" field="interestInstallmentAmount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>          
        </div>
    </div>
</div>




