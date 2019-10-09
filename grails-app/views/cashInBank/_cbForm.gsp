<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<g:hiddenField name="cashInBankInstance" value="${cashInBankInstance}" />

<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'intRate', 'has-error')} required">
    <label class="control-label col-sm-4" for="seriesStart">Series Start<span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="seriesStart" value="" />
        <g:hasErrors bean="${cashInBankInstance}" field="seriesStart">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="seriesStart">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: cashInBankInstance, field: 'seriesEnd', 'has-error')} required">
    <label class="control-label col-sm-4" for="seriesEnd">Series End<span class="required-indicator">*</span>
    </label>
    <div class="col-sm-8">
        <g:field class="form-control" type="number" name="seriesEnd" value="" />
        <g:hasErrors bean="${cashInBankInstance}" field="seriesEnd">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${cashInBankInstance}" field="seriesEnd">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

