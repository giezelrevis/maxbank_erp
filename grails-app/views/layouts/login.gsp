<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title><g:layoutTitle /> [ICBS]</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    <asset:javascript src="jquery-1.11.1.min.js"/>
    <asset:javascript src="bootstrap.min.js"/>
    <asset:javascript src="jquery-ui.min.js"/>
    <asset:javascript src="select2.min.js"/>
    <asset:javascript src="TreeListFilter.js"/>
    <asset:javascript src="application.js"/>
    <asset:javascript src="plugins/datepicker/bootstrap-datepicker.js"/>
    <!--Custom Javascripts Kr Yap-->
    <asset:javascript src="namespace.js"/>
    <asset:javascript src="ICBSDependencies.js"/>
    <asset:javascript src="search.js"/>
    <asset:stylesheet src="myCustomStyleSheet.css"/>
    <asset:stylesheet src="bootstrap.min.css"/>
    <asset:stylesheet src="select2.css"/>
    <asset:stylesheet src="select2-bootstrap.css"/>
    <asset:stylesheet src="datepicker3.css"/>
    <link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Morris chart -->
    <asset:stylesheet src="AdminLTE/morris/morris.css"/>
    <!-- jvectormap -->
    <asset:stylesheet src="AdminLTE/jvectormap/jquery-jvectormap-1.2.2.css"/>
    <!-- bootstrap wysihtml5 - text editor -->
    <asset:stylesheet src="AdminLTE/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css"/>
    <!-- Theme style -->
    <!--asset:stylesheet src="AdminLTE/AdminLTE.css"/-->
    <asset:stylesheet src="main.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style>
      <!--#body-gradient {background-image: url('${resource(dir: "images", file: "body-gradient.png")}')}-->
      #body-bgcolor {background-color: bg-black}
      #logo-bar {background-image: url('${resource(dir: "images", file: "bg-translucent.png")}'); padding:0;}
    </style>
    <g:layoutHead/>

  </head>
<body class="index-page">
   <!-- SIDEBAR NAVIGATION -->
    <g:if test="${session.user!=null}">
        <div id="sidebar_menu" class="hidden-print">
            <div class="sidebar_header">
              <h2>Navigation</h2>
            </div>
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
                      <li><a href="${createLink(uri: it.uri)}">${it.name}</a></li>
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

    <!--akdsauli: change background color | 
    NOTE: comment lines are the original code -->
    <!--<div class="bodywrap <g:if test="${session.user!=null}">withsidebar</g:if>">-->
    <div class="bodywrap <g:if test="${session.user!=null}">withsidebar</g:if><g:if test="${session.user==null}">loginbottom</g:if>">
    <!--<div id="body-gradient" class="hidden-print" style="background-image: url('${resource(dir: "images", file: "body-gradient.png")}')"> -->
    <div id="body-bgcolor" class="hidden-print" style="background-color: bg-black">
    </div>
    <!-- header logo: style can be found in header.less -->
    <header class="header">
      <div id="user-bar" class="hidden-print">
        <ul>
          <g:if test="${session.user!=null}">
            <li><a href="${createLink(uri: '/userMaster/changePassword')}"><span class="fa fa-user icon"></span>${session.user}</a></li>
            <li><a href="${createLink(uri: '/userMessage')}"><span class="fa fa-envelope icon"></span>Messages <span class="secondary-label">${unreadMessages}</span></a></li>
            <li><a href="${createLink(uri: '/policyException')}"><span class="fa fa-exclamation-circle icon"></span>Alerts <span class="secondary-label">${pendingPolicyExceptions}</span></a></li>
            <li><a href="${createLink(uri: '/authentication/logout')}"><span class="fa fa-sign-out icon"></span>Logout</a></li>
          </g:if>
          <g:if test="${session.user==null}">
            <span style="color:#fff;">${icbs.admin.Institution.findByParamCode('GEN.10150').paramValue}</span>
          </g:if>
        </ul>
      </div>
      <!--<div id="logo-bar">-->
      <div id="<g:if test="${session.user!=null}">logo-bar</g:if>">
        <!--<a href="${createLink(uri: '/')}" class="logo">-->
          <g:if test="${session.user!=null}">
            <a href="${createLink(uri: '/')}" class="logo">
            <img src="${resource(dir: "images", file: "mbphil-logo.jpg")}" alt="Bank Logo" />
            </a>
          </g:if>
        <div class="location">
          <g:if test="${session.user!=null}">
            <p><span class="fa fa-map-marker icon"></span>${session.branch}</p>
            <p><span class="fa fa-calendar icon"></span>${g.formatDate(date: (runDate), format: 'E, dd MMMM yyyy')}
          </g:if>
          </p>
        </div>
        <g:if test="${session.user!=null}">
          <div class="search hidden-print">
            <div class="search-bar">
              <form action="#" method="get" class="sidebar-form">
                <div class="input-group">
                  <input type="text" name="q" class="form-control" placeholder="Search..."/>
                  <span class="input-group-btn">
                    <button type='submit' name='seach' id='search-btn' class="btn btn-flat btn-primary"><span class="glyphicon glyphicon-search"></span></button>
                  </span>
                </div>
              </form>
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
        </div>
      </g:if>
      
      
    </header>


    <div id="page-content">
      <g:if test="${pageProperty(name:'title')!=''}">
        <h1><g:layoutTitle /></h1>
      </g:if>
      <div id="main-content">
        <g:pageProperty name="page.main-content"/>
      </div>
      <g:if test="${pageProperty(name:'page.main-actions')!=''}">
        <div id="main-actions" class="hidden-print">
          <div id="sidebar">
            <div class="title">
              Actions
            </div>
            <div class="content">
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

  </div> <!-- END BODYWRAP -->

  <script type="text/javascript">
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
      if(!$(".nav-trigger").is(":checked")) {
        $(".nav-trigger").prop("checked", true).trigger("change");
      }
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

  </script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/0.11.10/vue.min.js"></script>
  <asset:javascript src="batch.js"/>
  </body>
</html>