<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <!--<meta name="layout" content="main" />-->
    </head>
    <body>
        <content tag="main-content">
                <div id="create-deposit" class="content scaffold-create" role="main">

                  <div class="box">

                    <div class="box-header with-border">
                      <h3 class="box-title">Payables</h3>
                    </div>
                    <div class="box-body">
                                                        
                                                        <label>GL Accounts</label><font color="red">*</font>
                        				<select id="bankacctap" class="form-control">
                                                        </select>
                                                        </br>
                                                        <label>Payable Type</label><font color="red">*</font>
                        				<select id="paytype" class="form-control">
                                                        </select>
                                                        </br>
                                                        <label>Payee</label><font color="red">*</font>
				                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>
                                                            <input type="text" class="form-control" id="payee" aria-describedby="basic-addon3" placeholder="Enter here..." >
                                                            <span id="spanpurdesc" class="help-block"></span>
				                        </div>
                                                        </br>
                                                        <label>Check Number</label><font color="red">*</font>
				                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>
                                                            <input type="text" class="form-control" id="chknum" aria-describedby="basic-addon3" placeholder="Enter here..." >
                                                            <span id="spanpurdesc" class="help-block"></span>
				                        </div>
                                                        </br>
                                                        <label>Transaction Date</label><font color="red">*</font>
				                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>
                                                            <input type="text" class="form-control" id="transdate" aria-describedby="basic-addon3" placeholder="Pick a date..." >
                                                            <span id="spanpurdesc" class="help-block"></span>
				                        </div>
                                                        </br>
                                                        <label>Amount</label><font color="red">*</font>
				                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>
                                                            <input type="text" class="form-control" id="amt" aria-describedby="basic-addon3" placeholder="Enter here..." >
                                                            <span id="spanpurdesc" class="help-block"></span>
				                        </div>
                                                        </br>
                                                        <label>Reference</label><font color="red">*</font>
				                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>
                                                            <input type="text" class="form-control" id="ref" aria-describedby="basic-addon3" placeholder="Enter here..." >
                                                            <span id="spanpurdesc" class="help-block"></span>
				                        </div>
                                                        </br>
                                                        <label>Particulars</label><font color="red">*</font>
				                        <div class="input-group">
                                                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>
                                                            <input type="text" class="form-control" id="particulars" aria-describedby="basic-addon3" placeholder="Enter here..." >
                                                            <span id="spanpurdesc" class="help-block"></span>
				                        </div>
                    </div>
                  </div>
                </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="Payables.savepayables();">Save</a></li>  
            </ul>
            
        </content>
    </body>
</html>
