<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="signatory-main-div"style="<g:if test="${depositInstance?.ownershipType?.id==1||!depositInstance?.ownershipType}">display:none</g:if>">
                <button type="button" class="btn btn-primary multi-field-btn" href="#" onclick="initializeSignatorySearchModal();modal.show({deposit:'${depositInstance?.id}'})"><span class="fa fa-plus"></span> Add more Signatories</button>
                    <div class="table-responsive col-md-12">
                        <table id="signatoryTable" class="table table-hover table-condensed table-striped">
                            <tr>
                                <td><label>CID</label></td>
                                <td><label>Name</label></td>
                                <td><label>Signatory</label></td>
                                <td>Action</td>
                            </tr>
                               <tbody>
                                    <div id="signatoryList">
                                        <g:each var="signatory" in="${depositInstance?.signatories}" status="i">
                                            <g:if test="${signatory?.status?.id!=3}">
                                                <g:render template='form/signatory/onetomany/signatory' model="[signatory:signatory,i:i]"/>
                                            </g:if>
                                        </g:each>
                                    </div>
                                </tbody>
                        </table>
                    </div>
            </div>