
<legend>Members</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showMemberSearch()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Member</button>
</div>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
		<tr>
			<td><label>CID</label></td>
			<td><label>Name</label></td>
			<td class="col-sm-2"><label>Action</label></td>
		</tr>
	</tbody>
	<tbody>
		<g:if test="${groupInstance?.members}">
			<g:each var="member" in="${groupInstance?.members.sort{it.id}}">
				<tr>
					<td>${member?.id}</td>
					<td>${member?.displayName}</td>
					<td><a href="#" class="btn btn-secondary" onclick="deleteMemberAjax(${member?.id})">Remove</a></td>
				</tr>
			</g:each>
		</g:if>
		<g:if test="${session["members"]}">
			<g:set var="i" value="${0}" />
			<g:each var="member" in="${session["members"]}">			
				<tr>
					<td>${member?.id}</td>
					<td>${member?.displayName}</td>
					<td><a href="#" class="btn btn-secondary" onclick="deleteMemberAjax(${i})">Remove</a></td>
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>		
		</g:if>
	</tbody>
	</table>
</div>
