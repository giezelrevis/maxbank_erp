<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>View Teller Transactions with GL Entries</title>
    </head>
    <body>
        <content tag="main-content">
            <div id="grid">
                <g:form url="[action:'viewTellerOtherTxn',controller:'Tellering']">
                        <div class="row">
                            <div class=" col-md-2">
                                <g:select name="max" value="${params.max}" from="[5, 10, 15, 20]" class="form-control input-sm" onchange="this.form.submit()" />
                            </div>
                            
                            <div class="input-group col-md-10 right" >
                                <input id="searchQuery"name="query"type="text" class="form-control" value="${params?.query}" onchange="this.form.submit()" placeholder="Enter Transaction ID">
                                <span class="input-group-btn">
                                  <g:submitButton name="search" value="Search" class="btn btn-primary" />
                                </span>
                            </div><!-- /input-group -->
                        </div><!-- /.col-lg-6 -->
                </g:form>
                <div class="table-responsive">
                    <table class="table table-hover table-condensed table-bordered table-striped">
                        <tbody>
                            <tr>    
                                <td><label>Transaction ID</label></td>                    
                                <td><label>Transaction Type</label></td>          
                                <td><label>Amount</label></td>
                                <td><label>Reference</label></td>
                                <td><label>Action</label></td>
                            </tr>
                        </tbody>   
                        <tbody>
                            <g:each in="${otherTxn}" status="i" var="txn">
                                <tr>
                                    <td>${txn.id}</td>
                                    <td>${txn.txnTemplate.description}</td>
                                    <td><g:formatNumber number="${txn.txnAmt}" format="###,###,##0.00" /></td>
                                    <td>${txn?.txnRef}</td>
                                    <td><g:link class="btn btn-primary" action="showGlEntries" id="${txn.id}">View</g:link></td>
                                </tr>
                            </g:each>                                
                        </tbody>
                    </table>
                    <div class="pagination">
				<g:paginate total="${otherTxnInstanceCount ?: 0}" params="${params}" />
                    </div>
              </div>
            </div>    
        </content>    
        <content tag="main-actions">
            <ul>
                <li><g:link action="Index">Tellering Index</g:link></li>
                <li><g:link action="viewTellerBalancing">Teller Balancing</g:link></li>
            </ul>
        </content>        
    </body>    
</html>
