<%@ page import="icbs.loans.Loan" %>
<%@ page import="icbs.lov.ProductType" %>
<%@ page import="icbs.admin.Branch" %>
<%@ page import="icbs.admin.Institution" %>


<legend>Loan Specification</legend>

<%--<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'customer', 'has-error')}">
    <label class="control-label col-sm-4" for="customer">
        <g:message code="loanApplication.customer.label" default="Customer" />
    </label>
    <div class="col-sm-8">
        <g:field name="customer-name" value="${loanInstance?.customer?.displayName}" class="form-control" readonly="true"/>
        <g:hiddenField id="customer" name="customer.id" value="${loanInstance?.customer?.id}" />
    
        <g:hasErrors bean="${loanInstance}" field="customer">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="customer">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>--%>

<g:hiddenField id="customer" name="customer.id" value="${loanInstance?.customer?.id}" />
  <g:if test="${Institution.get(65).paramValue == 'TRUE'}">
<div class="form-group fieldcontain ${hasErrors(bean: loanInstance, field: 'pnNo', 'has-error')}">
    <label class="control-label col-sm-4" for="pnNo">
        <g:message code="loanInstance.pnNo.label" default="PN No." />
    </label>
    <div class="col-sm-8">
        <g:textField class="form-control" name="pnNo" maxlength="10" value="${loanInstance?.pnNo}"/>
        <g:hasErrors bean="${loanInstance}" field="pnNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="pnNo">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>
 </g:if>
<g:else>
    <div class="form-group fieldcontain ${hasErrors(bean: loanInstance, field: 'pnNo', 'has-error')}">
    <label class="control-label col-sm-4" for="pnNo">
        <g:message code="loanInstance.pnNo.label" default="PN No." />
    </label>
    <div class="col-sm-8">
        <g:textField disabled="disable" class="form-control" name="pnNo" maxlength="10" value="${loanInstance?.pnNo}"/>
        <g:hasErrors bean="${loanInstance}" field="pnNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="pnNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>
</g:else>
<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'product', 'has-error')} required">
    <label class="control-label col-sm-4" for="product">
        <g:message code="loan.product.label" default="Product" />
    </label>
    <div class="col-sm-8">
        <%--<g:select id="product" name="product.id" from="${icbs.admin.Product.findAllWhere(productType:ProductType.get(6))}" optionKey="id" optionValue="name" value="${loanInstance?.product?.id}" class="many-to-one form-control" onchange="updateSchemes()"/>--%>
        <g:if test="${module == 'loanROPA'}">
        <g:select id="product" name="product.id" from="${icbs.admin.Product.findAllWhere(productType:ProductType.get(7))}" optionKey="id" optionValue="name" value="${loanInstance?.product?.id}" class="many-to-one form-control" onchange="updateSchemes()"/>
        </g:if>
        <g:else>
        <g:field name="product-name" value="${loanInstance?.product?.name}" class="form-control" readonly="true"/>
        </g:else>        
        <g:hiddenField id="product" name="product.id" value="${loanInstance?.product?.id}" />

        <g:hasErrors bean="${loanInstance}" field="product">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="product">
                        <g:message error="${it?.code}" /><br/>    
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="amount-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'grantedAmount', 'has-error')} required">
    <label class="control-label col-sm-4" for="grantedAmount">
        <g:message code="loan.grantedAmount.label" default="Granted Amount" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:if test="${writeOff}">
            <g:field name="grantedAmount" value="${loanInstance?.loanApplication?.collaterals.size() > 0 ? 0 : 1}" class="form-control truncated" onkeyup="updateInstallmentAmount()" readonly="true" />
        </g:if>
        <g:else>
            <g:field name="grantedAmount" value="${fieldValue(bean: loanInstance, field: 'grantedAmount')}" class="form-control truncated" onkeyup="updateInstallmentAmount()" readonly="${reschedule ? 'true' : 'false'}" />
        </g:else>

        <g:hasErrors bean="${loanInstance}" field="grantedAmount">
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
<div id="amount-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'balanceAmount', 'has-error')} required">
    <label class="control-label col-sm-4" for="balanceAmount">
        <g:message code="loan.balanceAmount.label" default="Balance Amount" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="balanceAmount" value="${fieldValue(bean: loanInstance, field: 'balanceAmount')}" class="form-control truncated" readonly="true"/>

        <g:hasErrors bean="${loanInstance}" field="balanceAmount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="balanceAmount">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>    
