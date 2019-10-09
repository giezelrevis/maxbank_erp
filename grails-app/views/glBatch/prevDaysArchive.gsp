<%@ page import="icbs.gl.GlBatchHdr" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'glBatchHdr.label', default: 'GL Batch Transactions')}" />
    <g:if test="${postedOnOff=='postedOff'}">
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </g:if>
    <g:else>
        <title>Posted GL Batch Transactions List (Previous Days)</title>
    </g:else>  		 
    <g:javascript>
        var processBatchTransactionAjaxLink = "${createLink(controller:'glBatch',action:'processBatchAjax')}";
        var getGlAccountsAjaxLink = "${createLink(controller:'glBatch',action:'getGLAcctByBranch')}"	
    </g:javascript>
  </head>
  <body>
    <content tag="main-content">
      <div id="batch">
        <div id="list-glBatchHdr" class="content scaffold-list" role="main">
          <g:if test="${flash.message}">
              <script>
                    $(function(){
                        var x = '${flash.error}';
                            notify.message(x);
                    });
              </script>      
          </g:if>
          <g:if test="${flash.error}">
                <script>
                    $(function(){
                        var x = '${flash.error}';
                            notify.message(x+'|error|alert');
                    });
                </script>
          </g:if>          
                            <g:form class="form-inline">
            <div class="form-group">
              <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm pull-left"onchange="this.form.submit()" />
            </div>
            <div class="right">
              <div class="form-group">
                <g:textField  type="text" name="query" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Search"/>
              </div>
              <g:submitButton name="Search" class="btn btn-sm btn-default"><i class="fa fa-search"></i></g:submitButton>
            </div>
          </g:form>
          <div class="table-responsive">
                                <table class="table table-hover table-condensed table-bordered table-striped">
                                    <thead>
              <tr>
                <g:sortableColumn property="id" title="${message(code: 'glBatchHdr.id.label', default: 'Batch Series')}" />
                <g:sortableColumn property="batchId" title="${message(code: 'glBatchHdr.batchId.label', default: 'Batch ID')}" />              
                <g:sortableColumn property="txnDate" title="${message(code: 'glBatchHdr.txnDate.label', default: 'Txn Date')}" />              
                <th><g:message code="glBatchHdr.errorGl.label" default="Batch Name" /></th>          
                <g:sortableColumn property="batchType" title="${message(code: 'glBatchHdr.batchType.label', default: 'Branch')}" />             
                <g:sortableColumn property="batchParticulars" title="${message(code: 'glBatchHdr.batchParticulars.label', default: 'Total Debits')}" />              
                <th><g:message code="glBatchHdr.loanAcct.label" default="Total Credits" /></th>                
                <g:sortableColumn property="batchStatus" title="${message(code: 'glBatchHdr.batchStatus.label', default: 'Batch Status')}" />              
                <th> Actions </th>                
                <th> Created By</th>			                 
              </tr>
            </thead>
            <tbody>
            <g:each in="${glBatchHdrInstanceList}" status="i" var="glBatchHdrInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>${fieldValue(bean: glBatchHdrInstance, field: "id")}</td>
                    <td>${fieldValue(bean: glBatchHdrInstance, field: "batchId")}</td>
                    <td><g:formatDate format="MM/dd/yyyy" date="${glBatchHdrInstance?.txnDate}" /></td>
                    <!-- <td><g:link action="edit" id="${glBatchHdrInstance.id}">${fieldValue(bean: glBatchHdrInstance, field: "batchId")}</g:link></td> -->              
                    <td>${fieldValue(bean: glBatchHdrInstance, field: "batchName")}</td>              
                    <td>${fieldValue(bean: glBatchHdrInstance, field: "branch.name")}</td>              
                    <td align="right"><g:formatNumber format="###,###,##0.00" number="${glBatchHdrInstance?.totalDebit}"/></td>
                    <td align="right"><g:formatNumber format="###,###,##0.00" number="${glBatchHdrInstance?.totalCredit}"/></td>                
                    <td>${glBatchHdrInstance.status.description}</td>
                    <td> 
                        <g:link class="btn btn-primary btn-xs" action="edit" id="${glBatchHdrInstance.id}" params="[showview: 'posted']"> View </g:link>
                        <g:link class="btn btn-primary btn-xs" target="_blank" action="printGlBatch" id="${glBatchHdrInstance.id}" params="[glBatchHdrInstance: glBatchHdrInstance, bId:glBatchHdrInstance.id]"> Print </g:link>
                    </td>		                 
                <td>${fieldValue(bean: glBatchHdrInstance, field: "createdBy.username")}</td>                
                </tr>
            </g:each>
          </tbody>
          </table>
        </div>
        <div class="pagination">
            <g:paginate total="${GlBatchHdrInstanceCount ?: 0}" params="${params}" />
        </div>
      </div>
    </div>   
    </content>
    <content tag="main-actions">
        <ul>                    
            <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            <li><g:link action="index" class="btn btn-primary btn-xs" params="[showview: 'posted']" > GL Batch Transaction Archive </g:link></li>                    
            <li><a href='#' id="add-buttons" type="button" data-toggle="modal" data-target="#modalParameters" class="btn btn-primary multi-field-btn-add">Print Full Trial Balance</a></li>
            <!-- Modal -->
                <div id="modalParameters" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title" style="color: black;">Generate Full Trial Balance</h4>
                                </div>
                                <div class="modal-body">
                                    
                                    <!-- date1 -->
                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                        <label class="control-label col-sm-4" style="color: gray;">Cut-Off Date Start: </label>
                                        <div class="col-sm-8"><g:customDatePicker name="date1" id="date1"  precision="day" class="form-control"  value="" default="none" noSelection="['': '']" /></div>
                                    </div>
                                    
                                </div>
                                <div class="modal-footer">
                                    <a href = "#" onclick="genReportGNL001();" class="btn btn-default"> Print Report </a>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                       
                                <g:javascript>
                                    function genReportGNL001(){
                                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(21).baseParams}&output=${icbs.admin.Report.get(21).outputParam}";
                                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(21).reportUnit}";
                                        reportlink = reportlink + "&txn_date=" + dateformat(document.getElementById('date1').value);
                                        reportlink = reportlink + "&currency_code=PHP";
                                        reportlink = reportlink + "&multi_select_branch=${icbs.admin.UserMaster.get(session.user_id).branch.name}";
                                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                                        sendtojasperver(reportlink);
                                    }

                                </g:javascript>
                            </div>

                        </div>
                    </div>  
                    <!-- modal close --> 
                    
                                        
                    <li><a href='#' id="add-buttons" type="button" data-toggle="modal" data-target="#modalParameters_GNL003" class="btn btn-primary multi-field-btn-add">Print General Proofsheet</a></li>

                    <!-- Modal -->
                    <div id="modalParameters_GNL003" class="modal fade" role="dialog">
                        <div class="modal-dialog">

                        <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title" style="color: black;">Generate General Proofsheet</h4>
                                </div>
                                <div class="modal-body">
                                    
                                    <!-- date1 -->
                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                        <label class="control-label col-sm-4" style="color: gray;">Cut-Off Date Start: </label>
                                        <div class="col-sm-8"><g:customDatePicker name="date2" id="date2"  precision="day" class="form-control"  value="" default="none" noSelection="['': '']" /></div>
                                    </div>
                                    
                                </div>
                                <div class="modal-footer">
                                    <a href = "#" onclick="genReportGNL003();" class="btn btn-default"> Print Report </a>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                </div>
                       
                                <g:javascript>
                                    function genReportGNL003(){
                                        reportlink = "${icbs.admin.Institution.get(94).paramValue}${icbs.admin.Report.get(23).baseParams}&output=${icbs.admin.Report.get(23).outputParam}";
                                        reportlink = reportlink + "&reportUnit=${icbs.admin.Report.get(23).reportUnit}";
                                        reportlink = reportlink + "&txn_date=" + dateformat(document.getElementById('date2').value);
                                        reportlink = reportlink + "&currency_code=PHP";
                                        reportlink = reportlink + "&branch_name=${icbs.admin.UserMaster.get(session.user_id).branch.name}";
                                        reportlink = reportlink + "&generatedby=${icbs.admin.UserMaster.get(session.user_id).username}";
                                        sendtojasperver(reportlink);
                                    }

                                </g:javascript>
                            </div>

                        </div>
                    </div>  
                    <!-- modal close --> 
                                        
                                        
                     
                    
        </ul>
    </content>
  </body>
</html>
