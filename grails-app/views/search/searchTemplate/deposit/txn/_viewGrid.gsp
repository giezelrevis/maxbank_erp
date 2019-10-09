<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div  name="inlineSearchDiv"id="inlineSearchDiv">
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
</g:javascript>
<div class="section-container">
    <fieldset><legend class="section-header">Transactions</legend>
    <g:form id="searchForm" name="searchForm">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-txn"/>
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
                            <td><label>Txn ID</label></td>
                            <td><label>Txn File</label></td>
                            <td><label>Txn Date</label></td>
                            <td><label>Txn Type</label></td>
                            <td><label>Teller</label></td>
                            <td><label>Debit Amount</label></td>
                            <td><label>Credit Account</label></td>
                            <td><label>Balance</label></td>
                            <td><label>Currency</label></td>
                            <td><label>Txn Reference</label></td>
                            <td><label>Actions</label></td>
                        </tr>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                                <tr>
                                    <td>${domainInstance?.id}</td>
                                    <td>${domainInstance?.txnFile?.id}</td>
                                    <td>${domainInstance?.txnDate?.format("MM/dd/yyyy")}</td>
                                     <td>${domainInstance?.txnType}</td>
                                     <td>${domainInstance?.user?.username}</td>
                                     <td align="right"><g:formatNumber number="${domainInstance?.debitAmt}" format="###,##0.00" /></td>
                                     <td align="right"><g:formatNumber number="${domainInstance?.creditAmt}" format="###,##0.00" /></td>
                                    
                                     <td align="right"><g:formatNumber number="${domainInstance?.bal}" format="###,##0.00" /></td>
                                   <td>${domainInstance?.currency?.code}</td> 
                                   <td>${domainInstance?.txnRef}</td>
                                    <td>
                                         <g:if test="${domainInstance?.txnType?.id == 4}">
                                         <g:link action="viewCheckDepDetails" id="${domainInstance?.txnFile?.id}">View Details</g:link>
                                         </g:if>
                                    </td>                                   
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