<%@ page import="accounting.fixedasset.Bankasset" %>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'assetcode', 'has-error')} ">
	<label class="control-label col-sm-4" for="assetcode">
		<g:message code="bankasset.assetcode.label" default="Asset Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="assetcode" value="${fieldValue(bean: bankassetInstance, field: 'assetcode')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="assetcode">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="assetcode">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<!-- <div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'glacc', 'has-error')} ">
    <label class="control-label col-sm-4" for="glacc">
        <g:message code="bankasset.glacc.label" default="Asset Account" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="glacc" value="${fieldValue(bean: bankassetInstance, field: 'glacc')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="glacc">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="glacc">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> -->

<!-- <div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'creditglacc', 'has-error')} ">
    <label class="control-label col-sm-4" for="creditglacc">
        <g:message code="bankasset.creditglacc.label" default="Credit Account" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="creditglacc" value="${fieldValue(bean: bankassetInstance, field: 'creditglacc')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="creditglacc">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="creditglacc">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> -->

<!-- <div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'ebitglacc', 'has-error')} ">
    <label class="control-label col-sm-4" for="ebitglacc">
        <g:message code="bankasset.ebitglacc.label" default="Debit Account" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="ebitglacc" value="${fieldValue(bean: bankassetInstance, field: 'ebitglacc')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="ebitglacc">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="ebitglacc">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> -->

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'assetdesc', 'has-error')} ">
	<label class="control-label col-sm-4" for="assetdesc">
		<g:message code="bankasset.assetdesc.label" default="Asset Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="assetdesc" value="${fieldValue(bean: bankassetInstance, field: 'assetdesc')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="assetdesc">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="assetdesc">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'assetpo', 'has-error')} ">
    <label class="control-label col-sm-4" for="assetpo">
        <g:message code="bankasset.assetpo.label" default="PO Number" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="assetpo" value="${fieldValue(bean: bankassetInstance, field: 'assetpo')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="assetpo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="assetpo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'assetserial', 'has-error')} ">
    <label class="control-label col-sm-4" for="assetserial">
        <g:message code="bankasset.assetserial.label" default="Asset Serial" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="assetserial" value="${fieldValue(bean: bankassetInstance, field: 'assetserial')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="assetserial">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="assetserial">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<!-- <div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'vendorlink', 'has-error')} ">
    <label class="control-label col-sm-4" for="vendorlink">
        <g:message code="bankasset.vendorlink.label" default="Vendor" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="vendorlink" value="${fieldValue(bean: bankassetInstance, field: 'vendorlink')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="vendorlink">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="vendorlink">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div> -->


<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'purdate', 'has-error')} ">
    <label class="control-label col-sm-4" for="purdate">
        <g:message code="bankasset.purdate.label" default="Purchase Date" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="purdate" value="${fieldValue(bean: bankassetInstance, field: 'purdate')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="purdate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="purdate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'purcost', 'has-error')} ">
	<label class="control-label col-sm-4" for="purcost">
		<g:message code="bankasset.purcost.label" default="Purchase Cost" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="purcost" value="${fieldValue(bean: bankassetInstance, field: 'purcost')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="purcost">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="purcost">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'isnew', 'has-error')} ">
    <label class="control-label col-sm-4" for="isnew">
        <g:message code="bankasset.isnew.label" default="Is New" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="isnew" value="${fieldValue(bean: bankassetInstance, field: 'isnew')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="isnew">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="isnew">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'salvagevalue', 'has-error')} ">
    <label class="control-label col-sm-4" for="salvagevalue">
        <g:message code="bankasset.salvagevalue.label" default="Salvage Value" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="salvagevalue" value="${fieldValue(bean: bankassetInstance, field: 'salvagevalue')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="salvagevalue">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="salvagevalue">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'lifeinyears', 'has-error')} ">
    <label class="control-label col-sm-4" for="lifeinyears">
        <g:message code="bankasset.lifeinyears.label" default="Life in Years" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="lifeinyears" value="${fieldValue(bean: bankassetInstance, field: 'lifeinyears')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="lifeinyears">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="lifeinyears">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'deprevalue', 'has-error')} ">
    <label class="control-label col-sm-4" for="deprevalue">
        <g:message code="bankasset.deprevalue.label" default="Depreciation Value" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="deprevalue" value="${fieldValue(bean: bankassetInstance, field: 'deprevalue')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="deprevalue">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="deprevalue">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'annualexpense', 'has-error')} ">
    <label class="control-label col-sm-4" for="annualexpense">
        <g:message code="bankasset.annualexpense.label" default="Annual Depreciation" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="annualexpense" value="${fieldValue(bean: bankassetInstance, field: 'annualexpense')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="annualexpense">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="annualexpense">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: bankassetInstance, field: 'monthlyexpense', 'has-error')} ">
    <label class="control-label col-sm-4" for="monthlyexpense">
        <g:message code="bankasset.monthlyexpense.label" default="Monthly Depreciation" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:field name="monthlyexpense" value="${fieldValue(bean: bankassetInstance, field: 'monthlyexpense')}" class="form-control"/>

            <g:hasErrors bean="${bankassetInstance}" field="monthlyexpense">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${bankassetInstance}" field="monthlyexpense">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<!-- <div><g:hiddenField name="configItemStatus" value="2" /></div>
<div><g:hiddenField name="date" value="${new Date()}" /></div> -->