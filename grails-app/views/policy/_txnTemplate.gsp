<div class="form-group">
  <label for="category" class="control-label">Transactions</label>
  <div class="col-sm-6">
  
    <g:select id="transactions" name="transactions" from="${icbs.admin.TxnTemplate.list()}" optionKey="id" optionValue="description" value="${policyInstance?.txnTemplates?.id}" class="many-to-one form-control" multiple="" />
  
  </div>
</div>
                