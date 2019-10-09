<div class="form-group">
  <label for="category" class="control-label">Permissions</label>
  <div class="col-sm-6">
  
    <g:select id="module" name="modules" from="${icbs.admin.Module.list()}" optionKey="id" optionValue="name" value="${roleInstance?.modules?.id}" class="many-to-one form-control" multiple="multiple" />
  
  </div>
</div>