<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'ownershipType', 'has-error')} required">
    <label class="control-label col-sm-4" for="ownershipType">
        <g:message code="loan.ownershipType.label" default="Ownership Type" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:select id="ownershipType" name="ownershipType.id" from="${icbs.lov.OwnershipType.findAll{id == 1 || id == 2}}" optionKey="id" optionValue="description" value="${loanInstance?.ownershipType?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="ownershipType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="ownershipType">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<%--<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'numberOfOwners', 'has-error')} required">
    <label class="control-label col-sm-4" for="numberOfOwners">
        <g:message code="loan.numberOfOwners.label" default="No. Of Owners" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="numberOfOwners" type="number" value="${loanInstance?.numberOfOwners}"  class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="numberOfOwners">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="numberOfOwners">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>--%>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'interestIncomeScheme', 'has-error')} required">
    <label class="control-label col-sm-4" for="interestIncomeScheme">
        <g:message code="loan.interestIncomeScheme.label" default="Interest Income Scheme" />        
    </label>
    <div id="interest-income-scheme" class="col-sm-8">            

        <%--<g:hasErrors bean="${loanInstance}" field="interestIncomeScheme">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="interestIncomeScheme">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>--%>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'currentPenaltyScheme', 'has-error')} required">
    <label class="control-label col-sm-4" for="currentPenaltyScheme">
        <g:message code="loan.currentPenaltyScheme.label" default="Current Penalty Scheme" />
    </label>
    <div id="current-penalty-scheme" class="col-sm-8">
        
        <%--<g:hasErrors bean="${loanInstance}" field="currentPenaltyScheme">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="currentPenaltyScheme">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>--%>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'pastDuePenaltyScheme', 'has-error')} required">
    <label class="control-label col-sm-4" for="pastDuePenaltyScheme">
        <g:message code="loan.pastDuePenaltyScheme.label" default="Past Due Penalty Scheme" />
    </label>
    <div id="past-due-penalty-scheme" class="col-sm-8">
        
        <%--<g:hasErrors bean="${loanInstance}" field="pastDuePenaltyScheme">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="pastDuePenaltyScheme">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>--%>
    </div>             
</div>

<%--<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'amortizedChargeScheme', 'has-error')} required">
    <label class="control-label col-sm-4" for="amortizedChargeScheme">
        <g:message code="loan.amortizedChargeScheme.label" default="Amortized Charge Scheme" />
    </label>
    <div id="amortized-charge-scheme" class="col-sm-8">    
    </div>             
</div>--%>

<%--<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'performanceClassificationScheme1', 'has-error')} required">
    <label class="control-label col-sm-4" for="performanceClassificationScheme1">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 1" />
    </label>
    <div id="performance-classification-scheme1" class="col-sm-8">    
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'performanceClassificationScheme2', 'has-error')} required">
    <label class="control-label col-sm-4" for="performanceClassificationScheme2">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 2" />
    </label>
    <div id="performance-classification-scheme2" class="col-sm-8">
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'performanceClassificationScheme3', 'has-error')} required">
    <label class="control-label col-sm-4" for="performanceClassificationScheme3">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 3" />
    </label>
    <div id="performance-classification-scheme3" class="col-sm-8">    
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'performanceClassificationScheme4', 'has-error')} required">
    <label class="control-label col-sm-4" for="performanceClassificationScheme4">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 4" />
    </label>
    <div id="performance-classification-scheme4" class="col-sm-8">    
    </div>             
</div>--%>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'interestRate', 'has-error')} required">
    <label class="control-label col-sm-4" for="interestRate">
        <g:message code="loan.interestRate.label" default="Interest Rate  (%) " />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="interestRate" value="${fieldValue(bean: loanInstance, field: 'interestRate')}" onchange="int()" />
        <g:hasErrors bean="${loanInstance}" field="interestRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="interestRate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="penalty-amount-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'penaltyAmount', 'has-error')} required">
    <label class="control-label col-sm-4" for="penaltyAmount">
        <g:message code="loan.penaltyAmount.label" default="Penalty Amount" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="penaltyAmount" value="${fieldValue(bean: loanInstance, field: 'penaltyAmount')}" class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="penaltyAmount">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="penaltyAmount">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="penalty-rate-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'penaltyRate', 'has-error')} required">
    <label class="control-label col-sm-4" for="penaltyRate">
        <g:message code="loan.penaltyRate.label" default="Penalty Rate (%) " />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="penaltyRate" value="${fieldValue(bean: loanInstance, field: 'penaltyRate')}" class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="penaltyRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="penaltyRate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<%--<div id="service-charge-amount-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'serviceCharge', 'has-error')} required">
    <label class="control-label col-sm-4" for="serviceCharge">
        <g:message code="loan.serviceCharge.label" default="Service Charge Amount" />
    </label>
    <div class="col-sm-8">
        <g:field name="serviceCharge" value="${fieldValue(bean: loanInstance, field: 'serviceCharge')}" class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="serviceCharge">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="serviceCharge">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="service-charge-rate-form-group" class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="serviceChargeRate">
        Service Charge Rate (%)
    </label>
    <div class="col-sm-8">
        <g:field name="serviceChargeRate" value="" class="form-control" readonly="true"/>
    </div>             
