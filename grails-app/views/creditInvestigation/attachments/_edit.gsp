

<div>
    <g:if test="${message}">
        <div class="box-body">
            <div class="alert alert-info alert-dismissable">
                <i class="fa fa-info"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Message</b> <div class="message" role="status">${message}</div>
            </div>
        </div>
    </g:if>
    <g:hasErrors bean="${attachment}"> 
        <div class="box-body">
            <div class="alert alert-danger alert-dismissable">
                <i class="fa fa-ban"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Alert!</b> 
                <ul class="errors" role="alert">
                    There are errors
                </ul>            
            </div>
        </div>
    </g:hasErrors>

    <div name="add-attachment-form">    
		<div class="fieldcontain form-group ${hasErrors(bean: attachment, field: 'fileData', 'has-error')}">
			<label for="fileData" class="control-label col-sm-4">File</label>
			<div class="col-sm-8">
                <g:field name="name" value="${attachment?.fileName}" readonly="true" class="form-control"/>

				<g:hasErrors bean="${attachment}" field="fileData">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${attachment}" field="fileData">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
			</div>
		</div>
		<div class="fieldcontain form-group ${hasErrors(bean: attachment, field: 'description', 'has-error')}">
			<label for="description" class="control-label col-sm-4">Description</label>
			<div class="col-sm-8">
				<g:textArea name="description" value="${attachment?.description}" rows="3" class="form-control"/>

				<g:hasErrors bean="${attachment}" field="description">
                    <div class="controls">
                        <span class="help-block">
                            <g:eachError bean="${attachment}" field="description">
                                <g:message error="${it}" /><br/>
                            </g:eachError>
                        </span>
                    </div>
                </g:hasErrors>
			</div>			
		</div>	
		<div class="fieldcontain form-group">
			<label for="types" class="control-label col-sm-4">Type</label>
			<div class="col-sm-8">
				<g:select class="form-control" id="type" name="type.id" from="${icbs.lov.AttachmentType.list()}" optionKey="id" optionValue="description" value="${attachment?.type?.id}" />
			</div>
		</div>
    </div>
</div>




