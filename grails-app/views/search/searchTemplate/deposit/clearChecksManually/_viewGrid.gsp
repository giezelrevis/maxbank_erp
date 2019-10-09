<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<div  name="inlineSearchDiv"id="inlineSearchDiv">
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
</g:javascript>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="section-container">
    <fieldset><legend class="section-header">Checks</legend>
     <g:form id="searchForm" name="searchForm" style="display:none">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-clearChecksManually"/>
        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
        <div class="row">
            <div class="col-md-12">
                <div class=" col-md-2">
                     <g:select name="max" value="${params.max}" from="[10, 20, 30, 40]" class="form-control input-sm "onchange="searchVar.searchMe();" />
                </div>
                <div class="input-group col-md-10">
                    <input id="searchQuery"name="searchQuery"type="text" class="form-control" value="${params?.searchQuery}"onchange="searchVar.searchMe();">
                    <span class="input-group-btn">
                      <a href="#" class="btn btn-primary" onclick="searchVar.searchMe();">Search</a>
                    </span>
                </div><!-- /input-group -->
            </div><!-- /.col-lg-6 -->
        </div>
        <div class="row">
            <div class=" col-md-6">
                <label class="radio-inline"><input type="radio" name="status">Cleared</label>
                <label class="radio-inline"><input type="radio" name="status">Not-Cleared</label>
            </div>
            <div class=" col-md-6">
                <label class="radio-inline"><input type="radio" name="dateRange">Today</label>
                <label class="radio-inline"><input type="radio" name="dateRange">Current Month</label>
                <label class="radio-inline"><input type="radio" name="dateRange">Range</label>
            </div>
        </div>
    </g:form>
     <div id="grid">
            <div class="box-body table-responsive no-padding">
                            <table class="table table-hover table-condensed table-bordered table-striped" id="tbl">
                                <tr> 
                                    <td><label>Check No</label></td>
                                    <td><label>Check Type</label></td>
                                    <td><label>Acct No</label></td>
                                    <td><label>Bank</label></td>
                                    <td><label>Amount</label></td>
                                    <td><label>Clearing Date</label></td>
                                    <td><label>Status</label></td>
                                    <td><label>Action</label></td>

                                </tr>
                                <g:each in="${icbs.tellering.TxnCOCI.findAll{depAcct==depositInstance}}" status="i" var="coci">
                                    <g:if test="${coci?.cleared == 'false' && coci?.status?.id == 2 && coci?.checkStatus?.id != 5}">
                                        
                                        <tr>
                                             <g:hiddenField name="id" value="${coci?.id}" disabled="disabled" />
                                             <td>${coci?.checkNo}</td>
                                             <td>${coci?.checkType?.description}</td>
                                             <td>${coci?.acctNo}</td>
                                             <td>${coci?.bank?.name}</td>
                                             <td><g:formatNumber number="${coci?.checkAmt}" format="###,###,##0.00" /></td>
                                             <td><g:formatDate format="yyyy-MM-dd" date="${coci?.clearingDate}"/></td>
                                             <td>${coci?.status?.description}</td>
                                             <td>
                                                 <input type="button" class="btn btn-primary" value="Confirm" onclick="comfirmChecksManuallyOverride(${coci?.id},1,this)"/> <!-- 
                                                 <input type="button" class="btn btn-secondary" value="Cancel" onclick="editCOCI(${coci?.id},0,this)"/ -->
                                             </td>
                                        </tr>
                                        
                                    </g:if>
                                  
                               </g:each>     
                            </table>
                <div class="pagination">
                        <g:paginate total="${domainInstanceCount ?: 0}"/>
                </div>
            </div>
    </div>
    </fieldset>
</div>
</div>