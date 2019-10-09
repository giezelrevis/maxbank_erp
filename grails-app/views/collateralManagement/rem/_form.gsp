<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'landArea', 'has-error')}">
    <label class="control-label col-sm-4" for="landArea">
    	Land Area (sq. meters)
    </label>
    <div class="col-sm-8">
    	<g:field name="landArea" value="${remInstance?.landArea}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="landArea">
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

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'tctNo', 'has-error')}">
    <label class="control-label col-sm-4" for="tctNo">
    	TCT No. 
    	<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8">
    	<g:field name="tctNo" value="${remInstance?.tctNo}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="tctNo">
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

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'lotNo', 'has-error')}">
    <label class="control-label col-sm-4" for="lotNo">
    	Lot No. 
    	<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8">
    	<g:field name="lotNo" value="${remInstance?.lotNo}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="lotNo">
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

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'location', 'has-error')}">
    <label class="control-label col-sm-4" for="location">
    	Location 
    	<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8">
    	<g:field name="location" value="${remInstance?.location}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="location">
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

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'otherOwners', 'has-error')}">
    <label class="control-label col-sm-4" for="otherOwners">
    	Other Owners
	</label>
    <div class="col-sm-8">
    	<g:field name="otherOwners" value="${remInstance?.otherOwners}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="otherOwners">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${remInstance}" field="otherOwners">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'registryOfDeeds', 'has-error')}">
    <label class="control-label col-sm-4" for="registryOfDeeds">
    	Registry Of Deeds 
    	<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8">
    	<g:field name="registryOfDeeds" value="${remInstance?.registryOfDeeds}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="registryOfDeeds">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${remInstance}" field="registryOfDeeds">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'dateOfIssuance', 'has-error')}">
	<label class="control-label col-sm-4" for="dateOfIssuance">
		Date of Issuance 
		<span class="required-indicator">*</span>
	</label>
    <div class="col-sm-8"><g:customDatePicker name="dateOfIssuance" precision="day" 
    class="form-control" value="${remInstance?.dateOfIssuance}" />

        <g:hasErrors bean="${remInstance}" field="dateOfIssuance">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${remInstance}" field="dateOfIssuance">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'encumberances', 'has-error')}">
    <label class="control-label col-sm-4" for="encumberances">
        Encumbrances
    </label>
    <div class="col-sm-8">
    	<g:field name="encumberances" value="${remInstance?.encumberances}" class="form-control"/>
    	<g:hasErrors bean="${remInstance}" field="encumberances">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${remInstance}" field="encumberances">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
	</div>
</div>