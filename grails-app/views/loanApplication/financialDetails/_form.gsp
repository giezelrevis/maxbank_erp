<%@ page import="icbs.loans.FinancialDetail" %>


<div>
    <g:if test="${message}">
        <div class="box-body">
            <div class="alert alert-info alert-dismissable">
                <i class="fa fa-info"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Message</b> <div class="message" role="status">${message}</div>
            </div>
        </div>
    </g:if>
    <g:hasErrors bean="${financialDetail}"> 
        <div class="box-body">
            <div class="alert alert-danger alert-dismissable">
                <i class="fa fa-ban"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Alert!</b> 
                <ul class="errors" role="alert">
                    There are errors
                </ul>            
            </div>
        </div>
    </g:hasErrors>

    <div name="add-financial-detail-form">
		<div class="fieldcontain form-group ${hasErrors(bean: financialDetail, field: 'description', 'has-error')}">
			<label for="description" class="control-label col-sm-4">Description <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
                <g:textArea name="description" cols="40" rows="5" maxlength="255" value="${financialDetail?.description}" class="form-control"/>

                <g:hasErrors bean="${financialDetail}" field="description">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${financialDetail?.description}" field="description">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
                </g:hasErrors>
			</div>
		</div>
		<div class="fieldcontain form-group ${hasErrors(bean: financialDetail, field: 'value', 'has-error')}">
			<label for="values" class="control-label col-sm-4">Value <span class="required-indicator">*</span></label>
			<div class="col-sm-8">
                               
                               <g:field type="text" name="value" value="${financialDetail?.value}" onkeyup="AddComma()" class="form-control truncated"/>
                               
		<g:hasErrors bean="${financialDetail}" field="value">
                       <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${financialDetail?.value}" field="value">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
                </g:hasErrors>
			</div>			
		</div>	
		<div class="fieldcontain form-group">
			<label for="types" class="control-label col-sm-4">Type</label>
			<div class="col-sm-8">
				<g:select class="form-control" id="type" name="type.id" from="${icbs.lov.LoanFinancialInfoType.list()}" optionKey="id" optionValue="description" value="${financialDetail?.type?.id}" />
			</div>
		</div>
    </div>
</div>




