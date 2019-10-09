<%@ page import="icbs.gl.GlAccount" %>




<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
		<g:message code="glAccount.type.label" default="Type" />
		
	</label>
	<div class="col-sm-8"><g:select id="type" name="type.id" from="${icbs.lov.GlAcctType.list()}" optionKey="id" value="${glAccountInstance?.type?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${glAccountInstance}" field="type">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glAccountInstance}" field="type">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'currency', 'has-error')} ">
	<label class="control-label col-sm-4" for="currency">
		<g:message code="glAccount.currency.label" default="Currency" />
		
	</label>
	<div class="col-sm-8"><g:select id="currency" name="currency.id" from="${icbs.admin.Currency.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" value="${glAccountInstance?.currency?.id}" class="many-to-one form-control" noSelection="['null': '']"/>

            <g:hasErrors bean="${glAccountInstance}" field="currency">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glAccountInstance}" field="currency">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'code', 'has-error')} required">
	<label class="control-label col-sm-4" for="code">
		<g:message code="glAccount.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="code" required="" value="${glAccountInstance?.code}"class="form-control"/>

            <g:hasErrors bean="${glAccountInstance}" field="code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glAccountInstance}" field="code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'name', 'has-error')} required">
	<label class="control-label col-sm-4" for="name">
		<g:message code="glAccount.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="name" required="" value="${glAccountInstance?.name}"class="form-control"/>

            <g:hasErrors bean="${glAccountInstance}" field="name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glAccountInstance}" field="name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'parent', 'has-error')} ">
	<label class="control-label col-sm-4" for="parent">
		<g:message code="glAccount.parent.label" default="Parent (Sort Code)" />
		
	</label>
	<div class="col-sm-7">
        <g:hiddenField name="parent.id" id="glSortCodeHidden" value="${glAccountInstance?.parent?.id}" />
        <input class="form-control" id="glSortCode"type="text" value="${glAccountInstance?.parent?.sort_code}" readonly="true">
        
    </div>      
    <div 
        class="col-sm-2"><input type="button" href="#" 
        class="btn btn-secondary" 
        onclick="showSortCodeModalSearch()"
         value="Search"/>
    </div>       
</div>





<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'shortName', 'has-error')} ">
	<label class="control-label col-sm-4" for="shortName">
		<g:message code="glAccount.shortName.label" default="Short Name" />
		
	</label>
	<div class="col-sm-8"><g:textField name="shortName" value="${glAccountInstance?.shortName}"class="form-control"/>

            <g:hasErrors bean="${glAccountInstance}" field="shortName">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glAccountInstance}" field="shortName">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glAccountInstance, field: 'batchUpdate', 'has-error')} ">
	<label class="control-label col-sm-4" for="batchUpdate">
		<g:message code="glAccount.batchUpdate.label" default="Batch Update" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="batchUpdate" class="form-control" value="${glAccountInstance?.batchUpdate}" />

            <g:hasErrors bean="${glAccountInstance}" field="batchUpdate">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glAccountInstance}" field="batchUpdate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

