<%@ page import="icbs.gl.GlSortCode" %>




<div class="fieldcontain form-group ${hasErrors(bean: glSortCodeInstance, field: 'sort_code', 'has-error')} ">
	<label class="control-label col-sm-4" for="sort_code">
		<g:message code="glSortCode.sort_code.label" default="Sort Code" />
		
	</label>
	<div class="col-sm-8"><g:textField name="sort_code" value="${glSortCodeInstance?.sort_code}"class="form-control"/>

            <g:hasErrors bean="${glSortCodeInstance}" field="sort_code">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glSortCodeInstance}" field="sort_code">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glSortCodeInstance, field: 'sort_name', 'has-error')} ">
	<label class="control-label col-sm-4" for="sort_name">
		<g:message code="glSortCode.sort_name.label" default="Sort Code Name" />
		
	</label>
	<div class="col-sm-8"><g:textField name="sort_name" value="${glSortCodeInstance?.sort_name}"class="form-control"/>

            <g:hasErrors bean="${glSortCodeInstance}" field="sort_name">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glSortCodeInstance}" field="sort_name">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glSortCodeInstance, field: 'parent_id', 'has-error')} required">
	<label class="control-label col-sm-4" for="parent_id">
		<g:message code="glSortCode.parent_id.label" default="Parent Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:select id="parent_id" name="parent_id.id" from="${icbs.lov.GlAcctType.list()}" optionKey="id" required="" value="${glSortCodeInstance?.parent_id?.id}" class="many-to-one form-control"/>

            <g:hasErrors bean="${glSortCodeInstance}" field="parent_id">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glSortCodeInstance}" field="parent_id">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>


<div class="fieldcontain form-group ${hasErrors(bean: glSortCodeInstance, field: 'sort_code_status', 'has-error')} ">
	<label class="control-label col-sm-4" for="sort_code_status">
		<g:message code="glSortCode.sort_code_status.label" default="Sort Code Status" />
		
	</label>
	<div class="col-sm-8"><g:checkBox name="sort_code_status" class="form-control" value="${glSortCodeInstance?.sort_code_status}" />

            <g:hasErrors bean="${glSortCodeInstance}" field="sort_code_status">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${glSortCodeInstance}" field="sort_code_status">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

