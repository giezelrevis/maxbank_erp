<g:javascript>
    console.log("acctsearch fire");
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
     <g:hiddenField id="searchDomain" name="searchDomain" value="gl-aps"/>
     <g:hiddenField id="branch_id" name="branch_id" value="${params?.branch_id}"/>
<div class="row">
    <div class="col-md-12">
        <div class=" col-md-2">
             <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm "onchange="searchVar.searchMe();" />
        </div>
        <div class="input-group col-md-10">
            <input id="searchQuery"name="searchQuery"type="text" class="form-control" value="${params?.searchQuery}"onchange="searchVar.searchMe();">
            <span class="input-group-btn">
              <a href="#" class="btn btn-primary" onclick="searchVar.searchMe();">Search</a>
            </span>
        </div><!-- /input-group -->
    </div><!-- /.col-lg-6 -->
</div>
<br>
</g:form>
    <div id="grid">
        <div class="table-responsive">
                <table class="table table-hover table-condensed table-bordered table-striped">
                    <tbody>
                        <tr>    
                        
                        <g:sortableColumn property="id" title="${message(code: 'aps.id', default: 'ID')}" />
                    
                        <g:sortableColumn property="glaccount" title="${message(code: 'aps.glaccount.label', default: 'GL Account No.')}" />
                    
                        <g:sortableColumn property="clientname" title="${message(code: 'aps.clientname.label', default: 'Client')}" />
                    
                        <g:sortableColumn property="reference" title="${message(code: 'aps.reference.label', default: 'Reference')}" />

                        <g:sortableColumn property="amount" title="${message(code: 'aps.amount.label', default: 'Amount')}" />

                        <g:sortableColumn property="transdate" title="${message(code: 'aps.transdate.label', default: 'Transaction Date')}" />

                        <td><label>Action</label></td>                    
                        </tr>
                    </tbody>
                    <tbody>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                            <tr>
                                 <td>${fieldValue(bean: domainInstance, field: "id")}</td>

                                <td>${fieldValue(bean: domainInstance, field: "glaccount")}</td>

                                <td>${fieldValue(bean: domainInstance, field: "clientname")}</td>
                            
                                <td>${fieldValue(bean: domainInstance, field: "reference")}</td>
                            
                                <td>${fieldValue(bean: domainInstance, field: "amount")}</td>              

                                <td><g:formatDate format="MM/dd/yyyy" date="${domainInstance.transdate}"/></td>                             

                                <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick="var temp = confirm('Are you sure you want to select this AP Account?'); if(temp){
                                modal.addOnCloseCallbackParams('glCode2',${domainInstance?.id});
                                modal.addOnCloseCallbackParams('glCode3', '${domainInstance?.glaccount}');
                                modal.addOnCloseCallbackParams('glName','${domainInstance?.clientname}');
                                modal.addOnCloseCallbackParams('apAmount',${domainInstance?.amount});
                                }" value="Select"/></td> 
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
    
