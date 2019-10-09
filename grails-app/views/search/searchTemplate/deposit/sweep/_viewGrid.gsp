<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<div  name="inlineSweepSearchDiv"id="inlineSweepSearchDiv">
<g:javascript>
    var searchVar2 = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}","#inlineSweepSearchDiv");
</g:javascript>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="section-container">
    <fieldset><legend class="section-header">Sweeps</legend>
     <g:form id="searchForm" name="searchForm">
        
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-sweep"/>
        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
        <div class="row">
            <div class="col-md-12">
                <div class=" col-md-2">
                     <g:select name="max" value="${params.max}" from="[10, 20, 30, 40]" class="form-control input-sm "onchange="searchVar2.searchMe();" />
                </div>
                <div class="input-group col-md-10">
                    <input id="searchQuery" name="searchQuery"type="text" class="form-control" value="${params?.searchQuery}"onchange="searchVar2.searchMe();">
                    <span class="input-group-btn">
                      <a href="#" class="btn btn-primary" onclick="searchVar2.searchMe();">Search</a>
                    </span>
                </div>
            </div>
        </div>
    </g:form >
     <div id="grid">
            <div class="box-body table-responsive no-padding">
                        <table class="table table-hover table-condensed table-bordered table-striped">
                    <tr> 
                        <td><label>Sweep ID</label></td>
                        <td><label>Sweep Account No.</label></td>
                        <td><label>Name</label></td>
                        <td><label>Fund Limit</label></td>
                        <td><label>Status</label></td>
                        <td><label>Remarks</label></td>
                        <td><label>Order</label></td>
                        <td><label>Date Created</label></td>
                        <td><label>Created By</label></td>
                        <td><label>Action</label></td>
                    </tr>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                            <tr>
                                 <g:hiddenField name="id" value="${domainInstance?.id}" disabled="disabled" />
                                 <td>${domainInstance?.id}</td>
                                 <td>${domainInstance?.fundedDeposit?.acctNo}</td>
                                 <td>${domainInstance?.fundedDeposit?.acctName}</td>
                                 <td>${domainInstance?.rule?.description}</td>
                                 <td>${domainInstance?.status?.description}</td>
                                 <td>${domainInstance?.remarks}</td>
                                 <td>${domainInstance?.ordinalNum}</td>
                                 <td>${domainInstance?.dateCreated?.format("MM/dd/yyyy")}</td>
                                 <td>${domainInstance?.createdBy?.username}</td>
                                 <td>
                                     <input type="button" class="btn btn-secondary" value="Edit" onclick="editSweep(${domainInstance?.id})"/>
                                 </td>
                            </tr>
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