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
     <g:hiddenField id="searchDomain" name="searchDomain" value="gl-sortcode"/>
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
                            <g:sortableColumn property="sort_code" title="${message(code: 'GlSortCode.sort_code.label', default: 'Sort Code')}" />

                            <g:sortableColumn property="sort_name" title="${message(code: 'GlSortCode.sort_name.label', default: 'Name')}" />
                            <td><label>Action</label></td>
                        </tr>
                    </tbody>
                    <tbody>
                        <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                            <tr>
                                <td>${fieldValue(bean: domainInstance, field: "sort_code")}</td>
                                <td>${fieldValue(bean: domainInstance, field: "sort_name")}</td>
                                <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick="var temp = confirm('Are you sure you want to select this sort code?'); if(temp){
                                modal.addOnCloseCallbackParams('glSortCode2',${domainInstance?.id});
                                modal.addOnCloseCallbackParams('glSortCode3', '${domainInstance?.sort_code}');
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
    
