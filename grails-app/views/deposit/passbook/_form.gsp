<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField name="id" value="${issuePassbookInstance?.id}"/>
<g:hiddenField id="deposit"name="deposit.id" value="${issuePassbookInstance?.deposit?.id}"/>
<g:hiddenField id="UserID"name="UserID" value="${issuePassbookInstance?.issuedBy?.id}"/>



<div class="fieldcontain form-group ${hasErrors(bean: issuePassbookInstance, field: 'passbookNo', 'has-error')} required">
	<label class="control-label col-sm-4" for="passbookNo">
		<g:message code="issuePassbook.passbookNo.label" default="Passbook No" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <script>
                console.log(location.href);
            </script>
            <g:textField  name="passbookNo" required="" value="${issuePassbookInstance?.passbook?.passbookNo}"class="form-control passbookNo"/>

            <g:hasErrors bean="${issuePassbookInstance}" field="passbookNo">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${issuePassbookInstance}" field="passbookNo">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>
<div class="fieldcontain form-group ${hasErrors(bean: issuePassbookInstance, field: 'remarks', 'has-error')} ">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="issuePassbook.remarks.label" default="Remarks" />
		
	</label>
	<div class="col-sm-8"><g:textArea id="remarks" name="remarks" cols="40" rows="5" maxlength="255" value="${issuePassbookInstance?.remarks}"class="form-control"/>

            <g:hasErrors bean="${issuePassbookInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${issuePassbookInstance}" field="remarks">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>



