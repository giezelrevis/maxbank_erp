<script type="text/javascript">

  
</script>


<legend>Attach Document / File</legend>

<g:if test="${session["postedOnOff"] == 'postedOff'}">
<div class="form-group form-buttons">        
        <button  id="add-buttons" type="button" data-toggle="modal" data-target="#myModal" class="btn btn-primary multi-field-btn-add"><span class="fa fa-file-excel-o"></span> Add File</button>
</div>
</g:if>

<div class="table-responsive">
    <table class="table table-hover table-condensed table-bordered table-striped">
    <tbody>
              
		<tr>
			<td class="col-sm-1"><label>No.</label></td>
			<td class="col-sm-3"><label>File Name</label></td>
			
			<td class="col-sm-3"><label>Reference</label></td>
                       
                        <td class="col-sm-3"><label>Particulars</label></td>
                        <td class="col-sm-3"><label>Date Uploaded</label></td>
			<td class="col-sm-2"><label>Action</label></td>		
		</tr>
	</tbody>
	<tbody>
                <g:each in="${session["glattachment"]}" status="i" var="glBatchAttachment">
				<tr>
					<td>${i + 1} </td>
                                        <g:if test="${session["glattachmentcondtion"] == 'edit'}">
                                             <g:if test="${session["postedOnOff"] == 'postedOff'}">
                                                <td><g:link  action="downloadAttachment" id="${glBatchAttachment.id}" target="_blank">${glBatchAttachment?.filename}</g:link></td>
                                             </g:if>
                                             <g:else>
                                                 <td><strong>${glBatchAttachment?.filename}</strong></td>
                                             </g:else>    

                                        </g:if>
                                        <g:else>
                                            
                                             <td>${glBatchAttachment?.filename}</td>
                                        </g:else>    
                                        <td>${glBatchAttachment?.reference}</td>
                                        <td>${glBatchAttachment?.particulars}</td>
					<td><g:formatDate format="MM/dd/yyyy" date="${glBatchAttachment?.uploadDate}"/></td>
                                        <g:if test="${session["postedOnOff"] == 'postedOff'}">
					<td>
                                            <a href="#" class="btn btn-secondary" onclick="removeAttachment('${i}')">Remove</a>
					</td>
                                        </g:if>
                                        <g:else>
                                        <td>
                                           <g:link  class="btn btn-secondary" action="downloadAttachment" id="${glBatchAttachment.id}" target="_blank">Download</g:link>
					</td>
                                        </g:else>    
				</tr>
                                
			
                </g:each>                
		
	</tbody>
	</table>
</div>

<!-- Add Attachment Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel"><strong>Attachments</strong></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
            <div class="fieldcontain form-group required">
                <label class="control-label col-sm-4" for="template">Attach File</label>
                <div class="controls col-sm-6">
                        <input id="file2" class="btn btn-info-form-control" type="file" name="file" />
                </div>  
            </div>
            <div class="fieldcontain form-group required">
                <label class="control-label col-sm-4" for="template">Reference</label>
                <div class="controls col-sm-6">
                        <input id="reference" class="form-control" type="text" name="reference" />
                </div>  
            </div>
            <div class="fieldcontain form-group required">
                <label class="control-label col-sm-4" for="template">Particulars</label>
                <div class="controls col-sm-6">
                        <input id="particulars" class="form-control" type="text" name="particulars" />
                </div>  
            </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onClick="passAttachmentAndBatchIdToController();">Save File</button>
      </div>
    </div>
  </div>
</div>