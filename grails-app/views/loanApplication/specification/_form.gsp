<%@ page import="icbs.lov.ProductType" %>
<%@ page import="icbs.loans.LoanApplication" %>
<%@ page import="icbs.cif.Customer" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>

<legend>Loan Specification</legend>

<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'customer', 'has-error')}">
	<label class="control-label col-sm-4" for="customer">
		<g:message code="loanApplication.customer.label" default="Customer ID" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="customer-name" value="${loanApplicationInstance?.customer?.displayName}" class="form-control" readonly="true"/>
    <g:hiddenField id="customer" name="customer.id" value="${loanApplicationInstance?.customer?.id}" />
    <%--<g:select id="customer" name="customer.id" from="${icbs.cif.Customer.list()}" optionKey="id" optionValue="displayName" value="${loanApplicationInstance?.customer?.id}" class="many-to-one form-control"  noSelection="[null: 'Select Name']" onchange="updateCustomerInfoAjax(this.value)" />--%>
        <g:hasErrors bean="${loanApplicationInstance}" field="customer">
            <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
        </g:hasErrors>
    </div> 


    
    

    <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showCustomerSearch()" value="Search"/></div>
</div>
</br>

<div class="col-xs-10 col-sm-11">
    <div class="section-container">
        <fieldset>
            <legend class="section-header">Customer Information</legend>
        

            <table class="table table-bordered table-striped">
                <tbody>
                    <tr>
                        <td style="font-weight:bold" width="30%">Date of Birth</td>
                        <td width="70%"><span id="birth-date"></span></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Address</td>
                        <td width="70%"><span id="address"></span></span></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Photo</td>
                        <td width="70%"><span id="photo"></span></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Total Released</td>
                        <td width="70%"><span id="total-released"></span></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Total Outstanding Principal Balance</td>
                        <td width="70%"><span id="total-balance"></span></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Number of Outstanding Loans</td>
                        <td width="70%"><span id="total-count"></span></td>
                    </tr>           
                </tbody>
            </table>
        </fieldset>    
    </div>
</div>   
<div class="fieldcontain form-group">
    <label align = "left"><h5><b>Loan Recommendation Package *</b></h5></label>
    
                    
</div>
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'product', 'has-error')}">
	<label class="control-label col-sm-4" for="product">
		<g:message code="loanApplication.product.label" default="Product" />
	</label>
	<div class="col-sm-8"><g:select id="product" name="product.id" from="${icbs.admin.Product.findAllWhere(productType:ProductType.get(6),configItemStatus:ConfigItemStatus.get(2))}" optionKey="id" optionValue="name" value="${loanApplicationInstance?.product?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="product">
              <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>

<%--<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'branch', 'has-error')}">
	<label class="control-label col-sm-4" for="branch">
		<g:message code="loanApplication.branch.label" default="Branch" />
	</label>
	<div class="col-sm-8"><g:select id="branch" name="branch.id" from="${icbs.admin.Branch.findAll{status.id == 2}}" optionKey="id" optionValue="name" value="${loanApplicationInstance?.branch?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="branch">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanApplicationInstance}" field="branch">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'currency', 'has-error')}">
	<label class="control-label col-sm-4" for="currency">
		<g:message code="loanApplication.currency.label" default="Currency" />
	</label>
	<div class="col-sm-8"><g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" value="${loanApplicationInstance?.currency?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanApplicationInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>--%>

<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'amount', 'has-error')} required">
	<label class="control-label col-sm-4" for="amount">
		<g:message code="loanApplication.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="amount" value="${fieldValue(bean: loanApplicationInstance, field: 'amount')}" class="form-control truncated"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="amount">
                <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>
<!-- interest rate -->
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'intrestRate', 'has-error')} required">
	<label class="control-label col-sm-4" for="amount">
		<g:message code="loanApplication.amount.label" default="Interest Rate" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field id="intrestRate" name="intrestRate" class="form-control" value="${loanApplicationSpecAdd?.interestRate}"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="intrestRate">
                
            </g:hasErrors>
        </div>             
