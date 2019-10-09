<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="icbs.admin.Branch" %>
<html>
  <head>
    <title>Periodic Operations Index</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main">
    <asset:javascript src="periodicOpsHelper.js"/>
    <g:javascript>
        
        function updateProgressBar(choice){
            if(choice==0){
                icbs.PeriodicOps.StartOfDay('progress',"${createLink(controller : 'periodicOps', action:'startOfDayProgressAjax')}");
            }
            if(choice==1){
                icbs.PeriodicOps.EndOfDay('progress',"${createLink(controller : 'periodicOps', action:'endOfDayProgressAjax')}");
            }
            if(choice==2){
                icbs.PeriodicOps.EndOfMonth('progress',"${createLink(controller : 'periodicOps', action:'endOfMonthProgressAjax')}");
            }
            if(choice==3){
                icbs.PeriodicOps.EndOfYear('progress',"${createLink(controller : 'periodicOps', action:'endOfYearProgressAjax')}");
            }
        }
        function progressBar(choice){
            if(choice==0){
                icbs.PeriodicOps.StartOfDay.Interval  = setInterval(updateProgressBar, 2000,0);
            }
            if(choice==1){
                icbs.PeriodicOps.EndOfDay.Interval  = setInterval(updateProgressBar, 2000, 1);
            }
            if(choice==2){
                icbs.PeriodicOps.EndOfMonth.Interval  = setInterval(updateProgressBar, 2000, 2);
            }
            if(choice==3){
                icbs.PeriodicOps.EndOfYear.Interval  = setInterval(updateProgressBar, 2000, 3);
            }
        }
        function processStartOfDay(){
            clearInterval(_idleTimeoutDisable)
            icbs.PeriodicOps.StartOfDay('process',"${createLink(controller : 'periodicOps', action:'startOfDay')}");
        }
        function processEndOfDay(){
            clearInterval(_idleTimeoutDisable)
            icbs.PeriodicOps.EndOfDay('process',"${createLink(controller : 'periodicOps', action:'endOfDay')}");
        }
        function processEndOfMonth(){
            icbs.PeriodicOps.EndOfMonth('process',"${createLink(controller : 'periodicOps', action:'endOfMonth')}");
        }
        function processEndOfYear(){
            icbs.PeriodicOps.EndOfYear('process',"${createLink(controller : 'periodicOps', action:'endOfYear')}");
        }
        function openStartOfDay(){
            $('#startOfDayModal').modal({show:true});
        }
        function openEndOfDay(){
            $('#endOfDayModal').modal({show:true});
        }
        function openEndOfMonth(){
            $('#endOfMonthModal').modal({show:true});
        }
        function openEndOfYear(){
            $('#endOfYearModal').modal({show:true});
        }
        icbs.Dependencies.Ajax.addLoadEvent(function(){
                $('#startOfDayModal').on('hidden.bs.modal', function () {
                   $('#startOfDayModal .bar').width(0);
                   $('#startOfDayModal .bar').text(""); 
                });
                $('#endOfDayModal').on('hidden.bs.modal', function () {
                   $('#endOfDayModal .bar').width(0);
                   $('#endOfDayModal .bar').text(""); 
                });
                $('#endOfMonthModal').on('hidden.bs.modal', function () {
                   $('#endOfMonthModal .bar').width(0);
                   $('#endOfMonthModal .bar').text(""); 
                });
                $('#endOfYearModal').on('hidden.bs.modal', function () {
                   $('#endOfYearModal .bar').width(0);
                   $('#endOfYearModal .bar').text(""); 
                });
        })
    </g:javascript>
  </head>
  <body>
    <content tag="main-content">
	<g:if test="${flash.message}">
            <script>
                $(function(){
                    var x = '${flash.message}';
                            //notify.message(x);
                            alertify.alert(AppTitle,""+x, function(){
                                  
                            });
                            console.log("asdasdasdasd");
                     });
            </script>
	</g:if>        
                <!-- Modal -->
        <div class="modal fade" id="startOfDayModal" tabindex="-1" role="dialog" aria-labelledby="startOfDay" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" id="processStartOfDay1" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="startOfDayLabel">Start Of Day</h4>
              </div>
              <div class="fieldcontain form-group">
                <label class="control-label col-sm-4"for="startOfDayDate">
                         System Run Date
                </label>
                  <div class="col-sm-8"><g:customDatePicker  disabled="disabled"name="startOfDayDate" precision="day" class="form-control"  value="${Branch.get(1).runDate}"  /></div>
              </div>
              <div class="modal-body center-block">
                <div class="progress">
                  <div class="progress-bar bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                      
                  </div>
                </div>
                <div id="message">
                      
                      
                </div>
                
                <button class="btn btn-default" id="processStartOfDay2" onclick="processStartOfDay()">Process Start Of Day</button>
                <a class="btn btn-primary" style="display:none" id="getReportsStartOfDay" href="${createLink(controller : 'periodicOps', action:'getStartOfDayReport')}">Get Report</a>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        
        
                <!-- Modal -->
        <div class="modal fade" id="endOfDayModal" tabindex="-1" role="dialog" aria-labelledby="endOfDay" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" id="processEndOfDay1" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="startOfDayLabel">End Of Day</h4>
              </div>
              <div class="fieldcontain form-group">
                <label class="control-label col-sm-4"for="endOfDayDate">
                         System Run Date
                        <span class="required-indicator">*</span>
                </label>
                  <div class="col-sm-8"><g:customDatePicker  disabled="disabled"name="endOfDayDate" precision="day" class="form-control"  value="${Branch.get(1).runDate}"  /></div>
              </div>
              <div class="modal-body center-block">
                <div class="progress">
                  <div class="progress-bar bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                      
                  </div>
                </div>
                <div id="message">
                      
                      
                </div>
                <button class="btn btn-default" id="processEndOfDay2" onclick="processEndOfDay()">Process End Of Day</button>
                <a class="btn btn-primary" style="display:none"id="getReportsEndOfDay" href="${createLink(controller : 'periodicOps', action:'getEndOfDayReport')}">Get Report</a>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
            </div><!-- /.modal-content -->
          </div><!-- /.modal-dialog -->
        </div><!-- /.modal --> 
        <script>
        $('#endOfDayModal').on('hidden.bs.modal', function () {
            location.reload();
        })
        </script>
        <ul>
            <table class="table table-bordered table-rounded table-striped table-hover">
		<thead>
                    <tr>
			<th>Process</th>
                        <th>Action</th>
                    </tr>
		</thead>
		<tbody>            
                    <tr>
                        <td>Start of Day Processing</td>
			<td><button class="btn btn-default" onclick="openStartOfDay()">Start Of Day</button></td>
                    </tr>
                    <tr>
                        <td>End of Day Processing</td>
                        <td><button class="btn btn-default" onclick="openEndOfDay()">End Of Day</button></td>
                    </tr>

                </tbody>

        </ul>
    </content>
    <content tag="main-actions">
        <ul>
            <li><a class="home" href="${createLink(uri: '/')}">Back to Home</a></li>
            <li><g:link class="lockSystem" action="lockSystem">Lock System for Periodic Operations</g:link></li>
            <li><g:link class="unlockSystem" action="unlockSystem">Unlock System for Periodic Operations</g:link></li>
            <li><g:link class="EODCheck" action="EODCheck">EOD Checking</g:link></li>
            <li><g:link class="eodReports" action="eodReport">EOD Reports</g:link></li>
            <li><g:link class="eomReports" action="eomReport">EOM Reports</g:link></li>
            <li><g:link class="periodicOpsUtil" action="periodicOpsUtil">Periodic Operations Utilities</g:link></li>
        </ul>
    </content>
  </body>
</html>
