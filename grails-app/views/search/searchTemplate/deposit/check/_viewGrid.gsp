<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div name="checksSearchDiv"id="checksSearchDiv">
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}","#checksSearchDiv");
</g:javascript>
<div class="section-container">
    <fieldset><legend class="section-header">Checks</legend>
    <g:form id="searchForm" name="searchForm">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-check"/>
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
    </g:form>
    <div id="grid">
        <div class="box-body table-responsive no-padding">
                    <table class="table table-hover table-condensed table-bordered table-striped">
                        <tr> 
                            <td><label>Check No</label></td>
                            <td><label>Check Date</label></td>
                            <td><label>Payee </label></td>
                            <td><label>Payee Acct No</label></td>
                            <td><label>Amount</label></td>
                            <td><label>Clear Account No</label></td>
                            <td><label>Status</label></td>
                        </tr>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                                <tr>
                                    <td>${domainInstance?.chequeNo}</td>
                                    <td>${domainInstance?.chequeDate?.format('MM/dd/yyyy')}</td>
                                    <td>${domainInstance?.payeeName}</td>
                                    <td>${domainInstance?.payeeAcctNo}</td>
                                    <td><g:formatNumber number="${domainInstance?.chequeAmt}" format="###,##0.00" /></td>
                                    <td>${domainInstance?.clrAcctNo}</td>
                                    <td>${domainInstance?.status?.description}</td>
                                </tr>
                       </g:each>     
                    </table>
                    <div class="pagination">
                        <g:paginate total="${domainInstanceCount ?: 0}"/>
                    </div>
            </div>
    </div>
</div>
</div>