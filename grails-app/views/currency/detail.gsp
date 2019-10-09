<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page import="icbs.admin.Currency" %>
<!DOCTYPE html>


<html>
    
    <head>
		<meta name="layout" content="main">
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<g:set var="entityName" value="${message(code: 'currency.label', default: 'Currency')}" />
		<title>Currency Detail / Breakdown</title>
	</head>
    <body>
        <content tag="breadcrumbs">
		  <span class="fa fa-chevron-right"></span><a href="${createLink(uri:'/currency')}">Currency Maintenance</a>
          <span class="fa fa-chevron-right"></span><span class="current">Currency Detail / Breakdown</span>
		</content>
        <content tag="main-content">
            <h4>${money.code} - ${money.name}</h4>
            <hr />
            <div class="form">
                <form id="frmDetail" name="frmDetail" method="post">
                    <input type="number" id="id" name="id" value=0 style="display:none">
                    <input type="number" id="moneyid" name="moneyid" value="${money.id}" style="display:none">
                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" >Index</label>
                        <div class="col-sm-4">
                            <input type="number" required id="index" name="index" class="form-control">
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" >Short Description</label>
                        <div class="col-sm-4">
                            <input type="text" required id="shortdesc" name="shortdesc" class="form-control">
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" >Long Description</label>
                        <div class="col-sm-4">
                            <input type="text" required id="longdesc" name="longdesc" class="form-control">
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-sm-2" >Value</label>
                        <div class="col-sm-4">
                            <input type="number" required id="value" name="value" class="form-control">
                        </div>
                    </div>
                    <br />
                    <input type="reset" class="btn btn-primary" value="New / Clear Form">
                    <br />
                </form>
            </div>
            <table id="money_detail" class="table">
                <thead>
                <th>Index</th>
                <th>Short Description</th>
                <th>Long Description</th>
                <th>Value</th>
                </thead>
                <tbody>
        <script>
            function getMoney(a,b,c,d,e)
            {
                id.value = a;
                index.value = b;
                shortdesc.value = c;
                longdesc.value = d;
                value.value = e;
            }
        </script>
        
                    <g:each in="${moneydetail}">
                        <tr>
                            <td><a href='#' onclick='getMoney(${it.id},${it.index},"${it.shortdescription}","${it.longdescription}",${it.currencyvalue})'>${it.index}</a></td>
                            <td>${it.shortdescription}</td>
                            <td>${it.longdescription}</td>
                            <td>${it.currencyvalue}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </content>
        <content tag="main-actions">
            <ul>
           
                <li ><a href="#"  onclick="
                    $.post('/icbs/currency/updateDetail',$('#frmDetail').serialize(),function(data){
                        if(data.indexOf('success'))
                        {
                            alertify.alert(AppTitle,data.split('|')[0],function(){ location.reload(); })
                        }
                    });
                    ">Update</a></li>
                <li ><a href="#"  onclick="
                    console.log(id.value);
                    if(!id.value)
                    {
                        alertify.alert(AppTitle,'Unable to delete an item, please select an item.');return;
                    }
                    $.post('/icbs/currency/deleteDetail',$('#frmDetail').serialize(),function(data){
                        if(data.indexOf('success'))
                        {
                            alertify.alert(AppTitle,data.split('|')[0],function(){ location.reload(); })
                        }
                    });
                    ">Delete</a></li>
                <li><g:link action="index"  >Cancel</g:link></li>
                
            </ul>
        </content>
        
       
       
    </body>
</html>
