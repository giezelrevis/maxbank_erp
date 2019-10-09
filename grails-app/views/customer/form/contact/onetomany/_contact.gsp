<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
 <div id="contact${i}" class="contact-div">
        <g:if test="${contact?.id}"> 
            <g:hiddenField name='contacts[${i}].id' value="${contact?.id}"/>
            <g:hiddenField name='contacts[${i}].new' value="false"/>
        </g:if>
        <g:else>
            <g:hiddenField name='contacts[${i}].new' value="true"/>
        </g:else>
         <g:hiddenField name='contacts[${i}].deleted' value='false'/>
        <g:if test="${choice=='0'}">
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].type', 'has-error')} required">
                <label class="control-label col-sm-4"for="contacts[${i}].type">
                        <g:message code="contact.type.label" default="Contact Type" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <g:select id="contacts[${i}].type" name="contacts[${i}].type.id"from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndItemCodeInList("CON",true,['001','002'])}" optionKey="id" required="" optionValue="itemValue" value="${contact?.type?.id}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].type">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
            
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].contactValue', 'has-error')}">
                <label class="control-label col-sm-4"for="contacts[${i}].contactValue">
                        <g:message code="contact.contactValue.label" default="Contact Number" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <g:textField id="contactNum" name="contacts[${i}].contactValue" maxlength="50" value="${contact?.contactValue}"class="form-control" onkeyup="updateContact()"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].contactValue">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].contactValue">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
            
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].isPrimaryPhone', 'has-error')} ">
                <label class="control-label col-sm-4"for="contacts[${i}].isPrimaryPhone">
                        <g:message code="contact.isPrimaryPhone.label" default="Is Primary Phone" />

                </label>
                <div class="col-sm-8">
                    <g:if test="${i==0}">
                        <g:if test="${!customerInstance?.contacts?.find{it?.isPrimaryPhone == true}}">  
                            <g:checkBox name="contacts[${i}].isPrimaryPhone" checked="true" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,1)" class=" phone-radio" value="${contact?.isPrimaryPhone}" />
                        </g:if>
                        <g:else>
                            <g:checkBox name="contacts[${i}].isPrimaryPhone" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,1)" class=" phone-radio" value="${contact?.isPrimaryPhone}" />
                        </g:else>
                    </g:if>
                    <g:else>
                        <g:checkBox name="contacts[${i}].isPrimaryPhone" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,1)" class=" phone-radio" value="${contact?.isPrimaryPhone}" />
                    </g:else>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].isPrimaryPhone">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].isPrimaryPhone">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
        </g:if>
        
        <g:if test="${choice=='1'}">
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].type', 'has-error')} required">
                <label class="control-label col-sm-4"for="contacts[${i}].type">
                        <g:message code="contact.contactTypeId.label" default="Contact type" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <g:select id="contacts[${i}].type" name="contacts[${i}].type.id"from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndItemCodeInList("CON",true,['003'])}" optionKey="id" required="" optionValue="itemValue" value="${contact?.type?.id}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].type">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
            <g:if test="${contact?.contactValue}">
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].contactValue', 'has-error')}">
                <label class="control-label col-sm-4"for="contacts[${i}].contactValue">
                        <g:message code="contact.contactValue.label" default="Email Address" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <g:textField name="contacts[${i}].contactValue" maxlength="50" value="${contact?.contactValue}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].contactValue">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].contactValue">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
            </g:if>
            <g:else>
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].contactValue', 'has-error')}">
                <label class="control-label col-sm-4"for="contacts[${i}].contactValue">
                        <g:message code="contact.contactValue.label" default="Email Address" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                    <g:textField name="contacts[${i}].contactValue" maxlength="50" value="nodata@noemail.com" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].contactValue">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].contactValue">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>       
            </g:else>
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].isPrimaryEmail', 'has-error')} ">
                 <label class="control-label col-sm-4"for="contacts[${i}].isPrimaryEmail">
                         <g:message code="contact.isPrimaryEmail.label" default="Is Primary Email" />

                 </label>
                  <div class="col-sm-8">
                    <g:checkBox name="contacts[${i}].isPrimaryEmail" onclick="icbs.Customer.Form.Utilities.radioCheckBox(event,2)"class="email-radio"  value="${contact?.isPrimaryEmail}" />
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].isPrimaryEmail">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].isPrimaryEmail">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>  
                  </div>
            </div>
        </g:if>
        <g:if test="${choice=='2'}">
           <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].type', 'has-error')} required">
                <label class="control-label col-sm-4"for="contacts[${i}].type">
                        <g:message code="contact.type.label" default="Contact Type" />
                        <span class="required-indicator">*</span>
                </label>
                 <div class="col-sm-8">
                    <g:select id="contacts[${i}].type" name="contacts[${i}].type.id"from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndItemCodeInList("CON",true,['004','005','006'])}" optionKey="id" required="" optionValue="itemValue" value="${contact?.type?.id}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].type">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>             
                 </div>
            </div>
            <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'contacts['+i+'].contactValue', 'has-error')}">
                <label class="control-label col-sm-4" for="contacts[${i}].contactValue">
                        <g:message code="contact.contactValue.label" default="Social Media URL" />
                        <span class="required-indicator">*</span>
                </label>
                 <div class="col-sm-8">
                    <g:textField name="contacts[${i}].contactValue" maxlength="50" value="${contact?.contactValue}"class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="contacts[${i}].contactValue">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="contacts[${i}].contactValue">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                 </div>
            </div>
        </g:if>
        <g:if test="${!canDelete}">
            <div class="form-group form-buttons">
                <button type="button" class="btn btn-danger field-btn-delete" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.contact-div')";><span class="fa fa-minus" ></span> Remove</button>
            </div>
        </g:if>
    </div> 