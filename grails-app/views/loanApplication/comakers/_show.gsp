<legend>Co-Makers</legend>

<div class="table-responsive">
	<table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>ID</label></td>
				<td><label>Name</label></td>
                                <td><label>Birthdate</label></td>
				<td class="col-sm-2"><label>Action</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="comaker" in="${comakers.sort{it.customer.id}}">
			<tr>
				<td>${comaker?.customer?.id}</td>
				<td>${comaker?.customer?.displayName}</td>
                                <td><g:formatDate format="MM/dd/yyyy" date="${comaker?.customer?.birthDate}"></g:formatDate></td>
				<td><g:link class="btn btn-secondary" controller="customer" action="customerInquiry" id="${comaker?.customer?.id}">View</g:link> 
			</tr>
			</g:each>
		</tbody>
	</table>
</div>
