<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:hiddenField name="id" value="${chequebookInstance?.id}"/>
<g:hiddenField name="deposit" id="deposit.id" value="${chequebookInstance?.deposit?.id}"/>
<div class="fieldcontain form-group ${hasErrors(bean: chequebookInstance, field: 'seriesStart', 'has-error')} required">
	<label class="control-label col-sm-4" for="seriesStart">
		<g:message code="chequebook.seriesStart.label" default="Series Start" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:if test="${!chequebookInstance?.id}">
                <g:field name="seriesStart" type="number" value="${chequebookInstance.seriesStart}" required="" class="form-control"/>
            </g:if>
            <g:else>
                 <g:field name="seriesStart" type="number" value="${chequebookInstance.seriesStart}" required="" readonly="readonly" class="form-control"/>
            </g:else>

            <g:hasErrors bean="${chequebookInstance}" field="seriesStart">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${chequebookInstance}" field="seriesStart">
                                <%-- g:message error="${it}" / --%>
                                
                                <script>
                                    var s = "${it}".replace(/&#39;/g,""),
                                        j = s.split(';');
                                        a = (j[1].replace(']','')).split(',');
                                        //console.log(s);
                                    $('#errorstart').html(a[3]);
                                </script>
                                 <li id="errorstart"></li>
                            </g:eachError>
                        </span>
                </div> 
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chequebookInstance, field: 'seriesEnd', 'has-error')} required">
	<label class="control-label col-sm-4" for="seriesEnd">
		<g:message code="chequebook.seriesEnd.label" default="Series End" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:if test="${!chequebookInstance?.id}">
                <g:field name="seriesEnd" type="number" value="${chequebookInstance.seriesEnd}" required="" class="form-control"/>
            </g:if>
            <g:else>
                <g:field name="seriesEnd" type="number" value="${chequebookInstance.seriesEnd}" required="" readonly="readonly" class="form-control"/>
            </g:else>    
                
            <g:hasErrors bean="${chequebookInstance}" field="seriesEnd">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${chequebookInstance}" field="seriesEnd">
                                <%-- g:message error="${it}" /><br/ %--%>
                                <script>
                                    var s = "${it}".replace(/&#39;/g,"");
                                   // console.log(s);
                                        j = s.split(';');
                                        a = (j[1].replace(']','')).split(',');
                                    //    console.log(s);
                                    $('#errorend').html(a[3]);
                                </script>
                                 <li id="errorend"></li>
                                 
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>

<div class="fieldcontain form-group ${hasErrors(bean: chequebookInstance, field: 'remarks', 'has-error')} required">
	<label class="control-label col-sm-4" for="remarks">
		<g:message code="chequebook.remarks.label" default="Remarks" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8"><g:textField name="remarks" required="true" value="${chequebookInstance?.remarks}"class="form-control"/>

            <g:hasErrors bean="${chequebookInstance}" field="remarks">
                <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${chequebookInstance}" field="remarks">
                                <%-- g:message error="${it}" /><br/ --%>
                                
                                 <li id="errorrem">Remarks required!</li>
                                 
                            </g:eachError>
                        </span>
                </div>
            </g:hasErrors>
        </div>             
</div>