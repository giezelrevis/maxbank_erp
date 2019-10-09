<%@ page import="icbs.deposit.Rollover" %>
<%@ page import="icbs.admin.Branch" %>
<%@ page import="icbs.admin.UserMaster" %>
<fieldset>
<div id="rolloverForm">
   <!-- <g:textField id="roll1" name="roll1" value="CURROLTYPEID+ ${currentRollover?.type?.id}"/>
    <g:textField id="roll2" name="roll2" value="DEPCURROLTYPE+ ${depositInstance?.currentRollover?.type?.id}"/>
    <g:textField id="roll3" name="roll3" value="INTPAYMODE+ ${interestPaymentMode}"/>
    <g:textField id="roll4" name="roll4" value="DEPINTMODID+ ${depositInstance?.currentRollover?.interestPaymentMode?.id}"/>-->
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.type', 'has-error')} required">
            <label class="control-label col-sm-4" for="status">
                    <g:message code="rollover.type.label" default="Rollover Type" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8"><g:select onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)" id="currentRollover.type" name="currentRollover.type.id" from="${icbs.lov.RolloverType.list()}" optionKey="id" optionValue="description" value="${depositInstance? depositInstance.currentRollover?.type?.id:currentRollover.type?.id}" class="many-to-one form-control"/>

                <g:hasErrors bean="${depositInstance}" field="currentRollover.type">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>  
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.startDate', 'has-error')} required">
            <label class="control-label col-sm-4" for="startDate">
                    <g:message code="rollover.startDate.label" default="Start Date" />
                    <span class="required-indicator">*</span>
            </label>
            <g:hiddenField name="currentRollover.startDate" precision="day" class="form-control"  value="${depositInstance ? depositInstance?.currentRollover?.startDate?:Branch?.get(1).runDate.format("MM/dd/yyyy"):currentRollover?.startDate.format("MM/dd/yyyy")}"  />
            <div class="col-sm-8"><g:field format="date" readonly="true" name="currentRollover.startDate" precision="day" class="form-control"  value="${depositInstance ? depositInstance?.currentRollover?.startDate?:Branch?.get(1).runDate.format("MM/dd/yyyy"):currentRollover?.startDate.format("MM/dd/yyyy")}"  />

                <g:hasErrors bean="${depositInstance}" field="currentRollover.startDate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.startDate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
 
    <g:hiddenField id="endDateCalculator" name="endDateCalculator" value="${depositInstance ? depositInstance?.currentRollover?.endDate?:Branch?.get(1).runDate +depositInstance?.fixedDepositTermScheme?.value.toInteger():currentRollover?.endDate}"/>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.endDate', 'has-error')} required">
            <label class="control-label col-sm-4" for="endDate">
                    <g:message code="rollover.endDate.label" default="End Date" />
                    <span class="required-indicator">*</span>
            </label>
            <!--<div class="col-sm-8"><g:field name="currentRollover.endDate" readonly="true" precision="day" class="form-control"  value="${depositInstance ? depositInstance?.currentRollover?.endDate?:Branch?.get(1).runDate +depositInstance?.fixedDepositTermScheme?.value.toInteger():currentRollover?.endDate}" />-->
            <div class="col-sm-8"><g:customDatePicker name="currentRollover.endDate" precision="day" class="form-control" onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)"  value="${depositInstance ? depositInstance?.currentRollover?.endDate?:Branch?.get(1).runDate +depositInstance?.fixedDepositTermScheme?.value.toInteger():currentRollover?.endDate}"  />
                <g:hasErrors bean="${depositInstance}" field="currentRollover.endDate">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.endDate">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            </div>             
    </div>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'currentRollover.interestPaymentMode', 'has-error')} ">
<!--        <label class="control-label col-sm-4" for="interestPaymentMode">
            <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
        </label>
        <div class="col-sm-8"><g:select onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)" id="currentRollover.interestPaymentMode" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.getAll()}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/> 
        </div>-->
                    <g:if test="${(currentRollover?.type?.id==1 || depositInstance?.currentRollover?.type?.id==1)}">
                         <label class="control-label col-sm-4" for="interestPaymentMode">
                            <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
                        </label>
                        <div class="col-sm-8"><g:select onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)" id="currentRollover.interestPaymentMode" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([2,3])}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
                        </div> 
                    </g:if>
                    <g:elseif test="${currentRollover?.type?.id==2 || depositInstance?.currentRollover?.type?.id==2}">
                         <label class="control-label col-sm-4" for="interestPaymentMode">
                            <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
                        </label>
                        <div class="col-sm-8"><g:select onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)" id="currentRollover.interestPaymentMode" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([3])}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
                        </div> 
                    </g:elseif>
                    <g:elseif test="${currentRollover?.type?.id==3 || depositInstance?.currentRollover?.type?.id==3}">
                         <label class="control-label col-sm-4" for="interestPaymentMode">
                            <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
                        </label>
                        <div class="col-sm-8"><g:select onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)" id="currentRollover.interestPaymentMode" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.findAllByIdNotInList([1,2])}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/> 
                        </div> 
                    </g:elseif>
                    <g:elseif test="${!currentRollover?.type?.id && !depositInstance?.currentRollover?.type?.id && !interestPaymentMode}">
                         <label class="control-label col-sm-4" for="interestPaymentMode">
                            <g:message code="rollover.interestPaymentMode.label" default="Interest Payment Mode" />
                        </label>
                        <div class="col-sm-8"><g:select onchange="changeRolloverForm(document.getElementById('currentRollover.type').value)" id="currentRollover.interestPaymentMode" name="currentRollover.interestPaymentMode.id" from="${icbs.lov.InterestPaymentMode.getAll()}" optionKey="id" optionValue="description"value="${depositInstance?.currentRollover?.interestPaymentMode?.id?depositInstance?.currentRollover?.interestPaymentMode?.id:interestPaymentMode}" class="many-to-one form-control" noSelection="['null': '']"/>
                        </div>
                    </g:elseif>

                <g:hasErrors bean="${depositInstance}" field="currentRollover.interestPaymentMode">
                    <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${depositInstance}" field="currentRollover.interestPaymentMode">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                    </div>
                </g:hasErrors>
            <!--</div>-->          
    </div>
     <g:if test="${interestPaymentMode=='2'||depositInstance?.currentRollover?.interestPaymentMode?.id==2}">
        <g:hiddenField name="currentRollover.fundedDeposit" id="currentRollover.fundedDeposit.id" value="${currentRollover?.fundedDeposit?.id}"/>
        <g:hiddenField name="oldfundedDeposit" id="oldfundedDeposit.id" value="${currentRollover?.fundedDeposit?.id}"/>
         <fieldset class="form-group">
            <div id="rollbackDepositDetailsDiv">
                <g:render template='/deposit/details/depositDetails' model="[depositInstance:currentRollover?.fundedDeposit,boxName:'Transfer to Deposit Account']"/>
            </div>
            <input type="button" href="#"class="btn btn-secondary"onclick="initializeRollbackToDepositModal();modal.show()"value="Search"/>
        </fieldset>
     </g:if> 
</div> 
</fieldset>
