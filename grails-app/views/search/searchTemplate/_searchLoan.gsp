<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
</g:javascript>

<div  name="inlineSearchDiv"id="inlineSearchDiv">
<%@ page contentType="text/html;charset=UTF-8" %>
<g:form id="searchForm" name="searchForm">
    <!--Custom Action  -->
    <g:hiddenField id="searchDomain" name="searchDomain" value="loan"/>
    <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
    <g:hiddenField id="module" name="module" value="${params.module}"/>
<div class="row">
    <div class="col-md-12">
        <div class=" col-md-2">
             <g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm "onchange="searchVar.searchMe();" />
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
    <div class="col-md-12">
        <label class="radio-inline">
            <input type="radio" name="searchType"  id="searchType" value="0"> Loan ID
        </label>
        <label class="radio-inline">
            <input type="radio" name="searchType" checked="checked" id="searchType" value="1"> Customer Name
        </label>
    </div><!-- /.col-lg-6 -->
</div>
</g:form>
    <div id="grid">
        <div class="table-responsive">
               <table class="table table-hover table-condensed table-bordered table-striped">
                    <tr>    
                        <g:sortableColumn property="accountNo" title="${message(code: 'loan.accountNo.label', default: 'Loan ID')}" />
                     
                        <g:sortableColumn property="status" title="${message(code: 'loan.status.label', default: 'Status')}" />
                        <td><label>Action</label></td>
                    </tr>
                    <tbody>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                            <tr>
                                <td>${fieldValue(bean: domainInstance, field: "acctNo")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "type.description")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "customer.displayName")}</td>
                                <td>${domainInstance?.dateOpened?.format("MM/dd/yyyy")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "status.description")}</td>
                                
                                <g:if test="${params.actionTemplate}">
                                    <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
                                    
                                    <g:render template="actionTemplate/${params.actionTemplate}" model="[depositInstance:domainInstance]"/>
                                </g:if>
                                <g:else>
                                    <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick=" var temp = confirm('Are you sure you want to select this Deposit Account?'); if(temp){modal.addOnCloseCallbackParams('deposit',${domainInstance?.id})}" value="Select"/></td>
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
    