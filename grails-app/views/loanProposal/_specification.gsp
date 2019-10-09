<%@ page import="icbs.lov.LoanInstallmentFreq" %>
<%@ page import="icbs.cif.Customer" %>
<%@ page import="icbs.loans.InterestIncomeScheme" %>
<%@ page import="icbs.loans.LoanApplication" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>

<legend>Specification</legend>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="product">
        Interest Income Scheme
    </label>
    <div class="col-sm-8">
        <g:select name="interestIncomeScheme" from="${InterestIncomeScheme.findAllByStatus(ConfigItemStatus.get(2))}" optionKey="id" optionValue="name" value="" class="many-to-one form-control" onchange="updateForm()"/>
    </div>
</div>

<div id="amount-form-group"  class="fieldcontain form-group">
	<label class="control-label col-sm-4" for="amount">
		Amount <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
        <g:field name="amount" value="" required="" class="form-control truncated" onkeyup="updateInstallmentAmount()"/>
    </div>
</div>

<div id="interest-rate-form-group" class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="interestRate">
        Interest Rate (%) <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="interestRate" value="" required="" class="form-control" onchange="updateInstallmentAmount()"/>
    </div>
</div>

<div id="term-form-group" class="fieldcontain form-group" style="display: none">
	<label class="control-label col-sm-4" for="term">
		Term <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
        <g:field name="term" type="number" value="" required="" class="form-control"/>
    </div>
</div>

<div id="frequency-form-group" class="fieldcontain form-group" style="display: none">
    <label class="control-label col-sm-4" for="frequency">
        Frequency <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:select name="frequency" from="${LoanInstallmentFreq.list()}" optionKey="id" optionValue="description" value="" class="many-to-one form-control" onchange="updateInstallmentAmount()" />
    </div>
</div>

<div id="num-installments-form-group" class="fieldcontain form-group" style="display: none">
    <label class="control-label col-sm-4" for="numInstallments">
        No. of Installments <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="numInstallments" type="number" value="" required="" class="form-control" onkeyup="updateInstallmentAmount()"/>
    </div>
</div>

<div id="installment-amount-form-group" class="fieldcontain form-group" style="display: none">
    <label class="control-label col-sm-4" for="installmentAmount">
        Amount per Installment
    </label>
    <div class="col-sm-8">
        <g:field name="installmentAmount" value="" required="" class="form-control"/>
    </div>
</div>

<div id="balloon-installments-form-group" class="fieldcontain form-group" style="display: none">
    <label class="control-label col-sm-4" for="balloonInstallments">
        Balloon Installments
    </label>
    <div class="col-sm-8">
        <g:field name="balloonInstallments" type="number" value="" required="" class="form-control"/>
    </div>
</div>

<div id="opening-date-form-group" class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="openingDate">
        Opening Date <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:customDatePicker name="openingDate" precision="day" class="form-control" value="" />
    </div>
</div>

<div id="interest-start-date-form-group" class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="interestStartDate">
        Interest Start Date
    </label>
    <div class="col-sm-8">
        <g:customDatePicker name="interestStartDate" precision="day" class="form-control" value="" />
    </div>
</div>

<div id="first-installment-date-form-group" class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="openingDate">
        First Installment Date 
    </label>
    <div class="col-sm-8">
        <g:customDatePicker name="firstInstallmentDate" precision="day" class="form-control" value="" />
    </div>
</div>

<br /><br />
<div id="manual-form-group" class="multi-field" style="display: none">
    <legend>Installment Schedule</legend>

    <div class="container multi-field-item multi-field-template" data-multi-field-max="100" data-multi-field-preload="true">
        <div class="row">
            <div class="col-md-3">
                <div class="installment-date-group form-group">
                    <label for="installmentDate" class="control-label col-md-2" style="white-space: nowrap">Date *</label>
                    <div class="col-md-8">
                        <g:customDatePicker name="installmentDate" precision="day" class="form-control"/>
                        <div><span class="help-block"></span></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="principal-amount-group form-group">
                    <label for="principalAmount" class="control-label col-md-2" style="white-space: nowrap">Principal *</label>
                    <div class="col-md-8">
                        <g:field name="principalAmount" class="form-control" value="" />
                        <div><span class="help-block"></span></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="interest-amount-group form-group">
                    <label for="interestAmount" class="control-label col-md-2" style="white-space: nowrap">Interest *</label>
                    <div class="col-md-8">
                        <g:field name="interestAmount" class="form-control" value="" />
                        <div><span class="help-block"></span></div>
                    </div>
                </div>
            </div>            
            <div class="col-md-2">
                <div class="form-group"><button type="button" class="btn btn-danger multi-field-btn-delete"><span class="fa fa-minus"></span> Remove</button></div>
            </div>
        </div>
        <br/>
    </div>

    <div class="form-group form-buttons">
        <button type="button" class="btn btn-primary multi-field-btn-add" ><span class="fa fa-plus"></span> Add more</button>
    </div>
</div>
