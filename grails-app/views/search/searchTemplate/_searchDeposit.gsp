<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
</g:javascript>
<div  name="inlineSearchDiv" id="inlineSearchDiv">
    <%--
    <g:form id="searchForm" name="searchForm">

        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit"/>
        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
        <g:hiddenField id="module" name="module" value="${params.module}"/>
        <g:hiddenField id="customFilter" name="customFilter" value="${params.customFilter}" />

    <div class="row">
        <div class="col-md-12">
            <div class=" col-md-2">
                 <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm "onchange="searchVar.searchMe();" />
            </div>
            <div class="input-group col-md-10">
                <input id="searchQuery" name="searchQuery" type="text" class="form-control" value="${params?.searchQuery}">
                <span class="input-group-btn">
                  <a href="#" class="btn btn-primary" onclick="searchVar.searchMe();">Search?</a>
                </span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label class="radio-inline">
                <input type="radio" name="searchType"  id="searchType" value="0"> Deposit ID
            </label>
            <label class="radio-inline">
                <input type="radio" name="searchType" checked="checked" id="searchType" value="1"> Customer Name
            </label>
        </div>
    </div>
    </g:form>

    --%>
    <form id="searchForm" name="searchForm">
        <input type="text" id="searchDomain" name="searchDomain" value="deposit" style="display:none">
        <input type="text"  id="module" name="module" value="${params.module}" style="display:none">
        <input type="text" id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}" style="display:none">
        
        <div class="row">
            <div class="col-md-12">
                <div class=" col-md-2">
                     <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" "onchange="searchVar.searchMe();" />
                </div>
                <div class="input-group col-md-10">
                    <input id="searchQuery" name="searchQuery" type="text" class="form-control" value="${params?.searchQuery}">
                    <span class="input-group-btn">
                      <a href="#" class="btn btn-primary" onclick="searchVar.searchMe();">Search</a>
                    </span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <label class="radio-inline">
                    <input type="radio" name="searchType" id="searchType" value="1"> Customer Name
                </label>
                <label class="radio-inline">
                    <input type="radio" name="searchType" checked="checked"  id="searchType" value="0">Account Number
                </label>            
            </div>
        </div>
    </form>
    <div id="grid">
            <div class="table-responsive">
               <table class="table table-hover table-condensed table-bordered table-striped">
                   <thead>
                    <tr>    
                        <g:sortableColumn property="acctNo" title="${message(code: 'deposit.acctNo.label', default: 'Deposit ID')}" />
                        <g:sortableColumn property="type" title="${message(code: 'deposit.type.label', default: 'Deposit Type')}" />
                        
                        <g:sortableColumn property="customer" title="${message(code: 'deposit.customer.label', default: 'Primary Owner ')}" />
                        <g:sortableColumn property="dateOpened" title="${message(code: 'deposit.dateOpened.label', default: 'Date Opened')}"/>
                        <g:sortableColumn property="branch" title="${message(code: 'deposit.branch.label', default: 'Branch')}"/>
                    
                        <g:sortableColumn property="status" title="${message(code: 'deposit.status.label', default: 'Status')}" />
                        <td><label>Ownership</label></td>
                        <td><label>Action</label></td>
                    </tr>
                    </thead>
                    <tbody>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                            <tr>
                                <td>${fieldValue(bean: domainInstance, field: "acctNo")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "type.description")}</td>
                               
                                <td>${fieldValue(bean: domainInstance, field: "customer.displayName")}</td>
                                <td>${domainInstance?.dateOpened?.format("MM/dd/yyyy")}</td>
                                <td>${domainInstance?.branch?.name}</td>
                                <td>${fieldValue(bean: domainInstance, field: "status.description")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "ownershipType.description")}</td>
                                <g:if test="${params.actionTemplate}">
                                    <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
                                    
                                    <g:render template="actionTemplate/${params.actionTemplate}" model="[depositInstance:domainInstance]"/>
                                </g:if>
                                <g:else>
                                    <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick=" var temp = confirm('Are you sure you want to select this Deposit Account?'); if(temp){modal.addOnCloseCallbackParams('deposit',${domainInstance?.id});modal.addOnCloseCallbackParams('accountNo','${domainInstance?.acctNo}');}" value="Select"/></td>
                                </g:else>
                                
                                
                             </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            
            <div class="pagination">
                <g:paginate total="${domainInstanceCount ?: 0}"/>
            </div>
            
    </div>
</div>   
    