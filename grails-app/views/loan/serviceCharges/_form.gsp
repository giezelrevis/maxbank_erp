<script type="text/javascript">
   updateServiceChargeForm();
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
    <g:hasErrors bean="${serviceCharge}"> 
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

    <div name="add-service-charge-form">
        <div class="fieldcontain form-group ${hasErrors(bean: serviceCharge, field: 'scheme', 'has-error')}">
            <label for="serviceChargeScheme" class="control-label col-sm-4">Scheme</label>
            <div class="col-sm-8">
                <g:select class="form-control" id="serviceChargeScheme" name="scheme.id" from="${product?.amortizedChargeSchemes?.sort{it.id}}" optionKey="id" optionValue="name" value="${serviceCharge?.scheme?.id}" onchange="updateServiceChargeForm()" />

                <g:hasErrors bean="${serviceCharge}" field="scheme">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${serviceCharge}" field="scheme">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div id="service-charge-amount-form-group" class="fieldcontain form-group ${hasErrors(bean: serviceCharge, field: 'amount', 'has-error')}" style="display:none">
            <label for="serviceChargeAmount" class="control-label col-sm-4">Amount <span class="required-indicator">*</span></label>
            <div class="col-sm-8">
                <g:field class="form-control" name="serviceChargeAmount" value="${serviceCharge?.amount}" onkeyup="service()"/>

                <g:hasErrors bean="${serviceCharge}" field="amount">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${serviceCharge}" field="amount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div id="service-charge-rate-form-group" style="display:none">
        <div class="fieldcontain form-group ${hasErrors(bean: serviceCharge, field: 'rate', 'has-error')}">
            <label for="serviceChargeRate" class="control-label col-sm-4">Rate (%) <span class="required-indicator">*</span></label>
            <div class="col-sm-8">
                <g:field class="form-control" name="serviceChargeRate" value="${serviceCharge?.rate}" onkeyup="updateServiceChargeAmount()" />

                <g:hasErrors bean="${serviceCharge}" field="rate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${serviceCharge}" field="rate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>            
        </div>
        <div class="fieldcontain form-group">
            <label for="serviceChargeRateAmount" class="control-label col-sm-4">Amount</label>
            <div class="col-sm-8">
                <g:field class="form-control" name="serviceChargeRateAmount" readonly="true"/>
            </div>	
        </div>
        </div>
    </div>
</div>




