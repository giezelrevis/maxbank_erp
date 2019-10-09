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
                      <h3 class="box-title">Fixed Assets</h3>
                    </div>
                    <div class="box-body">
                       <table id="assetlist" class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Asset Code</th>
                                                        <th>Description</th>
                                                        <th>Date Purchased</th>
                                                        <th>Vendor ID</th>
                                                        <th>Cost</th>
                                                        <th>Action</th>
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
                <li><a class="save" onclick="Fixedasset.addnewasset();">Add new asset</a></li>  
            </ul>
            <ul>
                <li><g:jasperReport jasper="depreciationreport" format="PDF" name="Depreciation Report">

                </g:jasperReport></li>  
            </ul>
            
        </content>
    </body>
</html>
