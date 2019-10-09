<%@ page import="icbs.admin.Policy" %>


<div class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="type">
       Policy Type
       <span class="required-indicator">*</span>
    </label>

    <div class="col-sm-8">
        <g:select id="type" name="type" from="${['Process', 'TXN']}" value="${params.type}" class="many-to-one form-control" />
    </div>
</div>


<div class="fieldcontain form-group ${hasErrors(bean: policyInstance, field: 'policyTemplate', 'has-error')} required">
	<label class="control-label col-sm-4" for="policyTemplate">
		<g:message code="policy.policyTemplate.label" default="Policy Template" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="policyTemplate" name="policyTemplate.id" from=""  optionKey="id" optionValue="description"  value="${policyInstance?.policyTemplate?.id}" class="many-to-one form-control" />

            <g:hasErrors bean="${policyInstance}" field="policyTemplate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${policyInstance}" field="policyTemplate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<script>
    $(function(){
        $('#type').on('change',function(){
           
             $('#policyTemplate').html('');
            
             var opt = (type.value).toUpperCase() == "PROCESS" ? "PROCESS":"TXN";
            
            
             var res = $.post('/icbs/policy/getPolicyJS',{recid : opt });
            
             res.success(function(data){
                $.each(JSON.parse(data),function(id,value){
                     $('#policyTemplate').append("<option value="+value.id+">"+value.description);
                });
               
             });
                
            
        });
        
        
        $('#policyTemplate').html('');
        var res = $.post('/icbs/policy/getPolicyJS',{recid : "PROCESS" });
            
        res.success(function(data){
           $.each(JSON.parse(data),function(id,value){
                $('#policyTemplate').append("<option value="+value.id+">"+value.description);
           });

        });
        
        
    });
</script>


<div class="fieldcontain form-group ${hasErrors(bean: policyInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="policy.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="description" maxlength="100" required="" value="${policyInstance?.description}"class="form-control"/>

            <g:hasErrors bean="${policyInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${policyInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div id="txnAmt" class="fieldcontain form-group ${hasErrors(bean: policyInstance, field: 'txnAmtCondition', 'has-error')} ">
	<label class="control-label col-sm-4" for="txnAmtCondition">
		<g:message code="policy.txnAmtCondition.label" default="Txn Amt Condition" />
		
	</label>
	<div class="col-sm-8"><g:field name="txnAmtCondition" value="${fieldValue(bean: policyInstance, field: 'txnAmtCondition')}" class="form-control"/>

            <g:hasErrors bean="${policyInstance}" field="txnAmtCondition">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${policyInstance}" field="txnAmtCondition">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: policyInstance, field: 'policyAction', 'has-error')} required">
	<label class="control-label col-sm-4" for="policyAction">
		<g:message code="policy.policyAction.label" default="Policy Action" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="policyAction" name="policyAction.id" from="${icbs.lov.PolicyAction.list()}" optionKey="id" optionValue="description" required="" value="${policyInstance?.policyAction?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${policyInstance}" field="policyAction">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${policyInstance}" field="policyAction">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: policyInstance, field: 'reference', 'has-error')} ">
	<label class="control-label col-sm-4" for="reference">
		<g:message code="policy.reference.label" default="Reference" />
		
	</label>
	<div class="col-sm-8"><g:textField name="reference" value="${policyInstance?.reference}"class="form-control"/>

            <g:hasErrors bean="${policyInstance}" field="reference">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${policyInstance}" field="reference">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div><g:hiddenField name="configItemStatus" value="2" /></div>


<script type="text/javascript">
    $(document).ready(function() {
        $("#txnAmt").hide();
        $("#txntab").hide();
        
        if($("#txnAmtCondition").val()) {
            $("#type option[value=Transaction]").attr('selected','selected');
            $("#txnAmt").show();
            $("#txntab").show();
        }

        $("#type").change(function() {
            if($(this).val() == "TXN") {
                $("#txnAmt").show();
                $("#txntab").show();
            }
            else {
                $("#txnAmt").hide();
                $("#txnAmtCondition").val('');
                $("#txntab").hide();
            }
        });
    });
</script>
