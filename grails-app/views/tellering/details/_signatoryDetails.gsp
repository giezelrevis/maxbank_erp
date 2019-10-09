<%@ page contentType="text/html;charset=UTF-8" %>

<div class="col-md-6">
<div class="section-container">
    <fieldset>
        <legend class="section-header">Others Signatories/Owners</legend>
        <div class="infowrap">
            <dl class="dl-horizontal">
                <dt>Ownership Type</dt>
                <dd>${depositInstance?.ownershipType?.description}</dd>
            </dl>
            <div class="table-responsive col-md-12">
                <g:if test="${depositInstance?.signatories?.size()>0}">
                    <table id="signatoryTable" class="table table-hover table-condensed table-striped">
                        <tr>
                            <td><label>CID</label></td>
                            <td><label>Name</label></td>
                            <td><label>Signatory</label></td>
                            <td><label>Signature</label></td>
                        </tr>
                        <tbody height="100px">
                            <div id="signatoryList">
                                <g:each var="signatory" in="${depositInstance?.signatories}" status="i">
                                    <g:if test="${signatory.status.id!=3}">
                                        <g:render template='details/signatoryInfo' model="[signatory:signatory,i:i,displayOnly:'true']"/>
                                    </g:if>
                                </g:each>
                        </tbody>
                    </table>
                </g:if>
            </div>
            <dl class="dl-horizontal">
                <dt>Signatory Rules</dt>
                <dd>${depositInstance?.sigRules}</dd>
            </dl>
            <dl class="dl-horizontal">
                <dt>Signatory Remarks</dt>
                <dd>${depositInstance?.sigRemarks}</dd>
            </dl>
        </div>
    </fieldset>
    </div>
</div>