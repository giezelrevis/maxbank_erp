<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'identificationNo', 'has-error')}">
    <label class="control-label col-sm-4" for="identificationNo">
        Identification No. 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
    	<g:field name="identificationNo" value="${chattelInstance?.identificationNo}" class="form-control"/>
    	<g:hasErrors bean="${chattelInstance}" field="identificationNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="identificationNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'acquisitionCost', 'has-error')}">
    <label class="control-label col-sm-4" for="acquisitionCost">
        Acquisition Cost 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field name="acquisitionCost" value="${chattelInstance?.acquisitionCost}" class="form-control"/>
        <g:hasErrors bean="${chattelInstance}" field="acquisitionCost">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="acquisitionCost">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'acquisitionDate', 'has-error')}">
    <label class="control-label col-sm-4" for="acquisitionDate">
        Acquisition Date 
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8"><g:customDatePicker name="acquisitionDate" precision="day" 
    class="form-control" value="${chattelInstance?.acquisitionDate}" />

        <g:hasErrors bean="${chattelInstance}" field="acquisitionDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="acquisitionDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'insuranceType', 'has-error')}">
    <label class="control-label col-sm-4" for="insuranceType">
        Insurance Type
    </label>
    <div class="col-sm-8">
        <g:field name="insuranceType" value="${chattelInstance?.insuranceType}" class="form-control"/>
        <g:hasErrors bean="${chattelInstance}" field="insuranceType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="insuranceType">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'orNo', 'has-error')}">
    <label class="control-label col-sm-4" for="orNo">
    Official Receipt No.
    </label>
    <div class="col-sm-8">
        <g:field name="orNo" value="${chattelInstance?.insuranceType}" class="form-control"/>
        <g:hasErrors bean="${chattelInstance}" field="orNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="orNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'orDate', 'has-error')}">
    <label class="control-label col-sm-4" for="orDate">
        Official Receipt Date 
    </label>
    <div class="col-sm-8"><g:customDatePicker name="orDate" precision="day" 
    class="form-control" value="${chattelInstance?.orDate}" />

        <g:hasErrors bean="${chattelInstance}" field="orDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="orDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'crNo', 'has-error')}">
    <label class="control-label col-sm-4" for="crNo">
    Certificate of Registration No.
    </label>
    <div class="col-sm-8">
        <g:field name="crNo" value="${chattelInstance?.crNo}" class="form-control"/>
        <g:hasErrors bean="${chattelInstance}" field="crNo">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="crNo">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chattelInstance, field: 'crDate', 'has-error')}">
    <label class="control-label col-sm-4" for="crDate">
        Certificate of Registration Date 
    </label>
    <div class="col-sm-8"><g:customDatePicker name="crDate" precision="day" 
    class="form-control" value="${chattelInstance?.crDate}" />

        <g:hasErrors bean="${chattelInstance}" field="crDate">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${chattelInstance}" field="crDate">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
