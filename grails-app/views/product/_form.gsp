<%@ page import="icbs.admin.Product" %>

<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'productType', 'has-error')} required">
    <label class="control-label col-sm-4" for="productType">
        <g:message code="product.productType.label" default="Product Type" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:if test="${mode=='edit'}">
            <g:select type="text" disabled="" id="productType" from="${icbs.lov.ProductType.list()}" optionKey="id" optionValue="description" required="" value="${productInstance?.productType?.id}" class="many-to-one form-control" noSelection="['null': '']" name="productType" onchange="testsel()"/>
        </g:if>
        <g:else>
            <g:select type="text" id="productType" from="${icbs.lov.ProductType.list()}" optionKey="id" optionValue="description" required="" value="${productInstance?.productType?.id}" class="many-to-one form-control" noSelection="['null': '']" name="productType" onchange="testsel()"/>
        </g:else>
        

            <g:hasErrors bean="${productInstance}" field="productType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="productType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="product.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">

    <g:if test="${mode=='edit'}">
        <g:textField name="code" maxlength="10" disabled="" value="${fieldValue(bean: productInstance, field: "code").padLeft(3, '0')}"class="form-control" data-show-when="productType" data-show-when-value="['6']" />
    </g:if>
    <g:else>
        <g:textField name="code" maxlength="10" requdired="" value="${fieldValue(bean: productInstance, field: "code").padLeft(3, '0')}"class="form-control" data-show-when="productType" data-show-when-value="['6']" />
    </g:else>

            <g:hasErrors bean="${productInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="product.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">

                <g:textField name="name" maxlength="100" required="" value="${productInstance?.name}"class="form-control"/>


            <g:hasErrors bean="${productInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'shortName', 'has-error')} required">
	<label class="control-label col-sm-4" for="shortName">
		<g:message code="product.shortName.label" default="Short Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="shortName" maxlength="50" required="" value="${productInstance?.shortName}"class="form-control"/>

            <g:hasErrors bean="${productInstance}" field="shortName">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="shortName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'currency', 'has-error')} required">
    <label class="control-label col-sm-4" for="currency">
        <g:message code="product.currency.label" default="Currency" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        
        <g:if test="${mode=='edit'}">
                 <g:select id="currency" disabled="" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" required="" value="${productInstance?.currency?.id}" class="many-to-one form-control" noSelection="['null': '']" />
            </g:if>
            <g:else>
                 <g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" required="" value="${productInstance?.currency?.id}" class="many-to-one form-control" noSelection="['null': '']" />
            </g:else>
        
        
       

            <g:hasErrors bean="${productInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'minOpen', 'has-error')} required">
    <label class="control-label col-sm-4" for="minOpen">
        <g:message code="product.minOpen.label" default="Min Open" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
         <g:if test="${mode=='edit'}">
                 <g:field name="minOpen" disabled="" value="${fieldValue(bean: productInstance, field: 'minOpen')}" required="" class="form-control"/>
            </g:if>
            <g:else>
                 <g:field name="minOpen" value="${fieldValue(bean: productInstance, field: 'minOpen')}" required="" class="form-control"/>
            </g:else>
        
        
        

            <g:hasErrors bean="${productInstance}" field="minOpen">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="minOpen">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'maxOpen', 'has-error')} required">
    <label class="control-label col-sm-4" for="maxOpen">
        <g:message code="product.maxOpen.label" default="Max Open" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        
         <g:if test="${mode=='edit'}">
                 <g:field name="maxOpen" disabled="" value="${fieldValue(bean: productInstance, field: 'maxOpen')}" required="" class="form-control"/>
            </g:if>
            <g:else>
                <g:field name="maxOpen" value="${fieldValue(bean: productInstance, field: 'maxOpen')}" required="" class="form-control"/>
            </g:else>
        
        
        

            <g:hasErrors bean="${productInstance}" field="maxOpen">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="maxOpen">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div id="bal">
    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'minBalance', 'has-error')} required">
        <label class="control-label col-sm-4" for="minBalance">
            <g:message code="product.minBalance.label" default="Min Balance" />
        </label>
        <div class="col-sm-8"><g:field name="minBalance" value="${fieldValue(bean: productInstance, field: 'minBalance')}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="minBalance">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="minBalance">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'maxBalance', 'has-error')} required">
        <label class="control-label col-sm-4" for="maxBalance">
            <g:message code="product.maxBalance.label" default="Max Balance" />
        </label>
        <div class="col-sm-8"><g:field name="maxBalance" value="${fieldValue(bean: productInstance, field: 'maxBalance')}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="maxBalance">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="maxBalance">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>    

