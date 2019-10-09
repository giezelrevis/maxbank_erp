<script type="text/javascript">
    $('#pdcDate').datepicker({
        format: "mm/dd/yyyy",
        todayBtn: "linked",
        multidate: false,
        autoclose: true,
        todayHighlight: true
    });
    
</script>
<script type="text/javascript">
 function updateAmount() 
                                {
                                var Amt = $('#amount').val().replace(/([A-Z,a-z],#,@,-,+,=)/g,'');
                                $('#amount').val(Amt);
                                }
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
    <g:hasErrors bean="${pdc}"> 
        <div class="box-body">
            <div class="alert alert-danger alert-dismissable">
                <i class="fa fa-ban"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Alert!</b> 
                <ul class="errors" role="alert">
                    Duplicate Check Number
                </ul>            
            </div>
        </div>
    </g:hasErrors>

    <div name="add-pdc-form">
        <div class="fieldcontain form-group ${hasErrors(bean: pdc, field: 'accountNo', 'has-error')}">
            <label for="accountNo" class="control-label col-sm-4">Account No</label>
            <div class="col-sm-8">
                <g:field name="accountNo" value="${pdc?.accountNo}" class="form-control"/>

                <g:hasErrors bean="${pdc}" field="accountNo">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${pdc}" field="accountNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: pdc, field: 'checkNo', 'has-error')}">
            <label for="checkNo" class="control-label col-sm-4">Check No</label>
            <div class="col-sm-8">
                <g:field name="checkNo" value="${pdc?.checkNo}" class="form-control"/>

                <g:hasErrors bean="${pdc}" field="checkNo">
                    
                </g:hasErrors>
            </div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: pdc, field: 'amount', 'has-error')}">
            <label for="amount" class="control-label col-sm-4">Amount</label>
            <div class="col-sm-8">
                
                <g:field type="number" name="amount" value="${pdc?.amount}" class="form-control truncated"/>
                <g:hasErrors bean="${pdc}" field="amount">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${pdc}" field="amount">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: pdc, field: 'bank', 'has-error')}">
            <label for="bank" class="control-label col-sm-4">Bank</label>
            <div class="col-sm-8">
                <g:field name="bank" value="${pdc?.bank}" class="form-control"/>

                <g:hasErrors bean="${pdc}" field="bank">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${pdc}" field="bank">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: pdc, field: 'onUs', 'has-error')}">
            <label for="onUs" class="control-label col-sm-4">On Us</label>
            <div class="col-sm-8">
                <%--<g:checkBox class="form-control" name="onUs" value="${pdc?.onUs}" />--%>
                <input type="checkbox" id="onUs" name="onUs" class="form-control" ${pdc?.onUs ? 'checked="checked"' : ''} />
            </div>
        </div>

        <div class="fieldcontain form-group ${hasErrors(bean: pdc, field: 'pdcDate', 'has-error')}">
            <label for="pdcDate" class="control-label col-sm-4">Date</label>
            <div class="col-sm-8">
                <g:customDatePicker name="pdcDate" precision="day" class="form-control" value="${pdc?.pdcDate}" />

                <g:hasErrors bean="${pdc}" field="pdcDate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${pdc}" field="pdcDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
		        
    </div>
</div>




