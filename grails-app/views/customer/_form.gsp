            <%@ page import="icbs.cif.Customer" %>
                <div class="nav-tabs-custom">
                  <div class="nav-tab-container">
                    <ul class="nav nav-tabs">
                        <li class="active"><a id="tabLi1"href="#tab_1" data-toggle="tab">Verification</a></li>
                        <li><a id="tabLi2"href="#tab_2" data-toggle="tab" >Other Customer Information</a></li>
                        <li><a id="tabLi3" href="#tab_3" data-toggle="tab">Contact Info.</a></li>
                        <li><a id="tabLi4" href="#tab_4" data-toggle="tab">Address Info.</a></li>
                        <li><a id="tabLi5"href="#tab_5" data-toggle="tab">Employment/Business Info.</a></li>
                        <g:if test="${!customerInstance?.id&&customerInstance?.type?.id == 1 }">
                         <%-- <li><a id="tabLi6"href="#tab_6" data-toggle="tab">Family Info.</a></li> --%>
                        </g:if>
                        <g:if test="${!customerInstance?.id&&customerInstance?.type?.id != 1}">
                            <li><a id="tabLi6"href="#tab_6" data-toggle="tab">Company Connections Info.</a></li>
                        </g:if>
                        <g:if test="${customerInstance?.type?.id<2}">
                            <li><a id="tabLi7"href="#tab_7" data-toggle="tab">Education Info.</a></li>
                        </g:if>
                        <li><a id="tabLi8"href="#tab_8" data-toggle="tab">Extended Info and Attachments</a></li>
                        <li><a id="tabLi9"href="#tab_9" data-toggle="tab">Presented IDs and Other Bank Accounts</a></li>
                    </ul>
                  </div>
                    <div class="tab-content">
                        <div class="tab-pane active fade in" id="tab_1">
                        <g:if test="${customerInstance?.type?.id==1}">
                            <g:render template="form/customer/customerverification/private"/>
                        </g:if>
                        <g:else>
                            <g:render template="form/customer/customerverification/corporation"/>
                        </g:else>
                        </div>
                        <div class="tab-pane" id="tab_2">
                            <g:render template="form/customer/othercustomerinfo/otherCustomerInfo"/>
                        </div>
                        <div class="tab-pane" id="tab_3">
                            <g:render template="form/contact/contactInfo"/>
                        </div>
                        <div class="tab-pane" id="tab_4">
                            <g:render template="form/address/addrInfo"/>
                        </div>
                        <div class="tab-pane" id="tab_5">
                            <g:render template="form/jointviews/employmentsAndBusinessInfo"/>
                        </div>
                        <g:if test="${!customerInstance?.id}">
                                <div class="tab-pane" id="tab_6">
                                    <g:if test="${customerInstance?.type?.id==1}">
                                        <%--<g:render template="form/relation/relationInfo" model="[customerRelationshipType:customerInstance?.type?.id]"/>--%>
                                    </g:if>
                                    <g:else>
                                        <g:render template="form/relation/relationInfoBusiness" model="[customerRelationshipType:customerInstance?.type?.id]"/>
                                    </g:else>
                                </div>
                        </g:if>
                        <g:if test="${customerInstance?.type?.id==1}">
                            <div class="tab-pane" id="tab_7">
                                <g:render template="form/education/educationInfo"/>
                            </div>
                        </g:if>
            
                        <div class="tab-pane" id="tab_8">
                            <g:render template="form/jointviews/extendedAndAttachmentInfo"/>
                        </div>
                        <div class="tab-pane" id="tab_9">
                            <g:render template="form/jointviews/presentedIdsAndOtherAcctsInfo"/>
                        </div>
                    </div>
                </div>