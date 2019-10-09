<%@ page import="icbs.lov.LoanCollateralStatus" %>


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
    <g:hasErrors bean="${collateralInstance}"> 
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
    <g:form name="update-status-form">
        <g:hiddenField name="id" id="id" value="${collateralInstance?.id}"/>
        <div class="form-group fieldcontain ${hasErrors(bean: collateralInstance, field: 'status', 'has-error')} ">
            <label class="control-label col-sm-4" for="status">Status</label>
            <div class="col-sm-8">
                <g:select id="status" name="status.id" from="${LoanCollateralStatus.list()}" optionKey="id" optionValue="description" value="${collateralInstance?.status?.id}" class="form-control"/>
                <g:hasErrors bean="${collateralInstance}" field="status">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${collateralInstance}" field="status">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
    </g:form>  
</div>
