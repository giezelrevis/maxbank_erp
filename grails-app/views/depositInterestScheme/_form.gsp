<%@ page import="icbs.deposit.DepositInterestScheme" %>

<div class="nav-tabs-custom">
                  <div class="nav-tab-container">
                    <ul id="tabs" class="nav nav-tabs">
                        <li class="active"><a id="tabLi1"href="#tab_1" data-toggle="tab">Basic Deposit Interest Information</a></li>
                        <li <g:if test="${depositInterestSchemeInstance?.isGraduated!=true}">style ="display: none"</g:if>><a id="tabLi2"href="#tab_2" data-toggle="tab" >Graduated Interest Scheme</a></li>
                        <li><a id="tabLi3"href="#tab_3" data-toggle="tab">Products</a></li>
                    </ul>
                  </div>
                    <div class="tab-content">
                        <div class="tab-pane active fade in" id="tab_1">
                                <g:render template="form/basic"/>
                        </div>
                        <div class="tab-pane" id="tab_2">
                            <g:render template="form/graduated/graduatedInfo"/>
                        </div>
                         <div class="tab-pane" id="tab_3">
                            <g:render template="form/products"/>
                        </div>
                    </div>
                </div>