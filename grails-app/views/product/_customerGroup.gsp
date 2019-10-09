<div class="form-group">
  <label for="category" class="control-label">Customer Groups</label>
  <div class="col-sm-6">
  
    <g:select id="customerGroups" name="customerGroups" from="${icbs.admin.CustomerGroup.findAll{configItemStatus.id == 2}}" optionKey="id" optionValue="name" value="${productInstance?.customerGroups?.id}" class="many-to-one form-control" multiple="" />
  
  </div>
</div>
                