<div id="term">
    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'minTerm', 'has-error')} required">
        <label class="control-label col-sm-4" for="minTerm">
            <g:message code="product.minTerm.label" default="Min Term" />
        </label>
        <div class="col-sm-8"><g:field name="minTerm" type="number" value="${productInstance.minTerm}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="minTerm">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="minTerm">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'maxTerm', 'has-error')} required">
        <label class="control-label col-sm-4" for="maxTerm">
            <g:message code="product.maxTerm.label" default="Max Term" />
        </label>
        <div class="col-sm-8"><g:field name="maxTerm" type="number" value="${productInstance.maxTerm}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="maxTerm">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="maxTerm">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>

<div id="allow">
    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'allowFdPartialWithrawal', 'has-error')} ">
    	<label class="control-label col-sm-4" for="allowFdPartialWithrawal">
    		<g:message code="product.allowFdPartialWithrawal.label" default="Allow Partial Withrawal (FD)" />
    		
    	</label>
    	<div class="col-sm-8"><g:checkBox name="allowFdPartialWithrawal" class="form-control" value="${productInstance?.allowFdPartialWithrawal}" />

                <g:hasErrors bean="${productInstance}" field="allowFdPartialWithrawal">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="allowFdPartialWithrawal">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'allowFdMultiplePlacement', 'has-error')} ">
    	<label class="control-label col-sm-4" for="allowFdMultiplePlacement">
    		<g:message code="product.allowFdMultiplePlacement.label" default="Allow Multiple Placement (FD)" />
    		
    	</label>
    	<div class="col-sm-8"><g:checkBox name="allowFdMultiplePlacement" class="form-control" value="${productInstance?.allowFdMultiplePlacement}" />

                <g:hasErrors bean="${productInstance}" field="allowFdMultiplePlacement">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="allowFdMultiplePlacement">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>

<div id="savcur">
    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'depositDormancyMonths', 'has-error')} ">
    	<label class="control-label col-sm-4" for="depositDormancyMonths">
    		<g:message code="product.depositDormancyMonths.label" default="Deposit Dormancy Months" />
    		
    	</label>
    	<div class="col-sm-8"><g:field name="depositDormancyMonths" type="number" value="${productInstance.depositDormancyMonths}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="depositDormancyMonths">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="depositDormancyMonths">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'depositDormancyTransferFreq', 'has-error')} ">
    	<label class="control-label col-sm-4" for="depositDormancyTransferFreq">
    		<g:message code="product.depositDormancyTransferFreq.label" default="Deposit Dormancy Transfer Frequency" />
    		
    	</label>
    	<div class="col-sm-8"><g:select id="depositDormancyTransferFreq" name="depositDormancyTransferFreq.id" from="${icbs.lov.DepositAcctDormancyTransferFreq.list()}" optionKey="id" optionValue="description" value="${productInstance?.depositDormancyTransferFreq?.id}" class="many-to-one form-control" noSelection="['null': '']" />

                <g:hasErrors bean="${productInstance}" field="depositDormancyTransferFreq">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="depositDormancyTransferFreq">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'hasDepositDormancyInterest', 'has-error')} ">
    	<label class="control-label col-sm-4" for="hasDepositDormancyInterest">
    		<g:message code="product.hasDepositDormancyInterest.label" default="Has Deposit Dormancy Interest" />
    		
    	</label>
    	<div class="col-sm-8"><g:checkBox name="hasDepositDormancyInterest" class="form-control" value="${productInstance?.hasDepositDormancyInterest}" />

                <g:hasErrors bean="${productInstance}" field="hasDepositDormancyInterest">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="hasDepositDormancyInterest">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'depositDormancyAmt', 'has-error')} ">
    	<label class="control-label col-sm-4" for="depositDormancyAmt">
    		<g:message code="product.depositDormancyAmt.label" default="Deposit Dormancy Amt" />
    		
    	</label>
    	<div class="col-sm-8"><g:field name="depositDormancyAmt" value="${fieldValue(bean: productInstance, field: 'depositDormancyAmt')}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="depositDormancyAmt">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="depositDormancyAmt">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'depositChargeStart', 'has-error')} ">
    	<label class="control-label col-sm-4" for="depositChargeStart">
    		<g:message code="product.depositChargeStart.label" default="Dormancy Charge Start" />
    		
    	</label>
    	<div class="col-sm-8"><g:field name="depositChargeStart" value="${fieldValue(bean: productInstance, field: 'depositChargeStart')}" class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="depositChargeStart">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="depositChargeStart">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div> 

