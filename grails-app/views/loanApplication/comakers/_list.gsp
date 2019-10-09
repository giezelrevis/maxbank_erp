
<legend>Co-Makers</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showComakerSearch()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Co-Maker</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>ID</label></td>
			<td><label>Name</label></td>
                        <td><label>Birthdate</label></td>
			<td class="col-sm-2"><label>Actions</label></td>		
		</tr>
	</tbody>
	<tbody>
		<g:if test="${comakers}">
			<g:each var="comaker" in="${comakers.sort{it.customer.id}}">
				<tr>
					<td>${comaker?.customer?.id}</td>
					<td>${comaker?.customer?.displayName}</td>
                                        <td><g:formatDate format="MM/dd/yyyy" date="${comaker?.customer?.birthDate}"></g:formatDate></td>
					<td><g:link class="btn btn-secondary" controller="customer" action="customerInquiry" id="${comaker?.customer?.id}">View</g:link> 
					<a href="#" class="btn btn-secondary" onclick="deleteComakerAjax('${comaker?.id}')">Remove</a></td>
					<%--<td><img src="${resource(dir:'images/skin', file:'database_delete.png')}"
                        style="vertical-align:middle" onclick="deleteComakerAjax('${comaker?.id}')"/></td>--%>
				</tr>
			</g:each>
		</g:if>
		<g:elseif test="${session["comakers"]}">
			<g:set var="i" value="${0}" />
			<g:each var="comaker" in="${session["comakers"]}">
				<tr>
					<td>${comaker?.id}</td>
					<td>${comaker?.displayName}</td>
                                        <td><g:formatDate format="MM/dd/yyyy" date="${comaker?.birthDate}"></g:formatDate></td>
					<td><g:link class="btn btn-secondary" controller="customer" action="customerInquiry" id="${comaker?.id}">View</g:link> 
					<a href="#" class="btn btn-secondary" onclick="deleteComakerAjax('${i}')">Remove</a></td>
					<%--<td><img src="${resource(dir:'images/skin', file:'database_delete.png')}"
                        style="vertical-align:middle" onclick="deleteComakerAjax('${i}')"/></td>--%>
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>		
		</g:elseif>
	</tbody>
	</table>
</div>
