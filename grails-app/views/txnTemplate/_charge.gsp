<div class="form-group">
  <label for="category" class="control-label">Charges</label>
  <div class="col-sm-6">
  
    <g:select id="charges" name="charges" from="${icbs.deposit.DepositTaxFeeAndChargeScheme.list()}" optionKey="id" optionValue="description" value="${txnTemplateInstance?.charges?.id}" class="many-to-one form-control" multiple="" />
  
  </div>
</div>