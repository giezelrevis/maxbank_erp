<legend>Performance Classification</legend>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'performanceClassificationScheme1', 'has-error')} required">
    <label class="control-label col-sm-4" for="performanceClassificationScheme1">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 1" />
    </label>
    <div id="performance-classification-scheme1" class="col-sm-8">    
        
        <%--<g:hasErrors bean="${loanInstance}" field="performanceClassificationScheme">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="performanceClassificationScheme">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>--%>
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
</div>




