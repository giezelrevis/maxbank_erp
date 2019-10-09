<div class="modal fade" id="override">
  <div class="modal-dialog">

    <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Override</h4>
            </div>

            <div class="modal-body">
               <g:form controller="authentication" action="overrideAuthenticate" class="form-horizontal" role="form">

                <div id="overrideError" class="alert alert-danger" style="display:none">
                </div>

                <g:hiddenField name="policyCode" id="policyCode" value="" />
                <g:hiddenField name="form" id="form" value="" />

                <div class="form-group fieldcontain ${hasErrors(bean: userMasterInstance, field: 'userName', 'error')} ">
                  <label for="username" class="control-label">
                    <g:message code="userMaster.username.label" default="Username" />
                  </label>
                  <div class="col-sm-8">
                    <g:textField name="username" id="usernameOverrider" class="form-control" />
                  </div>
                </div>
                <div class="form-group fieldcontain ${hasErrors(bean: userMasterInstance, field: 'password', 'error')} ">
                  <label for="password" class="control-label">
                    <g:message code="userMaster.password.label" default="Password" />
                  </label>
                  <div class="col-sm-8">
                    <g:field type="password" name="password" id="passwordOverrider" class="form-control" />
                  </div>
                </div>
                
              </g:form>
            </div>

            <div class="modal-footer">
                <a href="#" data-dismiss="modal" class="btn">Close</a>
                <button class="btn btn-info" id="override_button"> Override </button>
            </div>
        </div>

  </div>
</div>