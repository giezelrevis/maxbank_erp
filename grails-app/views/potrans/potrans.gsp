<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="main" />
    </head>
    <body>
        <content tag="main-content">
                <div id="create-deposit" class="content scaffold-create" role="main">

                  <div class="box">

                    <div class="box-header with-border">
                      <h3 class="box-title">Disburse Assets</h3>
                      <h2 id="total" class="box-title"></h2>
                    </div>
                    <div class="box-body">
                       <table id="disburseasset" class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th></th>
                                                        <th>Asset Code</th>
                                                        <th>Description</th>
                                                        <th>Date Purchased</th>
                                                        <th>Vendor</th>
                                                        <th>Cost</th>
                                                        <!--<th>Action</th>-->
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                          </table>
                    </div>

                    <!-- /.box-body -->
                  </div>
            </div>
        </content>
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="Payables.disbursehero(this);">Disburse Assets</a></li>  
            </ul>

        </content>
    </body>
</html>
