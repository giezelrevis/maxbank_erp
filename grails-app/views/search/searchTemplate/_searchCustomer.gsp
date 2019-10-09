<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
    $("#searchForm").submit(function(e){
        e.preventDefault();
    });
</g:javascript>
<div  name="inlineSearchDiv"id="inlineSearchDiv">
<%@ page contentType="text/html;charset=UTF-8" %>
<g:form id="searchForm" name="searchForm">
    <!--Custom Action  -->
     <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
<div class="row">
    <div class="col-md-12">
        <div class=" col-md-2">
             <g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm "onchange="searchVar.searchMe();" />
            <!-- <g:link class="create" action="create" controller="customer">Create new CIF</g:link>-->
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
        <div class="table-responsive">
                <table class="table table-hover table-condensed table-bordered table-striped">
                    <tr>    
                        <g:sortableColumn property="type" title="${message(code: 'customer.type.label', default: 'Customer Type')}" />
                        <g:sortableColumn property="customerId" title="${message(code: 'customer.customerId.label', default: 'Customer Id')}" />
                        <g:sortableColumn property="branch" title="${message(code: 'customer.branch.label', default: 'Branch')}" />
                        <g:sortableColumn property="displayName" title="${message(code: 'customer.displayName.label', default: 'Display Name')}" />
                        <td>Address</td>
                        <g:sortableColumn property="birthDate" title="${message(code: 'customer.birthDate.label', default: 'Birth Date')}" />
                        <g:sortableColumn property="status" title="${message(code: 'customer.status.label', default: 'Status')}" />
                        <!-- <td>Created By</td> -->
                        <!-- <td>Last Updated By</td> -->
                        <td><label>Action</label></td>
                    </tr>
                    <tbody>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                            <tr>
                                <td>${fieldValue(bean: domainInstance, field: "type.description")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "customerId")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "branch.name")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "displayName")}</td>
                                <g:set var="primaryAddress" value="${(domainInstance?.addresses?.find{it.isPrimary==true})}"/>
                                    <g:if test="${primaryAddress!=null}">
                                        <td>${primaryAddress?.address1 + ", "+ primaryAddress?.address2 +", " +primaryAddress?.address3}</td>
                                    </g:if>
                                    <g:else>
                                        <td>N/A</td>
                                    </g:else>
                                <td>${domainInstance?.birthDate?.format("MM/dd/yyyy")}</td>
                                <td>${domainInstance?.status?.description}</td>
                                
                                <!-- <td>${domainInstance?.createdBy?.username}</td> -->
                                <!-- <td>${domainInstance?.lastUpdatedBy?.username}</td> -->
                                
                                <g:if test="${params.actionTemplate}">
                                    <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
                                    <g:render template="actionTemplate/${params.actionTemplate}" model="[customerInstance:domainInstance]"/>
                                </g:if>
                                <g:else>
                                    <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick="var temp = confirm('Are you sure you want to select this customer--?'); if(temp){modal.addOnCloseCallbackParams('customer2',${domainInstance?.id})}" value="Select"/></td>
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
    
