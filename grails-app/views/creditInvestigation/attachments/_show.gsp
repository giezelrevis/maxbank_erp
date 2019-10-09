
<legend>Attachments</legend>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
	    <tbody>
			<tr>
				<td><label>File Name</label></td>			
				<td><label>Description</label></td>		
				<td><label>Type</label></td>
				<td class="col-sm-2"><label>Actions</label></td>		
			</tr>
		</tbody>
		<tbody>
			<g:each var="attachment" in="${creditInvestigationInstance?.attachments.sort{it.fileName}}">
			<tr>
				<td>${attachment?.fileName}</td>
				<td>${attachment?.description}</td>
				<td>${attachment?.type?.description}</td>
				<td><g:link class="btn btn-secondary" action="showAttachment" id="${attachment?.id}">View</g:link> <g:link class="btn btn-secondary" action="downloadAttachment" id="${attachment?.id}">Download</g:link></td>
			</tr>
			</g:each>
		</tbody>
	</table>
</div>