</div>
<!-- Service Charge -->
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'serviceCharge', 'has-error')} required">
	<label class="control-label col-sm-4" for="amount">
		<g:message code="loanApplication.amount.label" default="Service Charge" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field id="serviceCharge" name="serviceCharge" value="${loanApplicationSpecAdd?.serviceCharge}" class="form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="serviceCharge">
                
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'term', 'has-error')} required">
	<label class="control-label col-sm-4" for="term">
		<g:message code="loanApplication.term.label" default="Term" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="term" type="number" value="${loanApplicationInstance.term}" class="form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="term">
               <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>
<!-- repayment frequency -->
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'product', 'has-error')}">
	<label class="control-label col-sm-4" for="product">
		<g:message code="loanApplication.product.label" default="Repayment Frequency" />
	</label>
	<div class="col-sm-8"><g:select id="frequency" name="frequency" from="${icbs.lov.LoanInstallmentFreq.findAllWhere(status: true)}" optionKey="id" optionValue="description" value="${loanApplicationSpecAdd?.frequency?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="frequency">
              <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group">
    <label align = "left"><h5><b>Other Terms:</b></h5></label>                 
</div>
<!-- repayment frequency -->
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'guaranteeFacility', 'has-error')}">
	<label class="control-label col-sm-4" for="product">
		<g:message code="loanApplication.product.label" default="Guarantee Facility" />
	</label>
	<div class="col-sm-8"><g:select id="guaranteeFacility" name="guaranteeFacility" from="${icbs.lov.LoanGuaranteeFacility.findAllWhere(status: true)}" optionKey="id" optionValue="description" value="${loanApplicationSpecAdd?.guaranteeFacility?.id}" class="many-to-one form-control"/>

        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'preRelease', 'has-error')} required">
	<label class="control-label col-sm-4" for="purpose">
		<g:message code="loanApplication.purpose.label" default="Pre-Release" />
		
	</label>
	<div class="col-sm-8"><g:textArea id="preRelease" name="preRelease"  rows="3" value="${loanApplicationSpecAdd?.preRelease}" class="form-control"/>

        </div>             
</div>

<div class="fieldcontain form-group">
    <label align = "left"><h5><b>Other Information:</b></h5></label>                 
</div>
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'accountOfficer', 'has-error')} required">
    <label class="control-label col-sm-4" for="accountOfficer">
        <g:message code="loanApplication.accountOfficer.label" default="Account Officer" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="accountOfficer" value="${loanApplicationInstance?.accountOfficer}" class="form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="accountOfficer">
               <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'purpose', 'has-error')} required">
	<label class="control-label col-sm-4" for="purpose">
		<g:message code="loanApplication.purpose.label" default="Purpose" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textArea name="purpose" value="${loanApplicationInstance?.purpose}" rows="3" class="form-control"/>

            <g:hasErrors bean="${loanApplicationInstance}" field="purpose">
               <script>
                    $(function
                        var x = '${it}';
                        notify.error(x);
                       // console.log(x)
                       // setTimeout(function(){ notify.success(x); }, 3000);
                    });
                </script>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'comments', 'has-error')} required">
	<label class="control-label col-sm-4" for="purpose">
		<g:message code="loanApplication.purpose.label" default="Comments" />
		
	</label>
	<div class="col-sm-8"><g:textArea id="comments" name="comments"  value="${loanApplicationSpecAdd?.comments}" rows="3" class="form-control"/>

        </div>             
</div>






<!-- hide application Date
<div class="fieldcontain form-group ${hasErrors(bean: loanApplicationInstance, field: 'applicationDate', 'has-error')}">
	<label class="control-label col-sm-4" for="applicationDate">
		<g:message code="loanApplication.applicationDate.label" default=" " />
		
	</label>
    <div class="col-sm-8"><g:customDatePicker  name="applicationDate" precision="day" class="form-control" value="${loanApplicationInstance?.applicationDate}" />

        <g:hasErrors bean="${loanApplicationInstance}" field="applicationDate">
            <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${loanApplicationInstance}" field="applicationDate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
            </div>

        </g:hasErrors>
    </div>             
</div> -->