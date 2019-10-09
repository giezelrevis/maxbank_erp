<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Account No.</label>

	<span>${collateralInstance?.pdc?.accountNo}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Check No.</label>

	<span>${collateralInstance?.pdc?.checkNo}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Amount</label>

	<span><g:formatNumber format="###,###,##0.00" number="${collateralInstance?.pdc?.amount}"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Bank</label>

	<span>${collateralInstance?.pdc?.bank}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">On Us</label>

	<span><g:formatBoolean boolean="${collateralInstance?.pdc?.onUs}" /></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">PDC Date</label>

	<span><g:formatDate format="MM/dd/yyyy" date="${collateralInstance?.pdc?.pdcDate}"/></span>
</div>