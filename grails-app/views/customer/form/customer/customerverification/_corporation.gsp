<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${customerInstance?.id}">
    <g:hiddenField id="id" name="id" value="${customerInstance.id}"/>
</g:if>
<g:hiddenField id="title" name="title.id" value="65" />
<g:hiddenField id="gender" name="gender.id" value="1" />
<g:hiddenField id="civilStatus" name="civilStatus.id" value="27" />
<g:hiddenField id="birthPlace" name="birthPlace" value="NA" />
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
            Customer Type
	</label>
	 <div class="col-sm-8">
            <g:hiddenField name="type.id" value="${customerInstance?.type?.id}"/>
            <g:select id="type" onchange="changeVerificationForm(2)" disabled="disabled" name="type.id" from="${icbs.lov.CustomerType.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.type?.id}" class="form-control" />
            <g:hasErrors bean="${customerInstance}" field="type">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="type">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>    
         </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'group', 'has-error')} ">
	<label class="control-label col-sm-4"for="group">
            Customer Group
	</label>
	<div class="col-sm-8">
            <g:select id="group" name="group.id" from="${icbs.admin.CustomerGroup.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue ="name" value="${customerInstance?.group?.id}" class="form-control" />
            <g:hasErrors bean="${customerInstance}" field="group">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="group">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>    
        </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'name1', 'has-error')} ">
	<label class="control-label col-sm-4" for="name1">
		<g:message code="customer.name1.label" default="Company Name " />
		<span class="required-indicator">*</span>
	</label>
        
	<div class="col-sm-8">  
            <g:textField onchange="icbs.Customer.Form.Utilities.appendToDisplayName(2)" id="name1" name="name1" maxlength="50" ="" value="${customerInstance?.name1}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="name1">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="name1">
                            <%-- g:message error="${it}" / --%>Company name required!<br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>   
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'birthDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="birthDate">
		<g:message code="customer.birthDate.label" default="Registration Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:customDatePicker name="birthDate" precision="day"  value="${customerInstance?.birthDate}"class="form-control"  />
            <g:hasErrors bean="${customerInstance}" field="birthDate">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="birthDate">
                            <%-- g:message error="${it}" / --%>Valid registration date required!<br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>
</div>

<!-- The Modal for Duplicate Divs-->
    <div class="modal" id="customerDuplicateModal">
	<div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Possible Duplicate Users</h4>
                </div>
                <div class="modal-body">
                   <div id="customerDuplicateList">
                    <g:if test="${duplicateList?.size()>0}">
                        <table>
                            <tr>
                                <td>Name1</td>
                                <td>Name2</td>
                                <td>Name3</td>
                                <td>Name4</td>
                                <td>Gender</td>
                            </tr>
                            <g:each var="customer" in="${duplicateList}">
                                <tr>
                                    <td>${customer.name1}</td>
                                    <td> ${customer.name2} </td>
                                    <td> ${customer.name3} </td>
                                    <td> ${customer.name4} </td>
                                    <td> ${customer.gender?.description} </td>
                                </tr>
                            </g:each>
                        </table>
                    </g:if>
                   </div>
                </div>
                <div class="modal-footer">
                    <g:link action="customerInquiry" data-dismiss="modal" class="btn"  
                                                    onclick="return confirm('Are you sure you want to return to CIF inquiries page?');">There is a duplicate, get me out of here!</g:link>
                    <a href="#" class="btn btn-primary" data-dismiss="modal" onclick="callback(true)">No Duplicate. Please Continue</a>
                </div>
            </div>
        </div>
    </div>
