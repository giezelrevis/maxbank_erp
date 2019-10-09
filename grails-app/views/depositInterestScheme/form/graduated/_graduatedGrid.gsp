<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="signatory-main-div"style="<g:if test="${depositInterestSchemeInstance?.isGraduated!=true}"></g:if>">
    <button type="button" class="btn btn-primary multi-field-btn" href="#" onclick="initializeSignatorySearchModal();modal.show({deposit:'${depositInstance?.id}'})"><span class="fa fa-plus"></span> Add more Signatories</button>
        <div class="table-responsive col-md-12">
        <table id="signatoryTable" class="table table-hover table-condensed table-striped">
            <tr>
                <td><label>Start Balance</label></td>
                <td><label>End Balance</label></td>
                <td><label>Interest Rate</label></td>
                <td>Action</td>
            </tr>
            <tbody>
                <div id="graduatedList">
                    <g:each var="graduated" in="${depositInterestSchemeInstance.graduateds}" status="i">
                        <g:if test="${graduated?.status?.id!=3}">
                            <g:render template='form/graduated/onetomany/graduated' model="['graduated':graduated,'i':i]"/>
                        </g:if>
                    </g:each> 
               </div>
            </tbody>
        </table>
        </div>
</div>