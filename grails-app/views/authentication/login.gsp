<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="login">
    <title></title>
  </head> 
  <body class="bg-black">
    <content tag="main-content">
     <div class="form-box-msg" id="message-log-box">
       <g:if test="${flash.success}">
          <div style="margin:auto" class="box-bodylogin">
              <div class="alert alert-info alert-dismissable">
                  <i class="fa fa-info"></i>
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                  <b>Message</b> <div class="message" role="status">${flash.success}</div>
              </div>
          </div>
      </g:if>
      <g:if test="${flash.error}">
          <div style="margin:auto" class="box-bodylogin">
              <div class="alert alert-danger alert-dismissable">
                  <i class="fa fa-exclamation"></i>
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                  <b>Message</b> <div class="message" role="status">${flash.error}</div>
              </div>
          </div>
      </g:if>
     </div>
     <!--<div class="box bg-white">-->
     <div class="form-box" id="login-box">
       <div class="header">
            <img class="banner" src="${resource(dir: "images", file: "expresso.png")}">
       </div>
        <g:form controller="authentication" action="authenticate">
         <div class="body bg-gray">
          <div class="form-group1 fieldcontain ${hasErrors(bean: userMasterInstance, field: 'userName', 'error')} ">
            <!--<div class="col-sm-4">-->
            <!--<div class="col-sm-12"> -->
              <g:textField name="username" value="${userMasterInstance?.username}" class="form-control1" placeholder="Username (case-sensitive)" />
            <!--</div>-->
          </div>
          <div class="form-group1 fieldcontain ${hasErrors(bean: userMasterInstance, field: 'password', 'error')} ">
            <!--<div class="col-sm-4">-->
            <!--<div class="col-sm-12">-->
              <g:field type="password" name="password" value="${userMasterInstance?.password}" class="form-control1" placeholder="Password (case-sensitive)" />
          </div>
         </div>
          <!--<div class="form-group form-buttons">-->
          <div class="footer">
            <g:submitButton name="login" class="btn bg-black btn-block" value="Login"/>
          </div>
        </g:form>
      </div>
    </content>
  </body> 
</html>