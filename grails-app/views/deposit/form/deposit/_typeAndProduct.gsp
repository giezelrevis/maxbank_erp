<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<legend>Module,Product and Schemes</legend>
    <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'type', 'has-error')} required">
        <label class="control-label col-sm-4" for="depositType">
            <g:message code="deposit.type.label" default="Deposit Type" />
            <span class="required-indicator">*</span>
        </label>
        <div class="col-sm-8"><g:select id="type" name="type.id" onchange="changeTypeProductSchemeForm('type')"from="${icbs.lov.DepositType.list()}" optionKey="id" optionValue="description" required="" value="${depositInstance?.type?.id}"noSelection="['':'']" class="many-to-one form-control"/>
            <g:hasErrors bean="${depositInstance}" field="type">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${depositInstance}" field="v">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
            </g:hasErrors>
        </div>             
    </div>
    <g:if test="${depositInstance?.type?.id}">
        <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'product', 'has-error')} required">
            <label class="control-label col-sm-4" for="product">
                <g:message code="deposit.product.label" default="Deposit Product" />
                <span class="required-indicator">*</span>
            </label>
            <div class="col-sm-8">
                <g:if test="${depositInstance?.type?.id==1}">
                    <g:select id="product" name="product.id" from="${icbs.admin.Product.findAll{ productType.id == 1&& configItemStatus.id==2}}" onchange="changeTypeProductSchemeForm('product')" optionKey="id" optionValue="name" required="" value="${depositInstance?.product?.id}" noSelection="['':'']" class="many-to-one form-control"/>
               </g:if>
                <g:if test="${depositInstance?.type?.id==2}">
                    <g:select id="product" name="product.id" from="${icbs.admin.Product.findAll{ productType.id == 2 && configItemStatus.id==2}}" onchange="changeTypeProductSchemeForm('product')" optionKey="id" optionValue="name" required="" value="${depositInstance?.product?.id}" noSelection="['':'']" class="many-to-one form-control"/>
               </g:if>
                <g:if test="${depositInstance?.type?.id==3}">
                    <g:select id="product" name="product.id" from="${icbs.admin.Product.findAll{ productType.id == 3 && configItemStatus.id==2}}"onchange="changeTypeProductSchemeForm('product')"  optionKey="id" optionValue="name" required="" value="${depositInstance?.product?.id}" noSelection="['':'']" class="many-to-one form-control"/>
               </g:if>
                <g:if test="${depositInstance?.type?.id==4}">
                    <g:select id="product" name="product.id" from="${icbs.admin.Product.findAll{ productType.id == 4 && configItemStatus.id==2 }}"onchange="changeTypeProductSchemeForm('product')"optionKey="id" optionValue="name" required="" value="${depositInstance?.product?.id}" noSelection="['':'']" class="many-to-one form-control"/>
               </g:if>
                <g:if test="${depositInstance?.type?.id==5}">
                    <g:select id="product" name="product.id" from="${icbs.admin.Product.findAll{ productType.id == 5 && configItemStatus.id==2}}" onchange="changeTypeProductSchemeForm('product')"  optionKey="id" optionValue="name" required="" value="${depositInstance?.product?.id}" noSelection="['':'']" class="many-to-one form-control"/>
               </g:if>

                    <g:hasErrors bean="${depositInstance}" field="product">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${depositInstance}" field="product">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
            </div>             
        </div>
    </g:if>
    <g:if test="${depositInstance?.product?.id && depositInstance?.type?.id}">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'depositInterestScheme', 'has-error')} ">
                <label class="control-label col-sm-4" for="depositInterestScheme">
                        <g:message code="deposit.depositInterestScheme.label" default="Deposit Interest Scheme" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                        <g:select id="depositInterestScheme" name="depositInterestScheme.id" from="${icbs.deposit.DepositInterestSchemeProduct.findAll{product.id==depositInstance.product.id}}" optionKey="depositInterestSchemeId"optionValue="depositInterestScheme" value="${depositInstance?.depositInterestScheme?.id}" class="many-to-one form-control" noSelection="['': '']"/>
                    <g:hasErrors bean="${depositInstance}" field="depositInterestScheme">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="depositInterestScheme">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
    </g:if>
    <g:if test="${depositInstance?.type?.id==3&& depositInstance?.product?.id}">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'fixedDepositPreTermScheme', 'has-error')} ">
                <label class="control-label col-sm-4" for="depositInterestScheme">
                        <g:message code="deposit.fixedDepositPreTermScheme.label" default="Fixed Deposit PreTerm Scheme" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                        <g:select id="fixedDepositPreTermScheme" name="fixedDepositPreTermScheme.id"from="${icbs.deposit.FixedDepositPreTermSchemeProduct.findAll{product.id==depositInstance.product.id}}" optionKey="fixedDepositPreTermSchemeId"optionValue="fixedDepositPreTermScheme" value="${depositInstance?.fixedDepositPreTermScheme?.id}" class="many-to-one form-control" noSelection="['': '']"/>
                    <g:hasErrors bean="${depositInstance}" field="fixedDepositPreTermScheme">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="fixedDepositPreTermScheme">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
    </g:if>
     <g:if test="${depositInstance?.type?.id==3&& depositInstance?.product?.id}">
            <div class="fieldcontain form-group ${hasErrors(bean: depositInstance, field: 'fixedDepositTermScheme', 'has-error')} ">
                <label class="control-label col-sm-4" for="depositInterestScheme">
                        <g:message code="deposit.fixedDepositTermScheme.label" default="Fixed Deposit Term Scheme" />
                        <span class="required-indicator">*</span>
                </label>
                <div class="col-sm-8">
                        <g:select id="fixedDepositermScheme" name="fixedDepositTermScheme.id"from="${icbs.deposit.FixedDepositTermSchemeProduct.findAll{product.id==depositInstance.product.id}}" optionKey="fixedDepositTermSchemeId"optionValue="fixedDepositTermScheme" value="${depositInstance?.fixedDepositTermScheme?.id}" class="many-to-one form-control" noSelection="['': '']"/>
                    <g:hasErrors bean="${depositInstance}" field="fixedDepositTermScheme">
                        <div class="controls">
                                <span class="help-block">
                                    <g:eachError bean="${depositInstance}" field="fixedDepositTermScheme">
                                        <g:message error="${it}" /><br/>
                                    </g:eachError>
                                </span>
                        </div>
                    </g:hasErrors>
                </div>             
            </div>
    </g:if>
    <fieldset class="form-group">
        
        <g:if test="${firstCreate==true&&!depositInstance?.customer}">
            <input type="button" href="#"class="btn btn-secondary"onclick="initializeCustomerDetailsSearchModal();modal.show()"value="Search Customer"/>
        </g:if>
        
        <div id="customerDetailsDiv">
            <g:render template='/customer/details/customerDetails' model="[customerInstance:depositInstance?.customer]"/>
        </div>
        
    </fieldset>
    
    
    
    
    
