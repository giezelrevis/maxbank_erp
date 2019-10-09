<legend>Group Details</legend>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Name</label>					
	<span>${groupInstance?.name}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Description</label>
	<span>${groupInstance?.description}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Type</label>
	<span>${groupInstance?.type?.description}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Parent Group</label>
	<span>${groupInstance?.parent?.name}</span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Meeting Date</label>
	<span><g:formatDate format="MM/dd/yyyy" date="${groupInstance?.meetingDate}"/></span>
	
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Date Created</label>
	<span><g:formatDate format="MM/dd/yyyy" date="${groupInstance?.dateCreated}"/></span>
</div>

<div class="fieldcontain form-group">
	<label class="control-label col-sm-4">Status</label>
	<span>${groupInstance?.status?.description}</span>
</div>