<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title><g:layoutTitle /> [ICBS]</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    
    
    <asset:stylesheet src="myCustomStyleSheet.css"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="select2.css"/>
    <asset:stylesheet src="select2-bootstrap.css"/>
    <asset:stylesheet src="datepicker3.css"/>
    <asset:stylesheet src="font-awesome.min.css"/>
    

    <!-- link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" / -->
    <!-- Morris chart -->
    <asset:stylesheet src="AdminLTE/morris/morris.css"/>
    
    <asset:stylesheet src="alertify.min.css"/>
    <asset:stylesheet src="themes/semantic.min.css"/>
    
 
    <!-- jvectormap -->
    <asset:stylesheet src="AdminLTE/jvectormap/jquery-jvectormap-1.2.2.css"/>
<!--   asset:stylesheet src="AdminLTE/AdminLTE.css"/>-->
    <asset:stylesheet src="AdminLTE/AdminLTE.min.css"/>
    <!-- bootstrap wysihtml5 - text editor -->
    <asset:stylesheet src="AdminLTE/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css"/>
    <!-- Theme style -->
    <!--asset:stylesheet src="AdminLTE/AdminLTE.css"/-->
    <asset:stylesheet src="main.css"/>
    <asset:stylesheet src="BootSideMenu.css"/>
    
    <!-- 3-28-2016 - added asset: -- dataTables (reyjie) -->
    <asset:stylesheet src="AdminLTE/datatables/jquery.dataTables.min.css" />
     <asset:stylesheet src="AdminLTE/datatables/buttons.dataTables.min.css" />

    
    <asset:javascript src="jquery-1.11.1.min.js"/>
    <asset:javascript src="bootstrap.min.js"/>
    <asset:javascript src="morris.min.js"/>
    <asset:javascript src="raphael.js"/>
    <asset:javascript src="adminlte.min.js"/>
    <asset:javascript src="jquery-ui.min.js"/>
    <asset:javascript src="select2.min.js"/>
    <asset:javascript src="accounting.js"/>
    <asset:javascript src="TreeListFilter.js"/>
    <asset:javascript src="application.js"/>
    <asset:javascript src="plugins/input-mask/jquery.inputmask.js"/>
    <asset:javascript src="plugins/input-mask/jquery.inputmask.numeric.extensions.js"/>
    <asset:javascript src="plugins/datepicker/bootstrap-datepicker.js"/>
    
    <!--Added by reyjie -->
    <!-- asset:javascript src="notify.js"/ -->
    <asset:javascript src="alertify.min.js"/>
    <asset:javascript src="BootSideMenu.js"/>
    <!--Custom Javascripts Kr Yap-->
    <asset:javascript src="namespace.js"/>
    <asset:javascript src="ICBSDependencies.js"/>
    <asset:javascript src="search.js"/>
    
    <asset:javascript src="plugins/datatables/jquery.dataTables.js"/>
    <%-- asset:javascript src="plugins/dataTables/dataTables.bootstrap.js"/ --%>
    <asset:javascript src="plugins/datatables/dataTables.buttons.min.js"/>
    <asset:javascript src="plugins/datatables/buttons.print.min.js"/>
    
    <asset:javascript src="jquery.alphanum.js"/>
    
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style>
      #body-gradient {background-image: url('${resource(dir: "images", file: "body-gradient.png")}')}
      #logo-bar {background-image: url('${resource(dir: "images", file: "bg-translucent.png")}')}
      #logo-bar>.location {width:500px;}
      .info-box .info-box-text{font-size:12px;}
    

    </style>
    <g:layoutHead/>
    
    
    <script>
        var IDLE_TIMEOUT =  ${session.session_timeout} /  1000.0; //60; //seconds
        var _idleSecondsCounter = 0, _idleTimeoutDisable = 0, totJSON,
        AppTitle = "MB-ExpressO";
        //var notify = alertify;
        //override defaults
       // alertify.defaults.transition = "slide";
        alertify.defaults.theme.ok = "btn btn-primary";
        alertify.defaults.theme.cancel = "btn btn-danger";
        alertify.defaults.theme.input = "form-control";
        
        

    </script>

  </head>
