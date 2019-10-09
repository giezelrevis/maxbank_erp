
<%@ page import="icbs.admin.UserMaster" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userMaster.label', default: 'UserMaster')}" />
		<title>EOD Pre-Validation Checking</title>
	</head>
	<body>

            <content tag="main-content">
		<div id="list-userMaster" class="content scaffold-list" role="main">
			<g:if test="${flash.message}">
                <!-- <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div> -->
                            <script>
                                $(function(){
                                    var x = '${flash.message}';
                                        notify.message(x);
                                });
                            </script>
            </g:if>
        <h3>List of Logged Users</h3>    
	<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                    <tr>
			<g:sortableColumn property="username" title="${message(code: 'userMaster.username.label', default: 'User Name')}" />
                        <g:sortableColumn property="branch" title="${message(code: 'userMaster.branch.label', default: 'Branch Name')}" />
                        <g:sortableColumn property="login" title="${message(code: 'userSession.login.label', default: 'Login')}" />
                    </tr>
		</thead>
		<tbody>
                    <g:each in="${loggedUserList}" status="i" var="loggedUserInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>${loggedUserInstance.userMaster.username}</td>
                            <td>${loggedUserInstance.userMaster.branch.name}</td>
                            <td>${loggedUserInstance.login}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
        <h3>List of Un-Balanced Users</h3> 
	<div class="table-responsive">
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
					<tr>

						<g:sortableColumn property="username" title="${message(code: 'userMaster.username.label', default: 'Username')}" />

						<g:sortableColumn property="name1" title="${message(code: 'userMaster.name1.label', default: 'Full Name')}" />

						<g:sortableColumn property="branch" title="${message(code: 'userMaster.branch.label', default: 'Branch')}" />

						<g:sortableColumn property="designation" title="${message(code: 'userMaster.designation.label', default: 'Designation')}" />

						<g:sortableColumn property="configItemStatus" title="${message(code: 'currency.configItemStatus.label', default: 'Status')}" />
                                                
                                                <g:sortableColumn property="isLocked" title="${message(code: 'userMaster.isLocked.label', default: 'Locked')}" />
                                                
                                                <g:sortableColumn property="isTellerBalanced" title="${message(code: 'userMaster.isTellerBalanced.label', default: 'Balanced')}" />
                                                <th>Action</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${userMasterInstanceList}" status="i" var="userMasterInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td>${fieldValue(bean: userMasterInstance, field: "username")}</td>

						<td>${fieldValue(bean: userMasterInstance, field: "name1") + " " + fieldValue(bean: userMasterInstance, field: "name2") + " " + fieldValue(bean: userMasterInstance, field: "name3")} </td>

						<td>${fieldValue(bean: userMasterInstance, field: "branch.name")}</td>

						<td>${fieldValue(bean: userMasterInstance, field: "designation.description")}</td>

                                                <g:if test="${userMasterInstance.configItemStatus.description == 'Active'}">
                                                    <td>Active</td>
                                                </g:if>
                                                <g:else>
                                                    <td>De-Activated/Deleted</td>
                                                </g:else>
                                                
                                                <g:if test="${userMasterInstance.isLocked}">
                                                    <td>Yes</td>
                                                </g:if>
                                                <g:else>
                                                    <td>No</td>
                                                </g:else>
                                                 <g:if test="${userMasterInstance.isTellerBalanced}">
                                                    <td>Yes</td>
                                                </g:if>
                                                <g:else>
                                                    <td>No</td>
                                                </g:else>
                                                    <td><a href="#" onclick="forceBalanceUser(${userMasterInstance.id});" class="btn btn-primary">Force Balance User</a></td>
					</tr>
				</g:each>
				</tbody>
			</table>
                     </div>
            <h3>List of Users with Cash</h3> 
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                    <tr>
			<g:sortableColumn property="userId" title="${message(code: 'txnTellerBalance.user.label', default: 'Username')}" />
			<g:sortableColumn property="branch" title="${message(code: 'txnTellerBalance.user.branch.label', default: 'Branch')}" />
                        <g:sortableColumn property="cashIn" title="${message(code: 'txnTellerBalance.cashIn.label', default: 'Cash In')}" />
                        <g:sortableColumn property="cashOut" title="${message(code: 'txnTellerBalance.cashOut.label', default: 'Cash Out')}" />
                    </tr>
		</thead>
		<tbody>
                    <g:each in="${txnCashList}" status="i" var="txnCashInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>${txnCashInstance?.user?.username}</td>
                            <td>${txnCashInstance?.user?.branch?.name}</td>
                            <td><g:formatNumber format="###,###,##0.00" number="${txnCashInstance?.cashIn}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${txnCashInstance?.cashOut}"/></td>
                        </tr>
                    </g:each>
		</tbody>
            </table>

            <h3>List of Loans Approved but not yet disbursed</h3> 
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                    <tr>
			<g:sortableColumn property="accountNo" title="${message(code: 'loan.accountNo.label', default: 'Loan Account')}" />
			<g:sortableColumn property="branch" title="${message(code: 'loan.branch.label', default: 'Branch')}" />
                        <g:sortableColumn property="totalDisbursementAmount" title="${message(code: 'loan.totalDisbursementAmount.label', default: 'Amount Disbursed')}" />
                        <g:sortableColumn property="totalNetProceeds" title="${message(code: 'loan.totalNetProceeds.label', default: 'Net Proceeds')}" />
                        <g:sortableColumn property="dateApproved" title="${message(code: 'loan.totalNetProceeds.label', default: 'Date Approved')}" />
                    </tr>
		</thead>
		<tbody>
                    <g:each in="${loanInstanceList}" status="i" var="loanInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>${loanInstance.accountNo}</td>
                            <td>${fieldValue(bean: loanInstance, field: "branch.name")}</td>
                            <td><g:formatNumber format="###,###,##0.00" number="${loanInstance?.totalDisbursementAmount}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${loanInstance?.totalNetProceeds}"/></td>
                            <td><g:formatDate format="yyyy-MM-dd" date="${loanInstance?.dateApproved}" /></td>
                        </tr>
                    </g:each>
		</tbody>
            </table>
            <h3>List of Un-Posted GL Batch</h3>
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                    <tr>
                        <g:sortableColumn property="branch" title="Branch" />
                        <g:sortableColumn property="id" title="Batch#" />
                        <g:sortableColumn property="batchName" title="Batch Name" />
                        <g:sortableColumn property="createdBy" title="User" />
                    </tr>    
                </thead>  
		<tbody>
                    <g:each in="${unpostedGlList}" status="i" var="upGl">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>${upGl?.branch?.name}</td>
                            <td>${upGl?.id}</td>
                            <td>${upGl?.batchName}</td>
                            <td>${upGl?.createdBy?.username}</td>
                        </tr>
                    </g:each>
		</tbody>
            </table>
            <!--
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                    <tr>
			<td><label>GL Account Check</label></td>
                        <td><label>Status</label></td>
                    </tr>
		</thead>
		<tbody>
                    <tr>
                        <td>Cashier Checks</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>MB Transitoria</td>
                        <td></td>
                    </tr>                    
		</tbody>
            </table>
            -->
            <script>
                function forceBalanceUser(userMasterId){
                var userIdMaster = userMasterId;
                    alertify.confirm(AppTitle,"Are you sure you want to force balance this user?",
                        function(){
                            
                            console.log("xxxxxx: "+userMasterId);
                            var obj = { 
                                    id: userIdMaster,
                            }; 
                            //console.log(JSON.stringify(obj));
                            $.ajax({
                                type: "POST",
                                contentType: "application/json",
                                url: "${createLink(controller:'tellering', action: 'forceBalancePerUser')}",
                                data: JSON.stringify(obj),

                                success: function(data){
                                    if(data.length > 0){

                                        alertify.alert(AppTitle,"Congratulations, you have force balanced the user", function(){
                                            location.reload();
                                        });
                                    }
                                },
                                error: function(data){
                                    console.log(data);
                                },

                            });
                        },
                        function(){
                          alertify.error('Canceled');
                        }
                    );
                    
                }
            </script>    
	</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}">Back to Home</a></li>
                    <li><g:link class="index" action="index">Periodic Operations Index</g:link></li>
                    <g:if test="${userMasterInstanceList}">
                        <li><a href="#" onClick="confirmForceBalanceAllUsers();" >Force Balance All Users</a></li>
                    </g:if>
                    <g:else>
                        <li><a href="#" class="disabled" disabled="disable">Force Balance All Users</a></li>
                    </g:else>    
		</ul>
                <script>
                    function confirmForceBalanceAllUsers(){
                        var forceBalanceNow = "true";
                        alertify.confirm(AppTitle,"Are you sure you want to Force balance ALL Users?",
                            function(){
                            var obj = { 
                                id: forceBalanceNow,
                            }; 
                            //console.log(JSON.stringify(obj));
                            $.ajax({
                                type: "POST",
                                contentType: "application/json",
                                url: "${createLink(controller:'tellering', action: 'forceBalanceAllUser')}",
                                data: JSON.stringify(obj),

                                success: function(data){
                                    if(data.length > 0){

                                        alertify.alert(AppTitle,"Congratulations, you have force balanced all users", function(){
                                            location.reload();
                                        });
                                    }
                                },
                                error: function(data){
                                    console.log(data);
                                },

                            });
                            },
                            function(){
                              alertify.error('Canceled!');
                            }
                        );
                    }
                </script>
            </content>
	</body>
</html>