</div>--%>

<div id="term-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'term', 'has-error')} required">
    <label class="control-label col-sm-4" for="term">
        <g:message code="loan.term.label" default="Term" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="term" type="number" value="${loanInstance?.term}" class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="term">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="term">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="frequency-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'frequency', 'has-error')} required">
    <label class="control-label col-sm-4" for="frequency">
        <g:message code="loan.frequency.label" default="Frequency" />
    </label>
    <div class="col-sm-8">
        <g:select id="frequency" name="frequency.id" from="${icbs.lov.LoanInstallmentFreq.list()}" optionKey="id" optionValue="description" value="${loanInstance?.frequency?.id}" class="many-to-one form-control" onchange="updateInstallmentAmount()"/>

        <g:hasErrors bean="${loanInstance}" field="frequency">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="frequency">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="num-installments-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'numInstallments', 'has-error')} required">
    <label class="control-label col-sm-4" for="numInstallments">
        <g:message code="loan.numInstallments.label" default="No. of Installments" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="numInstallments" value="${loanInstance?.numInstallments}" onkeyup="inst()" onchange="updateInstallmentAmount()" />
        <g:hasErrors bean="${loanInstance}" field="numInstallments">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="numInstallments">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="installment-amount-form-group" class="fieldcontain form-group" style="display: none">
    <label class="control-label col-sm-4" for="installmentAmount">
        Amount per Installment
    </label>
    <div class="col-sm-8">
        <g:field name="installmentAmount" value=""  class="form-control"/>
    </div>             
</div>

<div id="balloon-installments-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'balloonInstallments', 'has-error')} required">
    <label class="control-label col-sm-4" for="balloonInstallments">
        <g:message code="loan.balloonInstallments.label" default="Balloon Installments" />
    </label>
    <div class="col-sm-8">
        <g:field name="balloonInstallments" type="number" value="${loanInstance?.balloonInstallments}"  class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="balloonInstallments">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="balloonInstallments">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="adv-interest-periods-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'advInterestPeriods', 'has-error')} required">
    <label class="control-label col-sm-4" for="advInterestPeriods">
        <g:message code="loan.advInterestPeriods.label" default="No. of Periods w/ Advanced Interest" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="advInterestPeriods" type="number" value="${loanInstance?.advInterestPeriods}" class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="advInterestPeriods">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="advInterestPeriods">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="adv-interest-days-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'advInterestDays', 'has-error')} required">
    <label class="control-label col-sm-4" for="advInterestDays">
        <g:message code="loan.advInterestDays.label" default="No. of Days w/ Advanced Interest" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="advInterestDays" type="number" value="${loanInstance?.advInterestDays}" class="form-control"/>

        <g:hasErrors bean="${loanInstance}" field="advInterestDays">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="advInterestDays">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

  <!-- hide opening date and processing date ,, processing date = application date in loan domain
<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'applicationDate', 'has-error')} required">
    <label class="control-label col-sm-4" for="applicationDate">
        <g:message code="loan.applicationDate.label" default="Application Date" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:customDatePicker   name="applicationDate"   precision="day" class="form-control" default="${loanInstance?.applicationDate}" value="${loanInstance?.applicationDate}"  />

        <g:hasErrors bean="${loanInstance}" field="applicationDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="applicationDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>  
 -->
      
