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
    <fieldset><legend class="section-header">Checkbooks</legend>
    <g:form id="searchForm" name="searchForm">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-checkbook"/>
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
                            <td><label>Issue Date</label></td>
                            <td><label>Start</label></td>
                            <td><label>End</label></td>
                            <td><label>Cheques Used</label></td>
                            <td><label>Remarks</label></td>
                            <!-- td><label>Created By</label></td -->
                            <td><label>Created Date</label></td>
                            <td><label>Actions</label></td>
                        </tr>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                                <tr>
                                     <g:hiddenField name="id" value="${domainInstance?.id}" disabled="disabled" />
                                     <td>${domainInstance?.dateIssued?.format("dd-MM-yyyy")}</td>
                                     <td>${domainInstance?.seriesStart}</td>
                                     <td>${domainInstance?.seriesEnd}</td>
                                     <td>${domainInstance?.chequesUsed}</td>
                                     <td>${domainInstance?.remarks}</td>
                                     <!-- td>Created By</td -->
                                     <td>${domainInstance?.dateIssued?.format("dd-MM-yyyy")}</td>
                                     <td>
                                         <input type="button" class="btn btn-secondary" value="Edit" onclick="editCheckbook(${domainInstance?.id})"/>
                                         <input type="button" class="btn btn-secondary" value="View Checks" onclick="initializeChecksSearchModal(${domainInstance?.id});modal.show()"/>
                                         <g:if test="${domainInstance?.chequesUsed == 0}">
                                         <input type="button" class="btn btn-secondary" value="Cancel Checks" onclick="cancelCheckbook(${domainInstance?.id})"/>
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