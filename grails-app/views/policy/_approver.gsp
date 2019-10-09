<div class="form-group">
  <label for="category" class="control-label">Approvers</label>
  <div class="col-sm-6">
  
    <g:select id="approvers" name="approvers" from="${icbs.admin.Role.list()}" optionKey="id" optionValue="name" value="${policyInstance?.approvers?.id}" class="many-to-one form-control" multiple="" />
  
  </div>
</div>
                