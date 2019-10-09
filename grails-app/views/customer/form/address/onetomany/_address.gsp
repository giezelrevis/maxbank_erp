<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<div id="address${i}" class="address-div">
    <g:if test="${address?.id}">
        <g:hiddenField name='addresses[${i}].id' value="${address?.id}"/>
        <g:hiddenField name='addresses[${i}].new' value="false"/>
    </g:if>
    <g:else>
        <g:hiddenField name='addresses[${i}].new' value="true"/>
    </g:else>
    <g:hiddenField name='addresses[${i}].deleted' value='false'/>
    
    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].type', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].type">
		<g:message code="address.type.label" default="Address Type" />
		
	</label>
	<div class="col-sm-8">
            <g:select id="addresses[${i}].type" name="addresses[${i}].type.id" from="${icbs.lov.AddressType.list()}" optionKey="id" optionValue="description" value="${address?.type?.id}" class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].type">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].type">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].address1', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].address1">
		<g:message code="address.address1.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:textField placeholder="Room No./Office Name, Bldg/House No., Street "name="addresses[${i}].address1" maxlength="200" value="${address?.address1}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].address1">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].address1">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].address2', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].address2">
	</label>
	<div class="col-sm-8">
            <g:textField placeholder="Subd/Barangay" name="addresses[${i}].address2" maxlength="200" value="${address?.address2}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].address2">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].address2">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
 
         <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].town', 'has-error')} ">
                <label class="control-label col-sm-4"for="addresses[${i}].town">
                        <g:message code="address.region.label" default="Town" />
                </label>
                <div class="col-sm-8">
                    <g:select noSelection="['null':'Town/City, Province']" name="addresses[${i}].town.id" from="${icbs.lov.Town.list()}" optionKey="id" value="${address?.town?.id}" class="form-control"/>
                     <g:hasErrors bean="${customerInstance}" field="addresses[${i}].town">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="addresses[${i}].town">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
        </div>
    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].countryId', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].countryId">
		<g:message code="address.countryId.label" default="Country" />
		
	</label>
	<div class="col-sm-8">
            <g:select id="addresses[${i}].countryId" name="addresses[${i}].countryId.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatus("CTRY",true)}" optionKey="id" optionValue="itemValue" value="${address?.countryId?.id}" class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].countryId">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].countryId">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].address3', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].address3">
		<g:message code="address.address3.label" default="Postal Code" />
		  <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-8">
            <g:textField name="addresses[${i}].address3" maxlength="6" value="${address?.address3}"class="form-control"/>
            
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].address3">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].address3">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    

    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].phone1', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].phone1">
		<g:message code="address.phone1.label" default="Phone 1" />
		
	</label>
	<div class="col-sm-8">
            <g:textField name="addresses[${i}].phone1" maxlength="30" value="${address?.phone1}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].phone1">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].phone1">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>

    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].phone2', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].phone2">
		<g:message code="address.phone2.label" default="Phone 2" />
		
	</label>
	<div class="col-sm-8">
            <g:textField name="addresses[${i}].phone2" maxlength="30" value="${address?.phone2}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].phone2">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].phone2">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>

    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].phone3', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].phone3">
		<g:message code="address.phone3.label" default="Fax 1" />
		
	</label>
	<div class="col-sm-8">
            <g:textField name="addresses[${i}].phone3" maxlength="30" value="${address?.phone3}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].phone3">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].phone3">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].phone4', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].phone4">
		<g:message code="address.phone4.label" default="Fax 2" />
		
	</label>
	<div class="col-sm-8">
            <g:textField name="addresses[${i}].phone4" maxlength="30" value="${address?.phone4}"class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].phone4">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].phone4">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
   
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].isMailing', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].isMailing">
		<g:message code="address.isMailing.label" default="Is Mailing" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="addresses[${i}].isMailing" value="${address?.isMailing}"/>
             <g:hasErrors bean="${customerInstance}" field="addresses[${i}].isMailing">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].isMailing">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].isMortaged', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].isMortaged">
		<g:message code="address.isMortaged.label" default="Is Mortaged" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="addresses[${i}].isMortaged" value="${address?.isMortaged}"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].isMortaged">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].isMortaged">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].isOwned', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].isOwned">
		<g:message code="address.isOwned.label" default="Is Owned" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="addresses[${i}].isOwned" value="${address?.isOwned}"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].isOwned">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].isOwned">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        
        </div>
    </div>
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].isPrimary', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].isPrimary">
		<g:message code="address.isPrimary.label" default="Is Primary Address" />
		
	</label>
	<div class="col-sm-8">
            <!-- If this is the first Address-->
            <g:if test="${i==0}">
                <g:if test="${!customerInstance?.addresses?.find{it.isPrimary == true}}">  
                    <g:checkBox name="addresses[${i}].isPrimary" checked="true" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,3)"class="address-radio"  value="${address?.isPrimary}" />
                </g:if>
                <g:else>
                    <g:checkBox name="addresses[${i}].isPrimary" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,3)"class="address-radio"  value="${address?.isPrimary}" />
                </g:else>
            </g:if>
            <g:else>
                <g:checkBox name="addresses[${i}].isPrimary" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,3)"class="address-radio"  value="${address?.isPrimary}" />
            </g:else> 
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].isPrimary">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].isPrimary">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    
    
    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].isRented', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].isRented">
		<g:message code="address.isRented.label" default="Is Rented" />
		
	</label>
	<div class="col-sm-8">
            <g:checkBox name="addresses[${i}].isRented" value="${address?.isRented}"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].isRented">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].isRented">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        
        </div>
    </div>

    <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'addresses['+i+'].addressSince', 'has-error')} ">
	<label class="control-label col-sm-4" for="addresses[${i}].addressSince">
		<g:message code="address.addressSince.label" default="Address Since" />
		
	</label>
	<div class="col-sm-8">
            <g:customDatePicker name="addresses[${i}].addressSince" precision="day"  value="${address?.addressSince}" default="none" noSelection="['': '']" class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="addresses[${i}].addressSince">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="addresses[${i}].addressSince">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>
    </div>
    
    <g:if test="${i!=0}">
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-danger field-btn-delete" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.address-div');"><span class="fa fa-minus" ></span> Remove</button>
        </div>
    </g:if>
</div> 

