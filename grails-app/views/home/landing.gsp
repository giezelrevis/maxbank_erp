<%@ page import="icbs.tellering.TxnTellerBalance" %>
<%@ page import="icbs.tellering.TxnTellerCash" %>
<!DOCTYPE html>
<html>
    <head>
            <meta name="layout" content="main">
            <title>Home</title>
            
    </head>
    <body>
	<content tag="main-content">
            
            <g:if test="${flash.error}">
                    <!-- <div class="box-body">
                        <div class="alert alert-danger alert-dismissable">
                            <i class="fa fa-exclamation"></i>
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <b>Message</b> <div class="message" role="status">${flash.error}</div>
                        </div>
                    </div> -->
                <script>
                    $(function(){
                        var x = '${flash.error}';
                        notify.error(x);
                    });
                </script>
	    </g:if>
	    <g:if test="${flash.success}">
                    <!-- <div class="box-body">
                            <div class="alert alert-info alert-dismissable">
                                    <i class="fa fa-info"></i>
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                    <b>Message</b> <div class="message" role="status">${flash.success}</div>
                            </div>
                    </div> --> 
                <script>
                    $(function(){
                        var x = '${flash.success}';
                        notify.message(x);
                    });
                </script>
            </g:if>
            <g:if test="${userInstance.designation.id==2}">
            <g:set var="w" value="${0}" />
            <g:set var="x" value="${0}" />
            <g:set var="y" value="${0}" />
            <g:set var="z" value="${0}" />
            <g:each in="${tbCash}" status="i" var="tbc">
            <g:if test="${tbc?.txnFile.txnDate == tbc?.branch?.runDate}">
                <g:set var="w" value="${w + tbc?.cashInAmt}" /> 
                <g:set var="x" value="${x + tbc?.cashOutAmt}" />
                <g:set var="y" value="${y + tbc?.checkInAmt}" />
                <g:set var="z" value="${z + tbc?.checkOutAmt}" />    
            </g:if> 
            </g:each>
        <div class="row">
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-aqua">
                <div class="inner">
                    <h3><span><g:formatNumber number="${w}" format="###,###,##0.00" /></span></h3>
                  <p>Cash In</p>
                </div>
                <div class="icon">
                  <i class="fa fa-money"></i>
                </div>
              </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-green">
                <div class="inner">
                  <h3><span><g:formatNumber number="${x}" format="###,###,##0.00" /></span></h3>
                  <p>Cash Out</p>
                </div>
                <div class="icon">
                  <i class="fa fa-briefcase"></i>
                </div>
              </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-yellow">
                <div class="inner">
                  <h3><g:formatNumber number="${w-x}" format="###,###,##0.00" /></h3>
                  <p>Ending Cash</p>
                </div>
                <div class="icon">
                  <i class="fa fa-slack"></i>
                </div>
              </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
              <!-- small box -->
              <div class="small-box bg-red">
                <div class="inner">
                  <h3><g:formatNumber number="${y}" format="###,###,##0.00" /></h3>

                  <p>Check In</p>
                </div>
                <div class="icon">
                  <i class="fa fa-slack"></i>
                </div>
              </div>
            </div>
        <!-- ./col -->
      </div>
        
      <div class="row">
        <div class="col-md-6">
           <!-- BAR CHART -->
          <div class="box box-success">
            <div class="box-header with-border">
              <h3 class="box-title">Bar Chart</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body">
              <div class="chart">
                <div id="bar-chart" style="height:230px"></div>
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

        </div>
        <!-- /.col (LEFT) -->
        <div class="col-md-6">
          <!-- LINE CHART -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Line Chart</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body">
              <div class="chart">
                <div id="line-chart" style="height: 230px;"></div>
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      </div>
    </g:if>
      <!-- /.row -->
            <h3>System Messages</h3>
            <table class="table table-bordered table-rounded table-striped table-hover">
                <thead>
                    <tr>					
                        <th width="20%">Sender</th>
                        <th width="20%">Subject</th>
			<!-- <th width="45%">Message</th> -->					
			<th width="15%">Date</th>					
                    </tr>
		</thead>
		<tbody>
                    <g:each in="${userMessageInstanceList}" status="i" var="userMessageInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">					
                            <td>${fieldValue(bean: userMessageInstance, field: "sender.name")}</td>
                            <g:if test="${userMessageInstance.isRead == true}" >
				<td><g:link controller="UserMessage" action="show" id="${userMessageInstance.id}">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></td>
                            </g:if>
                            <g:else>
				<td><strong><g:link controller="UserMessage" action="show" id="${userMessageInstance.id}" class="bold">${fieldValue(bean: userMessageInstance, field: "subject")}</g:link></strong></td>
                            </g:else>					
                            <!-- <td>${fieldValue(bean: userMessageInstance, field: "body")}</td> -->
                            <td>${fieldValue(bean: userMessageInstance, field: "sentAt")}</td>					
			</tr>
                    </g:each>
		</tbody>
            </table>
            
          
        </content>
	<content tag="main-actions">
            <ul>
                            <!--
				<li><g:link uri="/userMaster/create">New User</g:link></li>
				<li><g:link uri="/branch">Branches</g:link></li>
				<li><g:link uri="">Print Reports</g:link></li>
				<li><g:link uri="">Calendars</g:link></li>
                                <li><g:link controller="customer">CIF Index</g:link></li>
                                <li><g:link controller="deposit" action="depositSearch">Deposits Index</g:link></li>
                                <li><g:link controller="tellering">Tellering Index</g:link></li>
                                <li><g:link url="../ATMInterface">ATM Transaction Screen</g:link></li>
                            -->
                <li><g:link uri="/userMessage/create">New Message</g:link></li>                           
                <g:if test="${userInstance.designation.id==1}">
                    <li><g:link uri="/userMaster">User Management</g:link><li>
                    <li><g:link controller="product" action="index">Product Configuration</g:link><li>    
                    <li><g:link uri="/periodicOps">Periodic Operations</g:link><li>
                    <li><g:link controller="Holiday" action="index">Holiday Configuration</g:link><li>  
                    <li><g:link controller="Branch" action="index">Branch Administration</g:link><li>
                </g:if>   
                            
                <g:if test="${userInstance.designation.id==2}">
                    <li><g:link controller="customer" action="create">New Customer</g:link></li>
                    <li><g:link uri="/tellering">Tellering Index</g:link><li>
                </g:if>        
            </ul>
            
        </content>
        
</body>
</html>
