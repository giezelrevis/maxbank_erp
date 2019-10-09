<%@ page import="icbs.gl.GlLink" %>
<%@ page import="icbs.loans.LoanBranchTransfer" %>

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
    <g:hasErrors bean="${loanInstance}"> 
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
    <g:form name="update-branch-form">
        <g:hiddenField name="id" id="id" value="${loanInstance?.id}"/>
        <div class="form-group fieldcontain ${hasErrors(bean: loanInstance, field: 'branch', 'has-error')} ">
            <label class="control-label col-sm-4" for="branch">Branch</label>
            <div class="col-sm-8">
                <g:select id="branch" name="branch.id" from="${icbs.admin.Branch.findAll{status.id == 2}}" optionKey="id"  optionValue="name" value="${loanInstance?.branch?.id}" class="many-to-one form-control"/>
                <g:hasErrors bean="${loanInstance}" field="branch">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanInstance}" field="branch">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="fieldcontain form-group ${hasErrors(bean: loanBranchTransfer, field: 'particulars', 'has-error')} required">
            <label class="control-label col-sm-4" for="particulars">
		<g:message code="loanBranchTransfer.particulars.label" default="Particulars" />
		<span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:textField name="particulars" maxlength="100" required="" value="${loanBranchTransferInstance?.particulars}"class="form-control"/>
                <g:hasErrors bean="${loanBranchTransferInstance}" field="particulars">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanBranchTransferInstance}" field="particulars">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>             
        </div> 
        <div class="fieldcontain form-group ${hasErrors(bean: loanBranchTransfer, field: 'reference', 'has-error')} required">
            <label class="control-label col-sm-4" for="reference">
		<g:message code="loanBranchTransfer.particulars.label" default="Reference" />
		<span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:textField name="reference" maxlength="50" required="" value="${loanBranchTransferInstance?.reference}"class="form-control"/>
                <g:hasErrors bean="${loanBranchTransferInstance}" field="reference">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${loanBranchTransferInstance}" field="reference">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>             
        </div> 
    </g:form>  
</div>
