<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'costsCapitalized', 'has-error')} required">
    <label class="control-label col-sm-4" for="costsCapitalized">Costs Capitalized</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated"  name="costsCapitalized" value="${costsCapitalized}"/>
        <g:hasErrors bean="${ropaInstance}" field="costsCapitalized">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="costsCapitalized">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<g:hiddenField id="ropaId" name="ropaId" value="${params.id}" />
<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'provisionAmt', 'has-error')} required">
    <label class="control-label col-sm-4" for="provisionAmt">Provision Amount</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="provisionAmt" value="${provisionAmt}" />
        <g:hasErrors bean="${ropaInstance}" field="provisionAmt">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="provisionAmt">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'provisionRate', 'has-error')} required">
    <label class="control-label col-sm-4" for="provisionRate">Provision Rate</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated"  name="provisionRate" value="${provisionRate}" />
        <g:hasErrors bean="${ropaInstance}" field="provisionRate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="provisionRate">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'allocatedBookValueLand', 'has-error')} required">
    <label class="control-label col-sm-4" for="allocatedBookValueLand">Allocated Land Book Value</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated"  name="allocatedBookValueLand" value="${allocatedBookValueLand}" />
        <g:hasErrors bean="${ropaInstance}" field="allocatedBookValueLand">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="allocatedBookValueLand">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'allocatedBookValueBuilding', 'has-error')} required">
    <label class="control-label col-sm-4" for="allocatedBookValueBuilding">Allocated Building Book Value</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated"  name="allocatedBookValueBuilding" value="${allocatedBookValueBuilding}" />
        <g:hasErrors bean="${ropaInstance}" field="allocatedBookValueBuilding">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="allocatedBookValueBuilding">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'accumulatedDepreciationBuilding', 'has-error')} required">
    <label class="control-label col-sm-4" for="accumulatedDepreciationBuilding">Accumulated Depreciation Building</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated"  name="accumulatedDepreciationBuilding" value="${accumulatedDepreciationBuilding}" />
        <g:hasErrors bean="${ropaInstance}" field="accumulatedDepreciationBuilding">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="accumulatedDepreciationBuilding">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'allowanceBuilding', 'has-error')} required">
    <label class="control-label col-sm-4" for="allowanceBuilding">Allowance for Prob. losses Building</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="allowanceBuilding" value="${allowanceBuilding}" />
        <g:hasErrors bean="${ropaInstance}" field="allowanceBuilding">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="allowanceBuilding">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'otherCosts', 'has-error')} required">
    <label class="control-label col-sm-4" for="otherCosts">Other Costs</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="otherCosts" value="${otherCosts}" />
        <g:hasErrors bean="${ropaInstance}" field="otherCosts">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="otherCosts">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'allowanceOthers', 'has-error')} required">
    <label class="control-label col-sm-4" for="allowanceOthers">Allowance Other Costs</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="allowanceOthers" value="${allowanceOthers}" />
        <g:hasErrors bean="${ropaInstance}" field="allowanceOthers">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="allowanceOthers">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'formerTitle', 'has-error')} required">
    <label class="control-label col-sm-4" for="formerTitle">Former Title</label>
    <div class="col-sm-8"><g:textField id="formerTitle" name="formerTitle" maxlength="255" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="formerTitle">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="formerTitle">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'kindOfLand', 'has-error')} required">
    <label class="control-label col-sm-4" for="kindOfLand">Kind of Land</label>
    <div class="col-sm-8"><g:textField id="kindOfLand" name="kindOfLand" maxlength="255" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="kindOfLand">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="kindOfLand">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'landArea', 'has-error')} required">
    <label class="control-label col-sm-4" for="landArea">Land Area</label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="landArea" value="${landArea}" />
        <g:hasErrors bean="${ropaInstance}" field="landArea">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="landArea">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'location', 'has-error')} required">
    <label class="control-label col-sm-4" for="location">Location</label>
    <div class="col-sm-8"><g:textField id="location" name="location" maxlength="255" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="location">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="location">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'dateOfCertificate', 'has-error')}">
	<label class="control-label col-sm-4" for="dateOfCertificate">Date of Certificate</label>
    <div class="col-sm-8"><g:customDatePicker name="dateOfCertificate" precision="day" 
    class="form-control" value="${ropaInstance?.dateOfCertificate}" />
        <g:hasErrors bean="${ropaInstance}" field="dateOfCertificate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="dateOfCertificate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'dateOfCertificateRegistration', 'has-error')}">
	<label class="control-label col-sm-4" for="dateOfCertificateRegistration">Date of Certificate Registration</label>
    <div class="col-sm-8"><g:customDatePicker name="dateOfCertificateRegistration" precision="day" 
    class="form-control" value="${ropaInstance?.dateOfCertificateRegistration}" />
        <g:hasErrors bean="${ropaInstance}" field="dateOfCertificateRegistration">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="dateOfCertificateRegistration">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'dateConsolidated', 'has-error')}">
	<label class="control-label col-sm-4" for="dateConsolidated">Date of Consolidation</label>
    <div class="col-sm-8"><g:customDatePicker name="dateConsolidated" precision="day" 
    class="form-control" value="${ropaInstance?.dateConsolidated}" />
        <g:hasErrors bean="${ropaInstance}" field="dateConsolidated">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="dateConsolidated">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'newTct', 'has-error')} required">
    <label class="control-label col-sm-4" for="newTct">New TCT</label>
    <div class="col-sm-8"><g:textField id="newTct" name="newTct" maxlength="255" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="newTct">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="newTct">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'landAppraisal', 'has-error')} required">
    <label class="control-label col-sm-4" for="landAppraisal">Land Appraisal</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="landAppraisal" value="${landAppraisal}" />
        <g:hasErrors bean="${ropaInstance}" field="landAppraisal">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="landAppraisal">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'buildingAppraisal', 'has-error')} required">
    <label class="control-label col-sm-4" for="buildingAppraisal">Building Appraisal</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="buildingAppraisal" value="${buildingAppraisal}" />
        <g:hasErrors bean="${ropaInstance}" field="buildingAppraisal">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="buildingAppraisal">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'otherAppraisal', 'has-error')} required">
    <label class="control-label col-sm-4" for="otherAppraisal">Other Appraisal</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="otherAppraisal" value="${otherAppraisal}" />
        <g:hasErrors bean="${ropaInstance}" field="otherAppraisal">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="otherAppraisal">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'dateOfAppraisal', 'has-error')}">
	<label class="control-label col-sm-4" for="dateOfAppraisal">Date of Appraisal</label>
    <div class="col-sm-8"><g:customDatePicker name="dateOfAppraisal" precision="day" 
    class="form-control" value="${ropaInstance?.dateOfAppraisal}" />
        <g:hasErrors bean="${ropaInstance}" field="dateOfAppraisal">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="dateOfAppraisal">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'appraisedBy', 'has-error')} required">
    <label class="control-label col-sm-4" for="appraisedBy">Appraised By</label>
    <div class="col-sm-8"><g:textField id="appraisedBy" name="appraisedBy" maxlength="100" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="appraisedBy">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="appraisedBy">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'fireInsurancePolicyNo', 'has-error')} required">
    <label class="control-label col-sm-4" for="fireInsurancePolicyNo">Fire Insurance Policy Number</label>
    <div class="col-sm-8"><g:textField id="fireInsurancePolicyNo" name="fireInsurancePolicyNo" maxlength="100" required="" value="" class="form-control"/>
        <g:hasErrors bean="${ropaInstance}" field="fireInsurancePolicyNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="fireInsurancePolicyNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'fireInsuranceAmt', 'has-error')} required">
    <label class="control-label col-sm-4" for="fireInsuranceAmt">Fire Insurance Amount</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="fireInsuranceAmt" value="${fireInsuranceAmt}" />
        <g:hasErrors bean="${ropaInstance}" field="fireInsuranceAmt">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="fireInsuranceAmt">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'fireInsuranceDate', 'has-error')}">
	<label class="control-label col-sm-4" for="fireInsuranceDate">Fire Insurance Date</label>
    <div class="col-sm-8"><g:customDatePicker name="fireInsuranceDate" precision="day" 
    class="form-control" value="${ropaInstance?.fireInsuranceDate}" />
        <g:hasErrors bean="${fireInsuranceDate}" field="fireInsuranceDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="fireInsuranceDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: ropaInstance, field: 'provisionForFireInsurance', 'has-error')} required">
    <label class="control-label col-sm-4" for="provisionForFireInsurance">Provision for Fire Insurance</label>
    <div class="col-sm-8">
        <g:field class="form-control truncated" name="provisionForFireInsurance" value="${provisionForFireInsurance}" />
        <g:hasErrors bean="${ropaInstance}" field="provisionForFireInsurance">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${ropaInstance}" field="provisionForFireInsurance">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>