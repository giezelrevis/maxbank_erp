<div class="form-group">
  <label for="category" class="control-label">Roles</label>
  <div class="col-sm-6">
  
    <g:select id="roles" name="roles" from="${icbs.admin.Role.list()}" optionKey="id" optionValue="name" value="${policyInstance?.roles?.id}" class="many-to-one form-control" multiple="" />
  
  </div>
</div>
                