<div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'isMicrofinance', 'has-error')} ">
    <label class="control-label col-sm-4" for="isMicrofinance">
        <g:message code="product.isMicrofinance.label" default="Microfinance (Loans and Savings)" />
        
    </label>
    <div class="col-sm-8"><g:checkBox name="isMicrofinance" class="form-control" value="${productInstance?.isMicrofinance}" />

            <g:hasErrors bean="${productInstance}" field="isMicrofinance">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${productInstance}" field="isMicrofinance">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>   

<div id="temp">
    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'documentTemplate', 'has-error')} ">
    	<label class="control-label col-sm-4" for="documentTemplate">
    		<g:message code="product.documentTemplate.label" default="Document Template" />
    		
    	</label>
    	<div class="col-sm-8"><g:textField name="documentTemplate" value="${productInstance?.documentTemplate}"class="form-control"/>

                <g:hasErrors bean="${productInstance}" field="documentTemplate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="documentTemplate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
</div>    

<div id="loan">

    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'loanProvisionFreq', 'has-error')} required">
    	<label class="control-label col-sm-4" for="loanProvisionFreq">
    		<g:message code="product.loanProvisionFreq.label" default="Loan Provision Freq" />
    	</label>
    	<div class="col-sm-8"><g:select id="loanProvisionFreq" name="loanProvisionFreq.id" from="${icbs.lov.LoanFreq.list()}" optionKey="id" optionValue="description" value="${productInstance?.loanProvisionFreq?.id}" class="many-to-one form-control" noSelection="['null': '']" />

                <g:hasErrors bean="${productInstance}" field="loanProvisionFreq">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="loanProvisionFreq">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'loanReclassFreq', 'has-error')} required">
    	<label class="control-label col-sm-4" for="loanReclassFreq">
    		<g:message code="product.loanReclassFreq.label" default="Loan Re-Class Frequency" />
    	</label>
    	<div class="col-sm-8"><g:select id="loanReclassFreq" name="loanReclassFreq.id" from="${icbs.lov.LoanFreq.list()}" optionKey="id" optionValue="description" value="${productInstance?.loanReclassFreq?.id}" class="many-to-one form-control" noSelection="['null': '']" />

                <g:hasErrors bean="${productInstance}" field="loanReclassFreq">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="loanReclassFreq">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>


    <div class="fieldcontain form-group ${hasErrors(bean: productInstance, field: 'loanUidTransferFreq', 'has-error')} required">
    	<label class="control-label col-sm-4" for="loanUidTransferFreq">
    		<g:message code="product.loanUidTransferFreq.label" default="Loan UID Transfer Frequency" />
    	</label>
    	<div class="col-sm-8"><g:select id="loanUidTransferFreq" name="loanUidTransferFreq.id" from="${icbs.lov.LoanFreq.list()}" optionKey="id" optionValue="description" value="${productInstance?.loanUidTransferFreq?.id}" class="many-to-one form-control" noSelection="['null': '']" />

                <g:hasErrors bean="${productInstance}" field="loanUidTransferFreq">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${productInstance}" field="loanUidTransferFreq">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>

</div>


<g:hiddenField name="configItemStatus" value="2" />


<script type="text/javascript">
    $(document).ready(function() {

        hide_all();

        function hide_all() {
            $("#bal").hide();
            $("#term").hide();
            $("#allow").hide();
            $("#savcur").hide();
            $("#temp").hide();
            $("#loan").hide();
        }
        
        $("#productType").change(function() {
            var val = $(this).val();

            if(val == 1) { // Savings
                hide_all();
                $("#bal").show();
                $("#savcur").show();
                $("#temp").show();
            }

            if(val == 2) { // Current
                hide_all();
                $("#bal").show();
                $("#savcur").show();
                $("#temp").show();
            }
            
            if(val == 3) { // Time
                hide_all();
                $("#bal").show();
                $("#term").show();
                $("#allow").show();
                $("#temp").show();
            }

            if(val == 4 || val == 5) { // Bills
                hide_all();
                $("#term").show();
                $("#allow").show();
            }

            if(val == 6) { // Loan
                hide_all();
                $("#loan").show();
                $("#term").show();
            }

            if(val == 7 || val == 8) { // Receivable
                hide_all();
            }
        });
    });
</script>