<div id="interest-start-date-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'interestStartDate', 'has-error')} required">
    <label class="control-label col-sm-4" for="interestStartDate">
        <g:message code="loan.interestStartDate.label" default="Interest Start Date" />
    </label>
    <div class="col-sm-8">
        
        <g:if test="${loanInstance.interestStartDate == null}">
        <g:customDatePicker name="interestStartDate" precision="day" class="form-control" value="${Branch?.get(1).runDate}"  />
        </g:if>
        <g:else>
        <g:customDatePicker name="interestStartDate" precision="day" class="form-control" value="${loanInstance.interestStartDate}"  />   
        </g:else>
        <g:hasErrors bean="${loanInstance}" field="interestStartDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="interestStartDate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div id="first-installment-date-form-group" class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'firstInstallmentDate', 'has-error')} required">
    <label class="control-label col-sm-4" for="firstInstallmentDate">
        <g:message code="loan.firstInstallmentDate.label" default="First Installment Date" />
    </label>
    <div class="col-sm-8">
        <g:customDatePicker name="firstInstallmentDate" precision="day" class="form-control" value="${loanInstance?.firstInstallmentDate}"  />

        <g:hasErrors bean="${loanInstance}" field="firstInstallmentDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="firstInstallmentDate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<g:hiddenField id="module" name="module" value="${module}" />

<%--<br /><br />
<div id="manual-form-group" class="multi-field" style="display: none">
<legend>Installment Schedule</legend>

<g:if test="${params?.installmentDate?.size() ?: 0 > 0}">
    <g:each in="${0..params.installmentDate.size()-1}" var="i">
        <g:if test="${!(params?.installmentDate[i].trim() == '' && params?.principalAmount[i].trim() == '')}">
        <div class="form-inline multi-field-item" data-multi-field-max="100" data-multi-field-preload="false">
            <div class="installment-date form-group">
                <label for="installmentDate" class="control-label col-sm-3">Date</label>
                <div class="installment-date col-sm-9">
                    <g:customDatePicker name="installmentDate" precision="day" class="form-control" value="" type="text" default="none" value="${params?.installmentDate[i] ? new Date()?.parse("MM/dd/yyyy", params?.installmentDate[i]) : ""}" noSelection="['': '']" />
                </div>
            </div>
            <div class="principal-amount form-group">
                <label for="principalAmount" class="control-label col-sm-3">Principal *</label>
                <div class="principal-amount col-sm-9">
                    <g:field class="form-control" name="principalAmount" value="${params?.principalAmount[i]}" />
                </div>
            </div>      
            <div class="form-group form-buttons">
                <button type="button" class="btn btn-danger multi-field-btn-delete"><span class="fa fa-minus"></span> Remove</button>
            </div>
        </div> 
        </g:if>   
    </g:each>   
</g:if>

<g:elseif test="${loanInstance?.interestIncomeScheme?.installmentCalcType?.id == 6}">
    <g:set var="loanInstallments" value="${loanInstance?.loanInstallments?.sort{it.sequenceNo}}" />
    <g:each in="${loanInstallments}" var="loanInstallment">
        <div class="form-inline multi-field-item" data-multi-field-max="100" data-multi-field-preload="false">
            <div class="installment-date form-group">
                <label for="installmentDate" class="control-label col-sm-3">Date *</label>
                <div class="installment-date col-sm-9">
                    <g:customDatePicker name="installmentDate" precision="day" class="form-control" value="" type="text" default="none" value="${loanInstallment?.date}" noSelection="['': '']" />
                </div>
            </div>
            <div class="principal-amount form-group">
                <label for="principalAmount" class="control-label col-sm-3">Principal *</label>
                <div class="principal-amount col-sm-9">
                    <g:field class="form-control" name="principalAmount" value="${loanInstallment?.principalInstallmentAmount}" />
                </div>
            </div>      
            <div class="form-group form-buttons">
                <button type="button" class="btn btn-danger multi-field-btn-delete"><span class="fa fa-minus"></span> Remove</button>
            </div>
        </div> 
    </g:each>
</g:elseif>
    
    <div class="form-inline multi-field-item multi-field-template" data-multi-field-max="100" data-multi-field-preload="true">
        <div class="installment-date form-group">
            <label for="installmentDate" class="control-label col-sm-3">Date *</label>
            <div class="installment-date col-sm-9">
                <g:customDatePicker name="installmentDate" precision="day" class="form-control" value="" type="text" default="none" noSelection="['': '']" />
            </div>
        </div>
        <div class="principal-amount form-group">
            <label for="principalAmount" class="control-label col-sm-3">Principal *</label>
            <div class="principal-amount col-sm-9">
                <g:field class="form-control" name="principalAmount" value="" />
            </div>
        </div>      
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-danger multi-field-btn-delete"><span class="fa fa-minus"></span> Remove</button>
        </div>
    </div>     

    <div class="form-group form-buttons">
        <button type="button" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add more</button>
    </div>    
</div>--%>





    