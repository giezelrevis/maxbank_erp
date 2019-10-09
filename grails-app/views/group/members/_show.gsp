<legend>Members</legend>

<div class="table-responsive">
	<table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>CID</label></td>
				<td><label>Name</label></td>
			</tr>
		</tbody>
		<tbody>
			<g:each var="member" in="${groupInstance.members.sort{it.id}}">
			<tr>
				<td>${member?.id}</td>
				<td>${member?.displayName}</td>
			</tr>
			</g:each>
		</tbody>
	</table>
</div>
