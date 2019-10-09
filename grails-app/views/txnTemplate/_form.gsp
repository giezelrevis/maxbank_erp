<%@ page import="icbs.admin.TxnTemplate" %>

<!-- Txn Type -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'txnType', 'has-error')} required">
	<label class="control-label col-sm-4" for="txnType">
		<g:message code="txnTemplate.txnType.label" default="Txn Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="txnType" name="txnType.id" from="${icbs.lov.TxnType.list()}"  noSelection="['':'']" optionKey="id" required="" value="${txnTemplateInstance?.txnType?.id}" onchange="getcode();" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="txnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="txnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- Code -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="txnTemplate.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label> 
	<div class="col-sm-8"><g:textField name="code" id="code" maxlength="50" required="" value="${txnTemplateInstance?.code}"  onblur="validateExistingCodeAjax();"  class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<!-- Description -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'description', 'has-error')} required">
	<label class="control-label col-sm-4" for="description">
		<g:message code="txnTemplate.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label> 
	<div class="col-sm-8"><g:textField name="description" id="description" maxlength="100" required="" value="${txnTemplateInstance?.description}"  class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- Short Description -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'shortDescription', 'has-error')} ">
	<label class="control-label col-sm-4" for="shortDescription">
		<g:message code="txnTemplate.shortDescription.label" default="Short Description" />
		<span class="required-indicator">*</span>
	</label> 
	<div class="col-sm-8"><g:textField name="shortDescription" id="shortDescription" maxlength="50" value="${txnTemplateInstance?.shortDescription}"class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="shortDescription">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="shortDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- Amla Code --> 
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'amlaCode', 'has-error')} ">
	<label class="control-label col-sm-4" for="amlaCode">
		<g:message code="txnTemplate.amlaCode.label" default="Amla Code" />
		
	</label>
	<div class="col-sm-8"><g:textField name="amlaCode" id="amlaCode" maxlength="10" value=""class="form-control"/>
            
            <g:hasErrors bean="${txnTemplateInstance}" field="amlaCode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="amlaCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<!-- Memo Txn Type -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'memoTxnType', 'has-error')} required">
	<label class="control-label col-sm-4" for="memoTxnType">
		<g:message code="txnTemplate.memoTxnType.label" default="Memo Txn Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="memoTxnType" name="memoTxnType.id" noSelection="['':'']" from="${icbs.lov.MemoTxnType.list()}" optionKey="id" required="" onchange="makeDepContra();" value="${txnTemplateInstance?.memoTxnType?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="memoTxnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="memoTxnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<!-- Depcontra -->
<div id="depcontraid" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'depcontra', 'has-error')} required">
	<label class="control-label col-sm-4" for="memoTxnType">
		<g:message code="txnTemplate.memoTxnType.label" default="Dep Contra (Gl Code)" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="depContra" id="depContra" maxlength="100" value="${txnTemplateInstance?.amlaCode}" onblur="validateGlCode();" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="memoTxnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="memoTxnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- Gl Account Description -->
<div id="glaccountdescription" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'depcontra', 'has-error')} required">
	<label class="control-label col-sm-4" for="memoTxnType">
		<g:message code="txnTemplate.memoTxnType.label" default="Gl Acct Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField readonly="true" name="gldescription" id="gldescription" maxlength="100" value="${txnTemplateInstance?.amlaCode}" onblur="validateGlCode();" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="memoTxnType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="memoTxnType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<!-- App Type -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'validationFormCode', 'has-error')} ">
	<label class="control-label col-sm-4" for="validationFormCode">
		<g:message code="txnTemplate.validationFormCode.label" default="App Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="appType" id="appType" value="" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="appType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="appType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>        


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'currency', 'has-error')} ">
	<label class="control-label col-sm-4" for="currency">
		<g:message code="txnTemplate.currency.label" default="Currency" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" value="${txnTemplateInstance?.currency?.id}" class="many-to-one form-control" noSelection="['': '']"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div id="requirePassbookDiv" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'requirePassbook', 'has-error')} ">
	<label class="control-label col-sm-4" for="requirePassbook">
		<g:message code="txnTemplate.requirePassbook.label" default="Require Passbook" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="requirePassbook" name="requirePassbook.id" from="${icbs.lov.YesNoNa.findAllWhere(status: true)}" optionKey="id" value="" class="many-to-one form-control" noSelection="['': '']"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="requirePassbook">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="requirePassbook">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- Txn Module -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'txnModule', 'has-error')} required">
	<label class="control-label col-sm-4" for="txnModule">
		<g:message code="txnTemplate.txnModule.label" default="Txn Module" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="txnModule" name="txnModule.id" noSelection="['':'']" from="${icbs.lov.TxnModule.list()}" optionKey="id" required="" value="${txnTemplateInstance?.txnModule?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="txnModule">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="txnModule">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div id="atmOnlyTxnDiv" class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'atmOnlyTxn', 'has-error')} required">
	<label class="control-label col-sm-4" for="atmOnlyTxn">
		<g:message code="txnTemplate.atmOnlyTxn.label" default="Atm Only Txn" />
		<span class="required-indicator">*</span>
	</label>
        
	<div class="col-sm-8"><g:select id="atmOnlyTxn" name="atmOnlyTxn.id" noSelection="['':'']" from="${icbs.lov.YesNoNa.findAllWhere(status: true)}" optionKey="id" required="" value="${txnTemplateInstance?.atmOnlyTxn?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="atmOnlyTxn">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="atmOnlyTxn">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'interbranchTxn', 'has-error')} required">
	<label class="control-label col-sm-4" for="interbranchTxn">
		<g:message code="txnTemplate.interbranchTxn.label" default="Interbranch Txn" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="interbranchTxn" name="interbranchTxn.id" noSelection="['':'']" from="${icbs.lov.YesNoNa.list()}" optionKey="id" required="" value="${txnTemplateInstance?.interbranchTxn?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="interbranchTxn">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="interbranchTxn">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'systemOnlyTxn', 'has-error')} required">
	<label class="control-label col-sm-4" for="systemOnlyTxn">
		<g:message code="txnTemplate.systemOnlyTxn.label" default="System Only Txn" />
                <span class="required-indicator">*</span>
		
	</label>
	<div class="col-sm-8"><g:checkBox name="systemOnlyTxn" id="systemOnlyTxn" class="form-control" value="" />

            <g:hasErrors bean="${txnTemplateInstance}" field="systemOnlyTxn">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="systemOnlyTxn">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>



