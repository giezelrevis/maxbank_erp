<legend>Attachments</legend>

<div class="form-group form-buttons">
	<button id="add-button" type="button" onclick="showAddAttachment()" class="btn btn-primary multi-field-btn-add"><span class="fa fa-plus"></span> Add Attachment</button>
</div>

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
		<g:if test="${collateralInstance?.attachments}">
			<g:each var="attachment" in="${collateralInstance?.attachments.sort{it.fileName}}">
				<tr>
					<td>${attachment?.fileName}</td>
					<td>${attachment?.description}</td>
					<td>${attachment?.type?.description}</td>
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateAttachment('${attachment?.id}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteAttachmentAjax('${attachment?.id}')">Remove</a>
					</td>			
				</tr>
			</g:each>
		</g:if>		
		<g:elseif test="${session["attachments"]}">
			<g:set var="i" value="${0}" />
			<g:each var="attachment" in="${session["attachments"]}">
				<tr>
					<td>${attachment?.fileName}</td>
					<td>${attachment?.description}</td>
					<td>${attachment?.type?.description}</td>
					<td><a href="#" class="btn btn-secondary" onclick="showUpdateAttachment('${i}')">Edit</a> 
					<a href="#" class="btn btn-secondary" onclick="deleteAttachmentAjax('${i}')">Remove</a>
					</td>		
				</tr>
				<g:set var="i" value="${i = i + 1}" />
			</g:each>	
		</g:elseif>
	</tbody>
	</table>
</div>

<div class="modal" id="add-attachment-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Attachment</h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="addAttachmentAjax()">Add</a>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="update-attachment-modal">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Update Attachment</h4>
            </div>
            <div class="modal-body">            	
            </div>
            <g:hiddenField name="attachmentId" value="" />
            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <a href="#" class="btn btn-primary" onclick="updateAttachmentAjax()">Save</a>
            </div>
        </div>
    </div>
</div>
