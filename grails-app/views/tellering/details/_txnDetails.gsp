
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller:'tellering', action:'search')}");
    $(document).ready(function() {
        $('#searchForm').on('submit', function(e){
            e.preventDefault();
        });
    });
</g:javascript>

<div name="inlineSearchDiv" id="inlineSearchDiv">
    <g:form id="searchForm" name="searchForm" url="[controller:tellering, action:'search']">
    <div class="row">
        <div class="col-md-12">
            <div class=" col-md-2">
                <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm "onchange="searchVar.searchMe();" />
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
                        <g:sortableColumn property="id" title="${message(code: 'txnFile.id', default: 'ID')}" />
                    
                        <g:sortableColumn property="code" title="Transaction Code" />
                    
                        <g:sortableColumn property="acctNo" title="Account Number" />
                    
                        <g:sortableColumn property="txnAmt" title="Transaction Amount" />
                        <g:sortableColumn property="txnRef" title="Transaction Ref" />
                        <g:sortableColumn property="txnParticulars" title="Transaction Pariculars" />
                        <g:sortableColumn property="txnDescription" title="Transaction Desc" />
                        <td><label>Action</label></td>
                    </tr>
                </tbody>
                <tbody>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                    <tr>
                        <td>${fieldValue(bean: domainInstance, field: "id")}</td>

                        <td>${domainInstance?.txnCode}</td>

                        <td>${domainInstance?.acctNo}</td>
                    
                        <td><g:formatNumber number="${domainInstance?.txnAmt}" format="###,##0.00" /></td>
                        <td>${domainInstance?.txnRef}</td>
                        <td>${domainInstance?.txnParticulars}</td>
                        <td>${domainInstance?.txnParticulars}</td>
                        <g:if test="${params.actionTemplate}">
                        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
                        <g:render template="actionTemplate/${params.actionTemplate}" model="[txnFileInstance:domainInstance]"/>
                        </g:if>
                        <g:else>
                        <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick="var temp = confirm('Are you sure you want to select this transaction?'); if(temp){modal.addOnCloseCallbackParams('txnFile2',${domainInstance?.id})}" value="Select"/></td>
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
    
