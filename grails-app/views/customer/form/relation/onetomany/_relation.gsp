<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="relation${i}" class="relation-div" >
        <g:hiddenField name='relations[${i}].deleted' value='false'/>
        <g:set var="disabled" value="false"/>
        <g:if test="${relation?.id}">
            <g:hiddenField name='relations[${i}].id' value="${relation?.id}"/>
            <g:hiddenField name='relations[${i}].new' value='false'/>
        </g:if>
        <g:else>
            <g:hiddenField name='relations[${i}].new' value='true'/>
            <input type="button" href="#"onclick="initializeRelationModal();modal.addOnCloseCallbackParams('i',${i});modal.addOnCloseCallbackParams('choice',${choice});modal.show()"value="Existing Customer"/>
        </g:else>
        <g:if test="${relation?.customer2?.id}">
            <g:set var="disabled" value="disabled"/>
            <g:hiddenField id='relations[${i}].customer2'  name='relations[${i}].customer2.id' value="${relation.customer2.id}"/>
            <g:hiddenField id='relations[${i}].customer2.type' name='relations[${i}].customer2.type.id' value="${relation.customer2.type.id}"/>
        </g:if>
        <g:else>
            <g:hiddenField id='relations[${i}].customer2.type' name='relations[${i}].customer2.type.id' value="1"/>
           
            <!--<g:hiddenField id='relations[${i}].customer2.title' name='relations[${i}].customer2.title.id' value="65"/>
            <g:hiddenField id='relations[${i}].customer2.birthPlace' name='relations[${i}].customer2.birthPlace' value="none"/>
            <g:hiddenField id='relations[${i}].customer2.civilStatus' name='relations[${i}].customer2.civilStatus.id' value="60"/>
            <g:hiddenField id='relations[${i}].customer2.civilStatus' name='relations[${i}].customer2.civilStatus.id' value="60"/>
            <g:hiddenField id='relations[${i}].customer2.gender' name='relations[${i}].customer2.gender.id' value="1"/>
            -->  
        </g:else>
        <g:if test="${choice=='0'}">
            <g:hiddenField name='relations[${i}].type' class="relation-spouse" value='410'/>
        </g:if>
        <g:if test="${choice=='1'}">
            <g:hiddenField name='relations[${i}].type' class="relation-father" value='48'/>
        </g:if>
        <g:if test="${choice=='2'}">
            <g:hiddenField name='relations[${i}].type' class="relation-mother" value='47'/>
        </g:if>
        <g:if test="${choice=='3'}">
            <div class="form-group fieldcontain ${hasErrors(bean: relationInstance, field: 'relations['+i+'].type', 'has-error')} ">
                <label class="control-label col-sm-4"for="relations[${i}].type">
                        <g:message code="relation.type.label" default="Relation Type Id" />
                        
                </label>
                <div class="col-sm-8">
                    <g:select id="relations[${i}].type" name="relations[${i}].type.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndIdNotInListAndItemCodeLike("CRT",true,[47,48],"1%")}" optionKey="id" optionValue="itemValue" value="${relation?.type?.id}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="relations[${i}].type">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="relations[${i}].type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
        </g:if>
        <g:if test="${choice=='4'}">
            <div class="form-group fieldcontain ${hasErrors(bean: relationInstance, field: 'relations['+i+'].type', 'has-error')} ">
                <label class="control-label col-sm-4"for="relations[${i}].type">
                        <g:message code="relation.type.label" default="Relation Type Id" />

                </label>
                <div class="col-sm-8">
                    <g:select  "id="relations[${i}].type" name="relations[${i}].type.id" from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndItemCodeLike("CRT",true,"2%")}" optionKey="id" optionValue="itemValue"value="${relation?.type?.id}" class="form-control"/>
                    <g:hasErrors bean="${customerInstance}" field="relations[${i}].type">
                        <div class="controls">
                            <span class="help-block">
                                <g:eachError bean="${customerInstance}" field="relations[${i}].type">
                                    <g:message error="${it}" /><br/>
                                </g:eachError>
                            </span>
                        </div>
                    </g:hasErrors>
                </div>
            </div>
        </g:if>
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.title', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.title.id">
                    <g:message code="customer.title.label" default="Title" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:select disabled="${disabled}" name='relations[${i}].customer2.title.id' from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndIdNotEqual("CT",true,65)}" optionKey="id" optionValue ="itemValue" value="${relation?.customer2?.title?.id}" class="form-control" noSelection="['null': '']"/>
                <!--<g:textField disabled="${disabled}" name="relations[${i}].customer2.title.id" maxlength="50"  value="${relation?.customer2?.name1}" class="form-control"/> -->
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.title">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.title">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.name1', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.name1">
                    <g:message code="customer.name1.label" default="First Name" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:textField disabled="${disabled}" name="relations[${i}].customer2.name1" maxlength="50"  value="${relation?.customer2?.name1}" class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.name1">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.name1">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.name2', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.name2">
                    <g:message code="customer.name2.label" default="Middle Name" />
                    <!--<span class="-indicator">*</span>-->
            </label>
            <div class="col-sm-8">
            <g:textField disabled="${disabled}" name="relations[${i}].customer2.name2" maxlength="50"  value="${relation?.customer2?.name2}" class="form-control"/>
            <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.name2">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.name2">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
            </div>
        </div>

        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.name3', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.name3">
                    <g:message code="customer.name3.label" default="Last Name" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:textField disabled="${disabled}" name="relations[${i}].customer2.name3" maxlength="50" value="${relation?.customer2?.name3}" class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.name3">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.name3">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.name4', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.name4">
                    <g:message code="customer.name4.label" default="Initials" />
            </label>
            <div class="col-sm-8">
                <g:textField  disabled="${disabled}" name="relations[${i}].customer2.name4" maxlength="50" value="${relation?.customer2?.name4}" class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.name4">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.name4">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.birthDate', 'has-error')} ">
            <label class="control-label col-sm-4" for="relations[${i}].customer2.birthDate">
                    <g:message code="customer.birthDate.label" default="Birth Date" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:customDatePicker disabled="${disabled}" name="relations[${i}].customer2.birthDate" precision="day"  value="${relation?.customer2?.birthDate}"class="form-control" />
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.birthDate">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.birthDate">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        <g:if test="${!hide}">
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.gender', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.gender.id">
                    <g:message code="customer.gender.label" default="Gender" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:select disabled="${disabled}" name='relations[${i}].customer2.gender.id' from="${icbs.lov.Gender.findAllByIdNotInListAndStatus(['1'],true)   }" optionKey="id" optionValue ="description" value="${relation?.customer2?.gender?.id}" class="form-control" noSelection="['null': '']"/>
                <!--<g:textField disabled="${disabled}" name="relations[${i}].customer2.gender.id" maxlength="50"  value="${relation?.customer2?.name1}" class="form-control"/> -->
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.gender">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.gender">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        </g:if>
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.civilStatus', 'has-error')} ">
            <label class="control-label col-sm-4"for="relations[${i}].customer2.civilStatus.id">
                    <g:message code="customer.civilStatus.label" default="Civil Status" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:select disabled="${disabled}" name='relations[${i}].customer2.civilStatus.id' from="${icbs.lov.Lov.findAllByGroupCodeAndStatusAndIdNotEqual("CS",true,60)}" optionKey="id" optionValue ="itemValue" value="${relation?.customer2?.civilStatus?.id}" class="form-control" noSelection="['null': '']"/>
                <!--<g:textField disabled="${disabled}" name="relations[${i}].customer2.civilStatus.id" maxlength="50"  value="${relation?.customer2?.name1}" class="form-control"/> -->
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.civilStatus">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.civilStatus">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.sourceOfIncome', 'has-error')} ">
            <label class="control-label col-sm-4" for="relations[${i}].customer2.sourceOfIncome">
                    <g:message code="customer.sourceOfIncome.label" default="Source of Income" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:textField  disabled="${disabled}" name="relations[${i}].customer2.sourceOfIncome" maxlength="50" value="${relation?.customer2?.sourceOfIncome}" class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.sourceOfIncome">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.sourceOfIncome">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        
        <div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'relations['+i+'].customer2.birthPlace', 'has-error')} ">
            <label class="control-label col-sm-4" for="relations[${i}].customer2.birthPlace">
                    <g:message code="customer.birthPlace.label" default="Birth Place" />
                    <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:textField  disabled="${disabled}" name="relations[${i}].customer2.birthPlace" maxlength="50" value="${relation?.customer2?.birthPlace}" class="form-control"/>
                <g:hasErrors bean="${customerInstance}" field="relations[${i}].customer2.birthPlace">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${customerInstance}" field="relations[${i}].customer2.birthPlace">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>
        </div>
        
        <div class="form-group form-buttons">
            <button type="button" class="btn btn-danger field-btn-delete <g:if test="${choice=='0'}">relation-spouse-delete</g:if> <g:if test="${choice=='1'}">relation-father-delete</g:if> <g:if test="${choice=='2'}">relation-mother-delete</g:if>" onClick="icbs.Customer.Form.Utilities.bindDelete(this,'.relation-div');"><span class="fa fa-minus" ></span> Remove</button>
        </div>
</div>