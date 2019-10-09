
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller:'loanApplication', action:'search')}");
    $(document).ready(function() {
        $('#searchForm').on('submit', function(e){
            e.preventDefault();
        });
    });
</g:javascript>

<div name="inlineSearchDiv" id="inlineSearchDiv">
    <g:form id="searchForm" name="searchForm" url="[controller:loanApplication, action:'search']">
    <div class="row">
        <div class="col-md-12">
            <div class=" col-md-2">
                <g:select name="max" value="${params.max}" from="[25 , 50 , 75 , 100]" class="form-control input-sm "onchange="searchVar.searchMe();" />
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
                        <g:sortableColumn property="id" title="${message(code: 'loanApplication.id', default: 'ID')}" />
                        
                        <g:sortableColumn property="customer.displayName" title="${message(code: 'loanApplication.customer.label', default: 'Customer')}" />
                    
                        <g:sortableColumn property="product.name" title="${message(code: 'loanApplication.product.label', default: 'Product')}" />

                        <g:sortableColumn property="amount" title="${message(code: 'loanApplication.amount.label', default: 'Amount')}" />

                        <g:sortableColumn property="applicationDate" defaultOrder="desc" title="${message(code: 'loanApplication.applicationDate.label', default: 'Application Date')}" />

                         <g:sortableColumn property="applicationDate" title="${message(code: 'loanApplication.approvalStatus.label', default: 'Status')}" />
                        
                        <td><label>Action</label></td>
                    </tr>
                </tbody>
                <tbody>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                    <tr>
                        <td>${fieldValue(bean: domainInstance, field: "id")}</td>

                        <td>${domainInstance?.customer?.displayName}</td>                      
                    
                        <td>${domainInstance?.product?.name}</td>
                    
                        <td><g:formatNumber format="###,##0.00" number="${domainInstance?.amount}" /></td>

                        <td><g:formatDate format="MM/dd/yyyy" date="${domainInstance?.applicationDate}"/></td>
                        
                        
                        <td>${domainInstance?.approvalStatus}</td>
                                                    
                        <g:if test="${params.actionTemplate}">
                        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
                        <g:render template="actionTemplate/${params.actionTemplate}" model="[loanApplicationInstance:domainInstance]"/>
                        </g:if>
                        <g:else>
                        <td><input type="button"class="btn btn-secondary" data-dismiss="modal" onclick="var temp = confirm('Are you sure you want to select this loan application?'); if(temp){modal.addOnCloseCallbackParams('loanApplication2',${domainInstance?.id})}" value="Select"/></td>
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