<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'batchTxn', 'has-error')} required">
	<label class="control-label col-sm-4" for="batchTxn">
		<g:message code="txnTemplate.batchTxn.label" default="Batch Txn" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="batchTxn" name="batchTxn.id" from="${icbs.lov.YesNoNa.list()}" noSelection="['':'']" optionKey="id" required="" value="${txnTemplateInstance?.batchTxn?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="batchTxn">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="batchTxn">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<!-- FOR FUTURE FEATURES -->
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'minAmt', 'has-error')} ">
	<label class="control-label col-sm-4" for="minAmt">
		<g:message code="txnTemplate.minAmt.label" default="Min Amt" />
		
	</label>
       
        
	<div class="col-sm-8"><g:field readonly="true" name="minAmt" id="minAmt" value="${fieldValue(bean: txnTemplateInstance, field: 'minAmt')}" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="minAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="minAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'maxAmt', 'has-error')} ">
	<label class="control-label col-sm-4" for="maxAmt">
		<g:message code="txnTemplate.maxAmt.label" default="Max Amt" />
		 
	</label>
	<div class="col-sm-8"><g:field readonly="true" name="maxAmt" id="maxAmt" value="${fieldValue(bean: txnTemplateInstance, field: 'maxAmt')}" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="maxAmt">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="maxAmt">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>




<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'requireTxnDescription', 'has-error')} ">
	<label class="control-label col-sm-4" for="requireTxnDescription">
		<g:message code="txnTemplate.requireTxnDescription.label" default="Require Txn Description" />
		
	</label>
	<div class="col-sm-8"><g:checkBox readonly="true" name="requireTxnDescription" id="requireTxnDescription" class="form-control" onclick="return false"  value="" />

            <g:hasErrors bean="${txnTemplateInstance}" field="requireTxnDescription">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="requireTxnDescription">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'requireTxnReference', 'has-error')} ">
	<label class="control-label col-sm-4" for="requireTxnReference">
		<g:message code="txnTemplate.requireTxnReference.label" default="Require Txn Reference" />
		
	</label>
	<div class="col-sm-8"><g:checkBox readonly="true" name="requireTxnReference" id="requireTxnReference" class="form-control" onclick="return false" value="" />

            <g:hasErrors bean="${txnTemplateInstance}" field="requireTxnReference">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="requireTxnReference">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'validationCopyNo', 'has-error')} ">
	<label class="control-label col-sm-4" for="validationCopyNo">
		<g:message code="txnTemplate.validationCopyNo.label" default="Validation Copy No" />
		
	</label>
	<div class="col-sm-8"><g:field readonly="true" name="validationCopyNo" id="validationCopyNo" type="number" value="${txnTemplateInstance.validationCopyNo}" class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="validationCopyNo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="validationCopyNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'validationFormCode', 'has-error')} ">
	<label class="control-label col-sm-4" for="validationFormCode">
		<g:message code="txnTemplate.validationFormCode.label" default="Validation Form Code" />
		
	</label>
	<div class="col-sm-8"><g:textField readonly="true" name="validationFormCode" id="validationFormCode" value="${txnTemplateInstance?.validationFormCode}"class="form-control"/>

            <g:hasErrors bean="${txnTemplateInstance}" field="validationFormCode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="validationFormCode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<g:hiddenField id="financialYear" name="financialYear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>
<!--
<div class="fieldcontain form-group ${hasErrors(bean: txnTemplateInstance, field: 'configItemStatus', 'has-error')} required">
	<label class="control-label col-sm-4" for="configItemStatus">
		<g:message code="txnTemplate.configItemStatus.label" default="Config Item Status" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="configItemStatus" name="configItemStatus.id" from="${icbs.lov.ConfigItemStatus.list()}" optionKey="id" required="" value="${txnTemplateInstance?.configItemStatus?.id}" class="many-to-one form-control"/>
          
            <g:hasErrors bean="${txnTemplateInstance}" field="configItemStatus">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${txnTemplateInstance}" field="configItemStatus">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
-->

