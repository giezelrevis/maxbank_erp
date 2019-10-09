<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<div  name="inlineStandSearchDiv"id="inlineStandSearchDiv">
<g:javascript>
    var searchVar3 = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}","#inlineStandSearchDiv");

</g:javascript>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="section-container">
    <fieldset><legend class="section-header">Standing Orders</legend>
     <g:form id="searchForm" name="searchForm" action="searchVar()">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-standingOrder"/>
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
                <script>
                document.getElementById('searchQuery').addEventListener('keypress', function(event) {
                    if (event.keyCode == 13) {
                        event.preventDefault();
                        $("#searchForm").serialize();
                        searchVar.searchMe();
                    }
                });
                
                $("#searchForm").submit(function(e){
                    //e.preventDefault();
                    $("#searchForm").serialize();
                    console.log('se');
                   // searchVar.searchMe();
                }); 
                
                
                
            </script>
            
            </div><!-- /.col-lg-6 -->
        </div>
    </g:form>
     <div id="grid">
            <div class="box-body table-responsive no-padding">
                           <table class="table table-hover table-condensed table-bordered table-striped">
                    <tr> 
                        <td><label>ID</label></td>
                        <td><label>Account#</label></td>
                        <td><label>Frequency</label></td>
                        <td><label>Transfer Type</label></td>
                        <td><label>Status</label></td>
                        <td><label>Actions</label></td>
                    </tr>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                            <tr>
                                 <g:hiddenField name="id" value="${domainInstance?.id}" disabled="disabled" />
                                 <td>${domainInstance?.id}</td>
                                 <td>${domainInstance?.fundingDeposit?.acctNo}</td>
                                 <td>${domainInstance?.freq?.description}</td>
                                 <td>${domainInstance?.type?.description}</td>
                                 <td>${domainInstance?.status}</td>
                                 <td>
                                     <input type="button" class="btn btn-secondary" value="Edit" onclick="editStandingOrder(${domainInstance?.id})"/>
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