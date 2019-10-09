
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller:'group', action:'search')}");
    $(document).ready(function() {
        $('#searchForm').on('submit', function(e){
            e.preventDefault();
        });
    });
</g:javascript>

<div name="inlineSearchDiv" id="inlineSearchDiv">
    <g:form id="searchForm" name="searchForm" url="[controller:group, action:'search']">
    <div class="row">
        <div class="col-md-12">
            <div class=" col-md-2">
                <g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm "onchange="searchVar.searchMe();" />
            </div>
            <div class="input-group col-md-10">
                <input id="query" name="query" type="text" class="form-control" value="${params?.query}">
                <span class="input-group-btn">
                    <a href="#" class="btn btn-primary" onclick="searchVar.searchMe();">Search</a>
                </span>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label class="radio-inline">
                <g:hiddenField name="searchType" value="0"/>
            </label>
        </div>
    </div>
    </g:form>

    <div id="grid">
        <div class="table-responsive">
            <table class="table table-hover table-condensed table-bordered table-striped">
                <tbody>
                    <tr>    
                        <g:sortableColumn property="id" title="ID" />

                        <g:sortableColumn property="name" title="Name" />

                        <g:sortableColumn property="parent.name" title="Parent" />

                        <g:sortableColumn property="meetinDate" title="Meeting Date" />

                        <td><label>Action</label></td>
                    </tr>
                </tbody>
                <tbody>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                    <tr>
                        <td>${domainInstance?.id}</td>

                        <td>${domainInstance?.name}</td>

                        <td>${domainInstance?.parent?.name}</td>

                        <td><g:formatDate format="MM/dd/yyyy" date="${domainInstance?.meetingDate}"/></td>
                                                    
                        <g:if test="${params.actionTemplate}">
                        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
                        <g:render template="actionTemplate/${params.actionTemplate}" model="[groupInstance:domainInstance]"/>
                        </g:if>
                        <g:else>
                        <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick="var temp = confirm('Are you sure you want to select this group?'); if(temp){modal.addOnCloseCallbackParams('group2',${domainInstance?.id})}" value="Select"/></td>
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
    
