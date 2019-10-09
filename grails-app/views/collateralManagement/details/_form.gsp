<%@ page import="icbs.loans.Collateral" %>

<legend>Collateral Details</legend>

<div class="fieldcontain form-group ${hasErrors(bean: collateralInstance, field: 'owner', 'has-error')}">
	<label class="control-label col-sm-4" for="owner">
		<g:message code="collateral.owner.label" default="Owner" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-7"><g:field name="owner-name" value="${collateralInstance?.owner?.displayName}" class="form-control" readonly="true"/>
    <g:hiddenField id="owner" name="owner.id" value="${collateralInstance?.owner?.id}" />

       <g:hasErrors bean="${collateralInstance}" field="owner">
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

    <div class="col-sm-2"><input type="button" href="#" class="btn btn-secondary" onclick="showOwnerSearch()" value="Search"/></div>
</div>

<div class="fieldcontain form-group ${hasErrors(bean: collateralInstance, field: 'collateralType', 'has-error')} ">
	<label class="control-label col-sm-4" for="collateralType">
		<g:message code="collateral.collateralType.label" default="Collateral Type" />		
	</label>
	<div class="col-sm-8"><g:select id="collateralType" name="collateralType.id" from="${icbs.lov.LoanCollateralType.list()}" optionKey="id" optionValue="description" value="${collateralInstance?.collateralType?.id}" class="many-to-one form-control" onchange="updateForm()"/>    

            <g:hasErrors bean="${collateralInstance}" field="collateralType">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${collateralInstance}" field="collateralType">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div> 
</div>

<div class="fieldcontain form-group ${hasErrors(bean: collateralInstance, field: 'appraisedValue', 'has-error')} ">
	<label class="control-label col-sm-4" for="appraisedValue">
		<g:message code="collateral.appraisedValue.label" default="Appraised Value" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:field name="appraisedValue" value="${collateralInstance?.appraisedValue}" class="form-control truncated"/>

            <g:hasErrors bean="${collateralInstance}" field="appraisedValue">
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

<div id="appraised-value-type-form-group" class="fieldcontain form-group ${hasErrors(bean: remInstance, field: 'appraisedValueType', 'has-error')} ">
    <label class="control-label col-sm-4" for="appraisedValueType">
        <g:message code="rem.appraisedValueType.label" default="Appraised Value Type" />        
    </label>
    <div class="col-sm-8"><g:select id="appraisedValueType" name="appraisedValueType.id" from="${icbs.lov.AppraisedValueType.list()}" optionKey="id" optionValue="description" value="${remInstance?.appraisedValueType?.id}" class="many-to-one form-control"/>    

            <g:hasErrors bean="${remInstance}" field="appraisedValueType">
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

<div class="fieldcontain form-group ${hasErrors(bean: collateralInstance, field: 'description', 'has-error')} ">
	<label class="control-label col-sm-4" for="description">
		<g:message code="collateral.description.label" default="Description" />		
	</label>
	<div class="col-sm-8"><g:textArea name="description" value="${collateralInstance?.description}" rows="3" class="form-control"/>

            <g:hasErrors bean="${collateralInstance}" field="description">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${collateralInstance}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div id="rem-form-group">
    <g:render template="rem/form"/>
</div>

<div id="chattel-form-group">
    <g:render template="chattel/form"/>
</div>

<div id="holdout-form-group">
    <g:render template="holdout/form"/>
</div>

<%--<div id="pdc-form-group">
    <g:render template="pdc/form"/>
</div>--%>