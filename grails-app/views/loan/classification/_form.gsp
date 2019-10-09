<legend>Performance Classification</legend>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loanKindOfLoan', 'has-error')} required">
    <label class="control-label col-sm-4" for="loanKindOfLoan">
        <g:message code="loan.KindOfLoan.label" default="Kind of Loan" />
    </label>
    <div class="col-sm-8">
        <g:select id="loanKindOfLoan" name="loanKindOfLoan.id" from="${icbs.lov.LoanKindOfLoan.list()}" optionKey="id" optionValue="description" value="${loanInstance?.loanKindOfLoan?.id}" class="form-control" noSelection="['null': '']"/>

        <g:hasErrors bean="${loanInstance}" field="loanKindOfLoan">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="loanKindOfLoan">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loanType', 'has-error')} required">
    <label class="control-label col-sm-4" for="loanType">
        <g:message code="loan.loanType.label" default="Name of Institution" />
    </label>
    <div class="col-sm-8">
        <g:select id="loanType" name="loanType.id" from="${icbs.lov.LoanType.list()}" optionKey="id" optionValue="description" value="${loanInstance?.loanType?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="loanType">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="loanType">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loanProject', 'has-error')} required">
    <label class="control-label col-sm-4" for="loanProject">
        <g:message code="loan.loanProject.label" default="Economic Activity" />
    </label>
    <div class="col-sm-8">
        <g:select id="loanProject" name="loanProject.id" from="${icbs.lov.LoanProject.list()}" optionKey="id" optionValue="description" value="${loanInstance?.loanProject?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="loanProject">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="loanProject">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loanProvision', 'has-error')} required">
    <label class="control-label col-sm-4" for="loanProvision">
        <g:message code="loan.loanProvision.label" default="Loan Provision" />
    </label>
    <div class="col-sm-8">
        <g:select id="loanProvision" name="loanProvision.id" from="${icbs.lov.LoanProvision.list()}" optionKey="id" optionValue="description" value="${loanInstance?.loanProvision?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="loanProvision">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="loanProvision">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loanPerformanceId', 'has-error')} required">
    <label class="control-label col-sm-4" for="loanPerformanceId">
        <g:message code="loan.loanPerformanceId.label" default="Loan Status" />
    </label>
    <div class="col-sm-8">
        <g:select id="loanPerformanceId" name="loanPerformanceId.id" from="${icbs.lov.LoanPerformanceId.list()}" optionKey="id" optionValue="description" value="${loanInstance?.loanPerformanceId?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="loanPerformanceId">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="loanPerformanceId">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'loanSecurity', 'has-error')} required">
    <label class="control-label col-sm-4" for="loanSecurity">
        <g:message code="loan.loanSecurity.label" default="Loan Security" />
    </label>
    <div class="col-sm-8">
        <g:select id="loanSecurity" name="loanSecurity.id" from="${icbs.lov.LoanSecurity.list()}" optionKey="id" optionValue="description" value="${loanInstance?.loanSecurity?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="loanSecurity">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="loanSecurity">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
<%--<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'performanceClassificationScheme1', 'has-error')} required">
    <label class="control-label col-sm-4" for="performanceClassificationScheme1">
        <g:message code="loan.performanceClassificationScheme.label" default="Performance Classification Scheme 1" />
    </label>
    <div id="performance-classification-scheme1" class="col-sm-8">    
        
        <g:hasErrors bean="${loanInstance}" field="performanceClassificationScheme">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="performanceClassificationScheme">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
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

<br/><br/>
<legend>GL</legend>
<g:if test="${loanInstance.glLink==null}">
<div class="fieldcontain form-group ${hasErrors(bean: loanInstance, field: 'glLink', 'has-error')} required">
    <label class="control-label col-sm-4" for="glLink">
        <g:message code="loan.glLink.label" default="Loan Type" />
    </label>
    <div class="col-sm-8">
        <g:select id="glLink" name="glLink.id" from="${icbs.gl.CfgAcctGlTemplate.list().findAll{it.type == 6}}" optionKey="id" optionValue="description" value="${loanInstance?.glLink?.id}" class="many-to-one form-control"/>

        <g:hasErrors bean="${loanInstance}" field="glLink">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${loanInstance}" field="glLink">
                        <g:message error="${it?.code}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
    </div>             
</div>
</g:if>


