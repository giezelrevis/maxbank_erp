<div class="form-group">
  <label for="category" class="control-label">Branches</label>
  <div class="col-sm-6">
  
    <g:select id="branches" name="branches" from="${icbs.admin.Branch.findAll{status.id == 2}}" optionKey="id" optionValue="name" value="${clearingBankInstance?.branches?.id}" class="many-to-one form-control" multiple="" />
  
  </div>
</div>
                