<div class="form-group">
  <label for="category" class="control-label">Entries</label>
  <div class="col-sm-6">
    <g:select id="link" name="links" from="${icbs.gl.CfgAcctGlTemplateDet.list()}" optionKey="id" optionValue="description" value="${cfgAcctGlTemplateInstance?.links?.id}" class="many-to-one form-control" multiple="multiple" />
  </div>
</div>