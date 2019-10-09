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
    <fieldset><legend class="section-header">CTD's</legend>
     <g:form id="searchForm" name="searchForm">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-ctd"/>
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
                                    <td><label>CTD No</label></td>
                                    <td><label>Issue Date</label></td>
                                    <td><label>Issued By</label></td>
                                    <td><label>Open Date</label></td>
                                    <td><label>Maturity Date</label></td>
                                    <td><label>Term</label></td>
                                    <td><label>Int Rate</label></td>
                                    <td><label>Actions</label></td>
                                </tr>
                            <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                                    <tr>
                                        <td>${domainInstance?.ctd?.ctdNo}</td>
                                         <td>${domainInstance?.dateIssued?.format("MM/dd/yyyy")}</td>
                                         <td>${domainInstance?.issuedBy?.username}</td>
                                         <td>${domainInstance?.ctd?.dateOpened?.format("MM/dd/yyyy")}</td>
                                         <td>${domainInstance?.ctd?.maturityDate?.format("MM/dd/yyyy")}</td>
                                         <td>${domainInstance?.ctd?.term}</td>
                                         <td><g:formatNumber number="${domainInstance?.ctd?.interestRate}" format="##0.00%" /></td>
                                         <td>
                                            <input type="button" class="btn btn-secondary" value="Edit" onclick="editCTD(${domainInstance?.id})"/>
                                            <g:jasperReport action="printCTD"  controller="deposit" format="PDF" jasper="ctd" name="CTD">
                                               <input type="hidden" name="id" value="${domainInstance?.id}" />
                                            </g:jasperReport>
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