<body>
    
    <div id="sidemenu" style="display:none">
    <h2></h2>
    <div class="list-group">
      <a href="#" class="list-group-item active">My Profile</a>
      <a href="#" class="list-group-item">Teller Balance</a>
      <a href="#" class="list-group-item">Checks Activity</a>
      <a href="#" class="list-group-item">Withdrawal Activity</a>
      <a href="#" class="list-group-item">Deposit Activity</a>
      <a href="#" class="list-group-item">Transfer Activity</a>
      <!-- a href="#subTest" class="list-group-item">Sub Menu</a>
      <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
      <a href="#" class="list-group-item">Morbi leo risus</a>
      <a href="#" class="list-group-item">Porta Porta Porta sdaf s fs hfuis uif ac consectetur ac</a -->
    </div>

    <div class="list-group submenu" id="subTest">
      <a href="#" class="list-group-item">item 1</a>
      <a href="#subTestSub" class="list-group-item">item 2</a>
      <a href="#" class="list-group-item">Item 3</a>
    </div> 

    <div class="list-group submenu" id="subTestSub">
       <a href="#" class="list-group-item">item 4</a>
       <a href="#" class="list-group-item">item 5</a>
    </div> 

  </div>
  
  <!-- create badge for transaction value -->


   <!-- SIDEBAR NAVIGATION -->
    <g:if test="${session.user!=null}">
        <div id="sidebar_menu" class="hidden-print">
            <div class="sidebar_header">
              <h2>Navigation</h2>
            </div>
            
            %{-- 
            <div class="menu_search_wrapper">
              <div class="search_form">
                <span id="input-search-icon" class="glyphicon glyphicon-search" aria-hidden="true"></span>
                <input type="text" name="menu_search" id="menu-search" class="form-control" placeholder="Search Menu Items"/>
                <button class="close_search"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                <div class="search_results">
                  <ul id="ul-results">

                  <g:if test="${cifMenu}">
                    <li><a href="#">Customer Information</a></li>
                  </g:if>

                  <g:if test="${depositsMenu}">  
                     <li><a href="#">Deposits</a></li>
                  </g:if>   

                  <g:if test="${loansMenu}">
                     <li><a href="#">Loans</a></li>
                  </g:if>   

                  <g:if test="${telleringMenu}">
                     <li><a href="#">Teller Transactions</a></li>
                  </g:if>   

                  <g:if test="${glMenu}">
                     <li><a href="#">General Ledger</a></li>
                  </g:if>   

                  <g:if test="${adminMenu}">
                     <li><a href="#">System Administration</a></li>
                  </g:if>   

                  <g:if test="${configMenu}">
                     <li><a href="#">Configuration</a></li>
                  </g:if>   

                  <g:if test="${auditMenu}">
                     <li><a href="#">Audit</a></li>
                  </g:if>   

                    <g:each in="${cifMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${depositsMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${loansMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${telleringMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${glMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${adminMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${configMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${auditMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                     
                    <li id="no-results"><em>No results</em></li> 
                  </ul>
                </div>
              </div>
            </div>

            --}%
        
        
            <ul class="sidebar_nav">

              <g:if test="${cifMenu}">
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-custinfo"></span>Customer Information</a>
                  <ul>
                    <g:each in="${cifMenu}">
                      <li><a href="${createLink(uri: it.uri)}"> ${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>
              
              <g:if test="${depositsMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-deposit"></span>Deposits</a>
                  <ul>
                    <g:each in="${depositsMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>  

              <g:if test="${loansMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-loan"></span>Loans</a>
                  <ul>
                    <g:each in="${loansMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>  

              <g:if test="${telleringMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-tellertxn"></span>Teller Transactions</a>
                  <ul>
                    <g:each in="${telleringMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>  

              <g:if test="${glMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-ledger"></span>General Ledger</a>
                  <ul>
                    <g:each in="${glMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>  

              <g:if test="${adminMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-sysad"></span>System Administration</a>
                  <ul>
                    <g:each in="${adminMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>  

              <g:if test="${configMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-config"></span>Configuration</a>
                  <ul>
                    <g:each in="${configMenu}">
                        
                      <!-- <li><a href="${createLink(uri: it.uri)}">${it.uri}/${it.name}</a></li> -->
                        
                        <g:if test="${it.uri=='/glLink'}">
                            <li><a href="${createLink(uri: '/cfgAcctGlTemplate')}">${it.name}</a></li>
                        </g:if>
                        <g:else>
                            <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                        </g:else>    	 
                    </g:each>
                  </ul>
                </li>
              </g:if>  

              <g:if test="${auditMenu}">  
                <li class="nav_item">
                  <a href="#"><span class="nav-icon icon-audit"></span>Audit</a>
                  <ul>
                    <g:each in="${auditMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                  </ul>
                </li>
              </g:if>  
                
            </ul>
        </div>
        <input type="checkbox" id="nav-trigger" class="nav-trigger" />
        <label for="nav-trigger"></label>
    </g:if>
    <!-- END SIDEBAR NAVIGATION -->

    <div class="bodywrap <g:if test="${session.user!=null}">withsidebar</g:if>">
    <div id="body-gradient" class="hidden-print" style="background-image: url('${resource(dir: "images", file: "body-gradient.png")}')">
    </div>
    <!-- header logo: style can be found in header.less -->
    <header class="header">
      <div id="user-bar" class="hidden-print">
        <ul>
            <g:hiddenField id="unreadnotify" name="unreadnotify" value="${unreadMessages}" />
            <g:hiddenField id="alertnotify" name="alertnotify" value="${pendingPolicyExceptions}" />
            <g:if test="${session.user!=null}">
            <li><a href="${createLink(uri: '/userMaster/changePassword')}"><span class="fa fa-user icon"></span>${session.user}</a></li>																					 
            <li><a href="${createLink(uri: '/userMessage')}"><span id="new" class="fa fa-envelope icon"></span> <span id = "label">Messages</span> <span class="secondary-label" id="unmsg">${unreadMessages}</span></a></li>
            <li><a href="${createLink(uri: '/policyException')}"><span id="al" class="fa fa-exclamation-circle icon"></span> <span  id = "al1">Alerts</span> <span class="secondary-label" id="ppex">${pendingPolicyExceptions}</span></a></li>					 
            <g:javascript>
                var newmess = $('#unreadnotify').val();
                var newalert = $('#alertnotify').val();
                if(newmess>0){
                document.getElementById("new").style.cssText = "color:red;";
                document.getElementById("unmsg").style.cssText = "color:#fff; font-weight:bold; background-color:red; border-color:red;";
                document.getElementById("label").style.cssText = "color:red; font-weight:bold";
                }
               if(newalert>0){
                document.getElementById("al").style.cssText = "color:red;";
                 document.getElementById("al1").style.cssText = "color:red; font-weight: bold";
                document.getElementById("ppex").style.cssText = "color:#fff; font-weight:bold; background-color:red; border-color:red;";
               }
               
            </g:javascript>
            
            <%--
            <li><a href="${createLink(uri: '/authentication/logout')}"><span class="fa fa-sign-out icon"></span>Logout</a></li>
            --%>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-align-left"></span> Logout <span class="caret"></span></a>
                <ul class="dropdown-menu pull-right">
                    <li><a href="${createLink(uri: '/authentication/logout')}"><span class="glyphicon glyphicon-ok icon"></span>Balance Teller</a></li>
                    <li><a href="${createLink(uri: '/authentication/conditionallogout')}"><span class="fa fa-sign-out icon"></span>Logout</a></li>
                </ul>
                
            </li>
          </g:if>
          <g:if test="${session.user==null}">
            <li><a href="${createLink(uri: '/authentication/login')}"><span class="fa fa-sign-in icon"></span>Login</a></li>
          </g:if>
        </ul>
      </div>
      <div id="logo-bar">
        <a href="${createLink(uri: '/')}" class="logo">
          <g:if test="${session.user!=null}">
            <img src="${resource(dir: "images", file: "${icbs.admin.Institution.findByParamCode('GEN.10030').paramValue}")}" alt="Bank Logo" />
          </g:if>
          <g:if test="${session.user==null}">
            %{-- <span>ICBS</span> --}%
            <img src="${resource(dir: "images", file: "mbphil.jpg")}" alt="Bank Logo" />
          </g:if>
        </a>
        <div class="location">
          <g:if test="${session.user!=null}">
            <p><span class="fa fa-map-marker icon"></span><label>${icbs.admin.Institution.findByParamCode('GEN.10000').paramValue} - ${session.branch}</label></p>
            <p><span class="fa fa-calendar icon"></span>${g.formatDate(date: (runDate), format: 'E, dd MMMM yyyy')}

          </g:if>
          </p>
        </div>
        <g:if test="${session.user!=null}">
          <div class="search hidden-print">
            
            <div class="search-bar">
              %{--  
              <form action="#" method="get" class="sidebar-form">
                <div class="input-group">
                    
                  <input type="text" name="menu_search" id="menu-search" class="form-control" placeholder="Search..."/>
                  <span class="input-group-btn">
                    <button type='submit' name='seach' id='search-btn' class="btn btn-flat btn-primary"><span class="glyphicon glyphicon-search"></span></button>
                  </span>
                </div>
              </form>

               --}%
            
            <div class="menu_search_wrapper">
              <div class="search_form">
                <span id="input-search-icon" class="glyphicon glyphicon-search" aria-hidden="true"></span>
                <input type="text" name="menu_search" id="menu-search" class="form-control" placeholder="Search Menu Items"/>
                <button class="close_search"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                <div class="search_results">
                  <ul id="ul-results">

                  <g:if test="${cifMenu}">
                    <li><a href="#">Customer Information</a></li>
                  </g:if>

                  <g:if test="${depositsMenu}">  
                     <li><a href="#">Deposits</a></li>
                  </g:if>   

                  <g:if test="${loansMenu}">
                     <li><a href="#">Loans</a></li>
                  </g:if>   

                  <g:if test="${telleringMenu}">
                     <li><a href="#">Teller Transactions</a></li>
                  </g:if>   

                  <g:if test="${glMenu}">
                     <li><a href="#">General Ledger</a></li>
                  </g:if>   

                  <g:if test="${adminMenu}">
                     <li><a href="#">System Administration</a></li>
                  </g:if>   

                  <g:if test="${configMenu}">
                     <li><a href="#">Configuration</a></li>
                  </g:if>   

                  <g:if test="${auditMenu}">
                     <li><a href="#">Audit</a></li>
                  </g:if>   

                    <g:each in="${cifMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${depositsMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${loansMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${telleringMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${glMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${adminMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                    <g:each in="${configMenu}">
						
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
					  
                    </g:each>
                    <g:each in="${auditMenu}">
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
                    </g:each>
                     
                    <li id="no-results"><em>No results</em></li> 
                  </ul>
                </div>
              </div>
            </div>
            
            
            </div>
          </div>
        </g:if>
        
      </div>
       
      <!-- BREADCRUMBS -->
      <g:if test="${session.user!=null}">
        <div id="breadcrumbs" class="hidden-print">
          <!--span class="menu-btn-container"><a href="#" id="menu-btn"><span class=" fa fa-bars"></span> Menu</a></span-->
          <a href="${createLink(uri: '/')}">Home</a>
          <g:pageProperty name="page.breadcrumbs"/>
          
          <span style="float:right; color:#fff; margin-right:13px;">${icbs.admin.Institution.findByParamCode('GEN.10150').paramValue}</span>
         
          
          <!-- span  id="checkoh" class="button" style="float:right; color:black; margin-right:13px;">Check on Hand: 0.00</span -->
          <a href="#" id="cashoh" class="btn btn-info" onClick="GenerateTotals();" style="float:right; color: #001f3f;margin-right:13px;">Check on Hand: 0.00</a>
          
    </div>

      </g:if>
      
    </header>


    <div id="page-content">
      <g:if test="${pageProperty(name:'title')!=''}">
        <h1><g:layoutTitle /></h1>
      </g:if>
      <div id="main-content">
          <g:if test="${flash.error}">
            <div class="box-body">
                <div class="alert alert-danger alert-dismissable">
                    <i class="fa fa-exclamation"></i>
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <b>Message</b> <div class="message" role="status">${flash.error}</div>
                </div>
            </div>
            
        </g:if>
        <g:pageProperty name="page.main-content"/>
      </div>
      <g:if test="${pageProperty(name:'page.main-actions')!=''}">
        <div id="main-actions" class="main-actions" class="hidden-print">
          <div id="sidebar">
            <div class="title">
              Actions
            </div>
            <div class="content" id="ulmenu">
              <g:pageProperty name="page.main-actions"/>
              &nbsp;
            </div>
          </div>
        </div>
      </g:if>
      <div class="breaker"></div>
    </div>
    <!-- Spinner for Ajax-->
    <div id="modal-append-div">
    </div>
    <div id="spinner" style="display:none;">
        <img src="${resource(dir:'images', file:'spinner.gif')}" alt="Loading..."/>
    </div>

    <!-- Override Modal -->
    <g:render template="/policy/overrideModal"/>
   

  </div> <!-- END BODYWRAP -->
  

  <script type="text/javascript">
      
  //added by calvs
  $('#purcost').keyup(function () {
              
              $('#deprevalue').val($('#purcost').val() - $('#salvagevalue').val());
              $('#annualexpense').val(($('#purcost').val() - $('#salvagevalue').val())/$('#lifeinyears').val());
              $('#monthlyexpense').val((($('#purcost').val() - $('#salvagevalue').val())/$('#lifeinyears').val())/12);
              
          });
          
          $('#salvagevalue').keyup(function () {
              
              $('#deprevalue').val($('#purcost').val() - $('#salvagevalue').val());
              $('#annualexpense').val(($('#purcost').val() - $('#salvagevalue').val())/$('#lifeinyears').val());
              $('#monthlyexpense').val((($('#purcost').val() - $('#salvagevalue').val())/$('#lifeinyears').val())/12);
              
          });
          
          $('#lifeinyears').keyup(function () {
              
              $('#deprevalue').val($('#purcost').val() - $('#salvagevalue').val());
              $('#annualexpense').val(($('#purcost').val() - $('#salvagevalue').val())/$('#lifeinyears').val());
              $('#monthlyexpense').val((($('#purcost').val() - $('#salvagevalue').val())/$('#lifeinyears').val())/12);
              
          });

          $('#purdate').datepicker();

    // Added by reyjie (CSS: browser behavior, this will scroll the #sidebar(Action Menu) up and down and will
    // not leave the current view port)
    $(function() {
	// Set this variable with the height of your sidebar + header
	var offsetPixels = 290; 

	$(window).scroll(function() {
		if ($(window).scrollTop() > offsetPixels) {
			$( "#sidebar" ).css({
				"position": "fixed",
				"top": "15px"
			});
		} else {
			$( "#sidebar" ).css({
				"position": "static"
			});
		}
	});
        
        //$(".truncated").inputmask('decimal', { numericInput: true, autoUnmask: true
       // });
        
        $(".truncated").inputmask("decimal", {
          //  alias: "numeric",
            radixPoint: ".",
            groupSeparator: ",",
            digits: 2,
            digitsOptional: false,
            autoGroup: true,
           // prefix: 'P', //No Space, this will truncate the first character
            rightAlign: false,
            //numericInput: true,
            autoUnmask: true,
            oncleared: function () { self.Value(''); }
        });
        
        document.onclick = function() {
            _idleSecondsCounter = 0;
        };
        document.onmousemove = function() {
            _idleSecondsCounter = 0;
        };
        document.onkeypress = function() {
            _idleSecondsCounter = 0;
        };
        _idleTimeoutDisable = window.setInterval(CheckIdleTime, 1000);
        window.setInterval(getAlerts, 5000);
        
        
        $('#sidemenu').BootSideMenu({side:"right"});
        
        GenerateTotals();
       // CheckOnHand();
        
        
    });
    
function GenerateTotals(){
	var xmlHttp;
	xmlHttp=new XMLHttpRequest();
	var url = "/icbs/tellering/getCashOnHand";
	if (!xmlHttp) {
	  alert('Giving up :( Cannot create an XMLHTTP instance');
	  return false;
	}
	
	xmlHttp.onreadystatechange = function(){
		if (xmlHttp.readyState==4 && xmlHttp.status==200){
			var coh = 'Cash on Hand :';
			var totJSON = xmlHttp.responseText;
			$.each(JSON.parse(totJSON),function(key,val){
				coh += ' ' + val.code + ' ' + accounting.formatNumber((val.cashin - val.cashout),2) + ' |';
			   
			});
			$('#cashoh').html(coh.substr(0,coh.length-1));
		}else{
                    //console.log("theres a problem with the request generate Totals");
		}
	}
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}
    
    function CashOnHand()
    {
        // get url
        var url = location.href;
        if(url.indexOf('viewTellerBalancing') > -1)
        {
            return;
        }
       // console.log('out? '+url.indexOf('viewTellerBalancing'));
        GenerateTotals();
    
        
        
        //var coh = 'Cash on Hand : ';
        //coh += '9,99';
        //$('#cashoh').html(coh);
        
    }
    function CheckOnHand()
    {
        var coh = 'Check on Hand : ';
        coh += '9,99';
        $('#checkoh').html(coh);
    }
    
  
    function alertContents() {
		var xmlHttp;
		xmlHttp=new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
		    if (xmlHttp.readyState==4 && xmlHttp.status==200){
				var obj = JSON.parse(xmlHttp.responseText);
				prevNotice = parseInt($('#ppex').html());
				if(obj.pendingPolicy > 0){
					if(obj.pendingPolicy > prevNotice){
						$('#ppex').html(obj.pendingPolicy);
						notify.info("You have "+obj.pendingPolicy+" policy notice!");
					}
				}
				
			}else {
				alert('There was a problem with the request.');
			}
		}
	}
    
      
    function alertMessage() {
		var xmlHttp;
		xmlHttp=new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if (xmlHttp.readyState==4 && xmlHttp.status==200){
				
				var obj = JSON.parse(xmlHttp.responseText);
				prevNotice = parseInt($('#unmsg').html());
            
            
				if(obj.emailUnread > 0){
					if(obj.emailUnread > prevNotice){
						$('#unmsg').html(obj.emailUnread);
						notify.info("Incomming Email!");
					}
				}
			}else {
				alert('There was a problem with the request.');
			}
		}
	}
      
    function makeRequest(url) {
        httpRequest = new XMLHttpRequest();

        if (!httpRequest) {
          alert('Giving up :( Cannot create an XMLHTTP instance');
          return false;
        }
        
        httpRequest.onreadystatechange = alertContents;
        httpRequest.open('GET', url);
        httpRequest.send();
    }
    
    function makeRequest2(url) {
        httpRequest = new XMLHttpRequest();

        if (!httpRequest) {
          alert('Giving up :( Cannot create an XMLHTTP instance');
          return false;
        }
        
        httpRequest.onreadystatechange = alertMessage;
        httpRequest.open('GET', url);
        httpRequest.send();
    }
  
    
    function getAlerts()
    {   
        makeRequest('/icbs/policy/getPendingPolicyCount');
        makeRequest2('/icbs/userMessage/getUnreadMessage');
        CashOnHand();
    }
    
    function CheckIdleTime() {
        _idleSecondsCounter++;
        //var oPanel = document.getElementById("SecondsUntilExpire");
        //if (oPanel)
        //    oPanel.innerHTML = (IDLE_TIMEOUT - _idleSecondsCounter) + "";
        
        
        //$('#ppex').html(${pendingPolicyExceptions});
       // console.log("SecondsUntilExpire : "+ (IDLE_TIMEOUT - _idleSecondsCounter) );
        if (_idleSecondsCounter >= IDLE_TIMEOUT) {
             
            //document.location.href = "logout.html";
            var res = $.post("${createLink(uri: '/authentication/forcelogout')}");
            res.success(function(){
                    clearInterval(_idleTimeoutDisable);
                    alertify.alert(AppTitle,"Time expired!",function(){
                    location.reload(); });
            });
            //$.ajax({ type : 'POST', url: "${createLink(uri: '/authentication/logout')}"});
        } 
    }
    // Added notify global function for ICBS - 
    
    function getImg(x)
    {
        switch(x)
        {
            case "success" :
                return "/icbs/assets/alert/check.jpg";break;
            case "warning" :
                return "/icbs/assets/alert/warning.jpg";break;
            case "error" :
                return "/icbs/assets/alert/error.jpg";break;
            case "info" :
                return "/icbs/assets/alert/info.jpg";break;
            case "alert" :
                return "/icbs/assets/alert/siren.jpg";break;
        }
    }
    var notify = {
        init : function(){
            alertify.set('notifier','position', 'top-right');
        },
     
        message : function(s) {
            if(s.indexOf("|") > -1)
            {
                var msg = s.split("|"), whatkind = msg[1];
                if(msg.length > 2)
                {
                    whatkind = msg[2];
                } 
                
             //    var msg = (s.split("|"))[0], whatkind = (s.split("|"))[1];
             //   console.log(whatkind.indexOf("warn"));
                if(whatkind.indexOf("warn") == 0)
                {
                    
                    whatkind = "warning";
                }
                this.init();
                if(whatkind == 'alert')
                {
                    if(msg.length > 2)
                    { 
                        var newmsg = "<div class='col-md-2'><img src='"+getImg(msg[1])+"' height=64 width=64></div>";
                        newmsg += "<div class='col-md-10'><h5>"+msg[0]+"</h5></div>";
                        alertify.alert(AppTitle,newmsg,function(){});
                    } else {
                        alertify.alert(AppTitle,msg[0],function(){});
                    }
                } else {
                    alertify.notify(msg[0],whatkind);
                }
            } else {
                this.info(s);
            }
            //console.log(s);
           },
        success : function(s) {
                this.init();
                alertify.success(s);
           },
        error : function(s) {
                this.init();
                alertify.error(s);
           },
        info : function(s) {
                this.init();
                alertify.notify(s);
           },
        warn : function(s) {
                this.init();
                alertify.warning(s);
           },
        warning : function(s) {
                this.init();
                alertify.warning(s);
           },
        alert : function(s) {
            this.init();
            alertify.alert(AppTitle,s);
        },
        confirm : function(s) {
           this.init();
           var ret = alertify.confirm(AppTitle,s);
           return ret;
        }
    }
    
    
    function nFix(n,d)
    {
        var s = n;
        s = s.replace(/[^0-9\.]+/g,'');
        if(d)
        {
           // return (n.replace(/[^0-9\.]+/g,''));
           return parseFloat(s);
        } else 
        {
           // return (n.replace(/[^0-9\.]+/g,'')).toFixed(d);
           return parseFloat(s).toFixed(d);
        }
        
        
    }
    
    

    $(".nav-trigger").change(function() 
    {
      if($(this).is(":checked")) {
        $(".sidebar_header h2").css("display","block");
        $("#sidebar_menu").animate({ 
          width: "200px"
        }, 200, function() {});
      }
      else
      {
        $(".sidebar_header h2").css("display","none");
        $("#sidebar_menu").animate({ 
          width: "50px"
        }, 500, function() {});      
      } 
    });

    $(".nav-trigger").trigger("change");

    jQuery.expr[':'].Contains = function(a,i,m)
    {
        return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
    };

    $(".search_form").click(function() 
    {
    
      //if(!$(".nav-trigger").is(":checked")) {
      //  $(".nav-trigger").prop("checked", true).trigger("change");
      //}
      
    });

    $("#menu-search").change( function () 
    {
      
        var filter = $(this).val();
        if(filter != "") 
        {
            $("#ul-results").find("a:not(:Contains(" + filter + "))").parent().slideUp(100);
            var results = $("#ul-results").find("a:Contains(" + filter + ")");
            results.parent().show();
            
            if(results.length < 1)
            {
              $("#no-results").show();
            } else {
              $("#no-results").hide();
            }
           $(".close_search").show();
           $(".search_results").slideDown(100);
        }
        else
        {
          $(".close_search").hide();
          $(".search_results").slideUp(100);
        }
      }).keyup( function () 
      {
          $(this).change();
      });

      $(".close_search").click(function() 
      {
         $("#menu-search").val("");
         $(".search_results").slideUp(200);
         $(".close_search").hide();
         $("#menu-search").focus();
      });
      
      function sendtojasperver(reportlink){
            
            window.open(reportlink);
      }
      
      function dateformat(datestring) {
            var dateObj = new Date(datestring);
            var month = dateObj.getMonth() + 1 ; //months from 1-12
            var day = dateObj.getDate();
            var year = dateObj.getFullYear();

            return newdate = year + "-" + month + "-" + day;
            //document.getElementById("demo").innerHTML = newdate;
        }
      
  </script>

  <script type="text/javascript">
    var form_out = null;
    
    var checkIfAllowed = function(policyCode, form, description, amount) {

      form_out = form;
      $.ajax({
          method: "POST",
          data: {policyCode:policyCode, amount:amount, description:description},
          url: "${g.createLink(controller:'policy', action:'checkIfAllowed')}",
          dataType: "json",
          success: function(data) {
            isAllowed =  data['isAllowed'];
            if(isAllowed == 'true') {
              if(typeof form === 'function'){
                $('#override').hide();
				form();
              } else {
                $('#override').hide();
				// alert(form);
                $(form).submit();
              }
              
            }
            else {
              $("#policyCode").val(policyCode);
              $("#logDescription").val(description);
              $("#overrideAmount").val(amount);
              // $("#form").val(form);
              $("#override").modal('toggle').draggable();
            }
          },
        });
    }
    $(document).ready(function() {
      $( "#override_button" ).click(function() {
        $.ajax({
          method: "POST",
          data:{username:$('#usernameOverrider').val(), password:$('#passwordOverrider').val(), policyCode:$('#policyCode').val(), logDescription:$('#logDescription').val(), overrideAmount:$('#overrideAmount').val()},
          url: "${g.createLink(controller:'authentication', action:'overrideAuthenticate')}",
          dataType: "json",
          success: function(data) {
              if(data['isAllowed'] == 'true') {
                if(typeof form_out === 'function'){
                    $('#override').hide();	
                    form_out();
                } else{
                    $('#override').hide();
                    $(form_out).submit();
                }
              }
              if(data['message']) {
                $('#override').show();
                $('#overrideError').show();
                $('#overrideError').html(data['message']);
              }
          },
        });
      });
    });
    
    // notify usage
    // notify.success('notify.success("test")');
    // notify.error('notify.error("test")');
    // notify.warn('notify.warn("test")');
    // notify.info('notify.info("test")');
    // notify.message('notify.message("test")');
    // notify.message('notify.message("testwarn")|warn');
    
    function empty(v) {
                var type = typeof v;
                if(type === 'undefined')
                    return true;
                if(type === 'boolean')
                    return true;
                if(v === null)
                    return true;
                if(v == undefined)
                    return true;
                if(type === 'array' || type === 'string')
                    if(v.length < 1)
                        return true;
                else if(type === 'object')
                    if(Object.keys(v).length < 1)
                        return true;
                return false;
            }
          $('#transdate').datepicker();
          $('#duedate').datepicker();
          
          
          
  </script>
  <script type="text/javascript">
     Morris.Line({
  element: 'line-chart',
  data: [
    { y: '2008', a: 50,  b: 40 },
    { y: '2009', a: 75,  b: 65 },
    { y: '2010', a: 50,  b: 40 },
    { y: '2011', a: 75,  b: 65 },
    { y: '2012', a: 100, b: 90 }
  ],
  xkey: 'y',
  ykeys: ['a', 'b'],
  labels: ['Series B', 'Series B'],
  hideHover: ['auto'],
  fillOpacity: ['0.0', '0.0']
});
Morris.Bar({
  element: 'bar-chart',
  data: [
    { y: '2006', a: 100, b: 90 },
    { y: '2007', a: 75,  b: 65 },
    { y: '2008', a: 50,  b: 40 },
    { y: '2009', a: 75,  b: 65 },
    { y: '2010', a: 50,  b: 40 },
    { y: '2011', a: 75,  b: 65 },
    { y: '2012', a: 100, b: 90 }
  ],
  xkey: 'y',
  ykeys: ['a', 'b'],
  labels: ['Series A', 'Series B'],
  barColors: ['#d2d6de', '#00a65a'],
  hideHover: ['auto'],
  pointColor: ['#000']
});
</script>

  <asset:javascript src="vue.min.js"/>
  <asset:javascript src="batch.js"/>
  <asset:javascript src="glSearch.js"/>
  <asset:javascript src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" /> 
  <!--10/27/2017 added by Calvhin-->
  <asset:javascript src="bootbox.js" />  
  </body>
</html>