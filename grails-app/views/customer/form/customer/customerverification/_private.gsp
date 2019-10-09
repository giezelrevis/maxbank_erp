<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<g:if test="${customerInstance?.id}">
    <g:hiddenField id="id" name="id" value="${customerInstance.id}"/>
</g:if>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
            Customer Type
	</label>
	 <div class="col-sm-8">
            <g:hiddenField name="type.id" value="${customerInstance?.type?.id}"/>
            <g:select id="type" onchange="changeVerificationForm()" disabled="disabled"name="type.id" from="${icbs.lov.CustomerType.findAllByStatusAndIdNotInList(true,['4'])}" optionKey="id" optionValue ="description" value="${customerInstance?.type?.id}" class="form-control" />
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
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'title', 'has-error')} ">
	<label class="control-label col-sm-4" for="title">
		<g:message code="customer.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
      
	<div class="col-sm-8"><g:select id="title" name="title.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndIdNotEqual("CT",true,65)}" optionKey="id" optionValue ="itemValue" value="${customerInstance?.title?.id}"class="form-control" noSelection="['null': '']"/></div>
        <g:hasErrors bean="${customerInstance}" field="title">
            <div class="controls">
                <span class="help-block">
                    <g:eachError bean="${customerInstance}" field="title">
                        <g:message error="${it}" /><br/>
                    </g:eachError>
                </span>
            </div>
        </g:hasErrors>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'name1', 'has-error')} ">
	<label class="control-label col-sm-4" for="name1">
		<g:message code="customer.name1.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
        
	<div class="col-sm-8">  
            <g:textField onchange="icbs.Customer.Form.Utilities.appendToDisplayName()" id="name1"name="name1" maxlength="50" ="" value="${customerInstance?.name1}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="name1">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="name1">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>   
</div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'name2', 'has-error')} ">
	<label class="control-label col-sm-4" for="name2">
		<g:message code="customer.name2.label" default="Middle Name" />
		
	</label>
	<div class="col-sm-8">
            <g:textField onchange="icbs.Customer.Form.Utilities.appendToDisplayName()" id="name2" name="name2" maxlength="50" ="" value="${customerInstance?.name2}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="name2">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="name2">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'name3', 'has-error')} ">
	<label class="control-label col-sm-4" for="name3">
		<g:message code="customer.name3.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:textField onchange="icbs.Customer.Form.Utilities.appendToDisplayName()" id="name3" name="name3" maxlength="50" ="" value="${customerInstance?.name3}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="name3">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="name3">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>
</div>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'name4', 'has-error')} ">
	<label class="control-label col-sm-4" for="name4">
		<g:message code="customer.name4.label" default="Initials" />
		
	</label>
	<div class="col-sm-8">
            <g:textField onchange="icbs.Customer.Form.Utilities.appendToDisplayName()" id="name4" name="name4" maxlength="50" ="" value="${customerInstance?.name4}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="name4">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="name4">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'gender', 'has-error')} ">
	<label class="control-label col-sm-4" for="gender">
		<g:message code="customer.gender.label" default="Gender" />
                <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:select id="gender" name="gender.id" from="${icbs.lov.Gender.findAllByIdNotInListAndStatus(['1'],true)}" optionKey="id" optionValue ="description" value="${customerInstance?.gender?.id}" class="form-control" noSelection="['null': '']"/>
            <g:hasErrors bean="${customerInstance}" field="gender">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="gender">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'birthDate', 'has-error')} ">
	<label class="control-label col-sm-4" for="birthDate">
		<g:message code="customer.birthDate.label" default="Birth Date" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:customDatePicker name="birthDate" value="${customerInstance?.birthDate}"class="form-control"  />
            <g:hasErrors bean="${customerInstance}" field="birthDate">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="birthDate">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>      
        </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'civilStatus', 'has-error')} ">
	<label class="control-label col-sm-4"for="civilStatus">
            Civil Status
                     <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:select id="civilStatus" name="civilStatus.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndItemCodeNotInList("CS",true,['0'])}" optionKey="id" optionValue ="itemValue" value="${customerInstance?.civilStatus?.id}" class="form-control" noSelection="['null': '']"/>
            <g:hasErrors bean="${customerInstance}" field="civilStatus">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="civilStatus">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>    
        </div>
</div>
<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'birthPlace', 'has-error')} ">
	<label class="control-label col-sm-4" for="birthPlace">
		<g:message code="customer.birthPlace.label" default="Birth Place" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:textField name="birthPlace" maxlength="50"  value="${customerInstance?.birthPlace}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="birthPlace">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="birthPlace">
                            <g:message error="${it}" /><br/>
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
                              
                                <td>Name3</td>
                                <td>Name4</td>
                                <td>Gender</td>
                            </tr>
                            <g:each var="customer" in="${duplicateList}">
                                <tr>
                                    <td>${customer.name1}</td>
                              
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
                    <g:if test="${!onsubmit}">
                        <a href="#" class="btn btn-primary" data-dismiss="modal" onclick="callback(true)">No Duplicate. Please Continue</a>
                    </g:if>
                    <g:else>
                        <a href="#" class="btn btn-primary" data-dismiss="modal" onclick="$('#saveCustomerForm').submit()">No Duplicate. Please Continue</a>
                    </g:else>
                </div>
            </div>
        </div>
    </div>