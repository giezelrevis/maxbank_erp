/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var Fixedasset = {
    
    glaccxyz: function() {
      console.log("im in");
    },

    fixedassetlist: function() {
        
        $.ajax({
    	    type: 'post',
    	    contentType: "application/json",
    	    url: '/icbs/fixedasset/showassets',
    	    success: function(data) {
        		console.log(JSON.stringify(data));
        		$('#assetlist').dataTable().fnClearTable();
                        $('#assetlist').dataTable().fnDestroy();
                        $('#assetlist > tbody').html('');
                        $.each(data, function (_key, _value) {
                             var tr = "<tr id=" + _value.id + ">";

                                tr += "<td>" + _value.assetcode + "</td>";
                                tr += "<td>" + _value.assetdesc + "</td>";
                                tr += "<td>" + _value.purdate + "</td>";
                                tr += "<td>" + _value.vendorlink + "</td>";
                                tr += "<td>" + _value.purcost + "</td>";
                                tr += "<td><button type='button' class='btn btn-primary btn-xs' onclick='Fixedasset.modifyasset(" + _value.id + ");'>Edit Asset</button><button type='button' class='btn btn-danger btn-xs' onclick='Fixedasset.deleteasset(" + _value.id + ");'>Delete Asset</button></td>";
                                tr += "</tr>";
                                $('#assetlist').append(tr);

                        });
                        $('#assetlist').DataTable();
        	    },
        	    error: function(data) {
                        console.log(data);
        	    }
        	});  
        
    },
    
    //$( document ).ready(function() {
    addnewasset: function() {
          
          bootbox.dialog({
                  size: 'large',
                  title: "New Asset",
                  message: 
                          '<div class="box box-default" style="border:none">' +
                              
                              '<div class="box-body" style="border:none">' +
                                  '<div class="row">' +
                                              '<div class="col-md-6">' +                                       
                                                  '<h2>Details</h2>' +  
                                                  //asset number
                                                  '<label>Asset Number</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>' +
                                                    '<input type="text" class="form-control" id="assno" aria-describedby="basic-addon3">' +
                                                    '<span id="spanassno" class="help-block"></span>' +
                                                  '</div>' +
                                                  //asset account
                                                  '<label>Asset Account</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span></span>' +
                                                    '<select id="assacct" class="form-control">' +

                                                    '</select>' +
                                                    '<span id="spanassacct" class="help-block"></span>' +
                                                  '</div>' +
                                                  //accumulated
                                                  '<label>Accumulated</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                    //'<input type="text" class="form-control" id="accumulated" aria-describedby="basic-addon3">' +
                                                    '<select id="accumulated" class="form-control">' +

                                                    '</select>' +
                                                    '<span id="spanaccumulated" class="help-block"></span>' +
                                                  '</div>' +
                                                  //expense
                                                  '<label>Expense</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                    //'<input type="text" class="form-control" id="expnse" aria-describedby="basic-addon3">' +
                                                    '<select id="expnse" class="form-control">' +

                                                    '</select>' +
                                                    '<span id="spanexpnse" class="help-block"></span>' +
                                                  '</div>' +
                                              '</div>' +
                                              '<div class="col-md-6">' +  
                                                  '<h2>Asset Information</h2>' +
                                                  //Description
                                                  '<label>Description</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></span>' +
                                                    '<input type="text" class="form-control" id="assdesc" placeholder="Enter asset description..." aria-describedby="basic-addon3">' +
                                                    '<span id="spanassdesc" class="help-block"></span>' +
                                                  '</div>' +
                                                  //Purchase Order number
                                                  '<label>PO No.</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></span>' +
                                                    '<input type="text" class="form-control" id="pono" placeholder="Enter PO..." aria-describedby="basic-addon3">' +
                                                    '<span id="spanpono" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Serial Number
                                                  '<label>Serial No.</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-barcode" aria-hidden="true"></span></span>' +
                                                    '<input type="text" class="form-control" id="seno" placeholder="Enter Serial..." aria-describedby="basic-addon3">' +
                                                    '<span id="spanseno" class="help-block"></span>' +
                                                  '</div>' +
                                              '</div>' +
                                  '</div>' +
                                  '<div class="row">' +

                                            '<div class="col-md-6">' +                                                
                                                  '<h2>Purchase Information</h2>' +
                                                  
                                                  //Vendor link
                                                  '<label>Vendor Link</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></span>' +
                                                    '<select id="vlink" class="form-control">' +

                                                    '</select>' +
                                                    '<span id="spanvlink" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Purchase Date
                                                  '<label>Purchase Date</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>' +
                                                    '<input type="text" class="form-control" id="purdate" placeholder="Enter Date..." aria-describedby="basic-addon3">' +
                                                    '<span id="spanpurdate" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Purchase Cost
                                                  '<label>Purchase Cost</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                    '<input type="text" class="form-control" id="asscost" placeholder="Enter Cost..." aria-describedby="basic-addon3">' +
                                                    '<span id="spanasscost" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Is New
                                                  '<label>Is new</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3">@</span>' +
                                                    '<select id="inx" class="form-control">' +
                                                    '<option value="1">Yes</option>' +
                                                    '<option value="0">No</option>' +
                                                    '</select>' +
                                                    '<span id="spanin" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Salvage Value
                                                  '<label>Salvage Value</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                    '<input type="text" class="form-control" id="salval" placeholder="Enter Salvage Value..." aria-describedby="basic-addon3">' +
                                                    '<span id="spansalval" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Life in years
                                                  '<label>Life in years</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tree-deciduous" aria-hidden="true"></span></span>' +
                                                    '<input type="text" class="form-control" id="liy" placeholder="Enter Life Years..." aria-describedby="basic-addon3">' +
                                                    '<span id="spanliy" class="help-block"></span>' +
                                                  '</div>' +
                                              '</div>' +    
                                              '<div class="col-md-6">' +    
                                                  '<h2>Accounting Information</h2>' +

                                                  //Depreciable Value
                                                  '<label>Depreciable Value</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                    '<input type="text" class="form-control" id="dvalue" aria-describedby="basic-addon3" disabled>' +
                                                    '<span id="spandvalue" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Annual Depreciation Expense
                                                  '<label>Annual Depreciation Expense</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                    '<input type="text" class="form-control" id="ade" aria-describedby="basic-addon3" disabled>' +
                                                    '<span id="spanade" class="help-block"></span>' +
                                                  '</div>' +
                                                  
                                                  //Monthly Depreciation Expense
                                                  '<label>Monthly Depreciation Expense</label><font color="red">*</font>' +
                                                  '<div class="input-group">' +
                                                    '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' + 
                                                    '<input type="text" class="form-control" id="mde" aria-describedby="basic-addon3" disabled>' +
                                                    '<span id="spanmde" class="help-block"></span>' +
                                                  '</div>' +
                                                   
                                            '</div>' +
                                          '</div>' +
                              '</div>' +
                              
                              
                          '</div>',
                  buttons: {
                      success: {
                          label: "Save",
                          className: "btn-success",
                          callback: function () {
                             
                              if($('#assno').val() === '') {
                                  
                                  $('#spanassno').html("Please enter asset number!!!");
                                  return false;
                              }
                              
                              if($('#assacct').val() === '') {
                                  
                                  $('#spanassacct').html("Please enter asset account!!!");
                                  return false;
                              }
                              
                              if($('#accumulated').val() === '') {
                                  
                                  $('#spanaccumulated').html("Please enter accumulated!!!");
                                  return false;
                              }
                              
                              if($('#expnse').val() === '') {
                                  
                                  $('#spanexpnse').html("Please enter expense!!!");
                                  return false;
                              }
                              
                              if($('#assdesc').val() === '') {
                                  
                                  $('#spanassdesc').html("Please enter expense!!!");
                                  return false;
                              }
                              
                              if($('#pono').val() === '') {
                                  
                                  $('#spanpono').html("Please enter PO number!!!");
                                  return false;
                              }
                              
                              if($('#seno').val() === '') {
                                  
                                  $('#spanseno').html("Please enter SERIAL number!!!");
                                  return false;
                              }
                              
                              if($('#purdate').val() === '') {
                                  
                                  $('#spanpurdate').html("Please enter Purchase Date!!!");
                                  return false;
                              }
                              
                              if($('#asscost').val() === '') {
                                  
                                  $('#spanasscost').html("Please enter Purchase Cost!!!");
                                  return false;
                              }
                              
                              if($('#salval').val() === '') {
                                  
                                  $('#spansalval').html("Please enter Salvage Value!!!");
                                  return false;
                              }
                              
                              if($('#liy').val() === '') {
                                  
                                  $('#spanliy').html("Please enter Life in years!!!");
                                  return false;
                              }

                              var obj = {
                                  assno: $('#assno').val(),
                                  assacct: $('#assacct').val(),
                                  accumulated: $('#accumulated').val(),
                                  expnse: $('#expnse').val(),
                                  assdesc: $('#assdesc').val(),
                                  pono: $('#pono').val(),
                                  seno: $('#seno').val(),
                                  vlink: $('#vlink').val(),
                                  purdate: $('#purdate').val(),
                                  asscost: $('#asscost').val(),
                                  inx: $('#inx').val(),
                                  salval: $('#salval').val(),
                                  liy: $('#liy').val(),
                                  dvalue: $('#dvalue').val(),
                                  ade: $('#ade').val(),
                                  mde: $('#mde').val()
                              };
                                      
                              console.log(JSON.stringify(obj));
                              $.ajax({
                                  type: 'POST',
                                  contentType: "application/json",
                                  url: '/icbs/fixedasset/pushasset',
                                  data: JSON.stringify(obj),
                                  success: function(data) {
                                      console.log(data);
                                      bootbox.hideAll();
                                      bootbox.alert("Save success!!!", function() {
                                          location.reload();
                                      });
                                  },
                                  error: function(data) {
                                      console.log(data);
                                  }
                              });
                          }
                      }
                  }
              }
          );

          $('#asscost').keyup(function () {
              
              $('#dvalue').val($('#asscost').val() - $('#salval').val());
              $('#ade').val(($('#asscost').val() - $('#salval').val())/$('#liy').val());
              $('#mde').val((($('#asscost').val() - $('#salval').val())/$('#liy').val())/12);
              
          });
          
          $('#salval').keyup(function () {
              
              $('#dvalue').val($('#asscost').val() - $('#salval').val());
              $('#ade').val(($('#asscost').val() - $('#salval').val())/$('#liy').val());
              $('#mde').val((($('#asscost').val() - $('#salval').val())/$('#liy').val())/12);
              
          });
          
          $('#liy').keyup(function () {
              
              $('#dvalue').val($('#asscost').val() - $('#salval').val());
              $('#ade').val(($('#asscost').val() - $('#salval').val())/$('#liy').val());
              $('#mde').val((($('#asscost').val() - $('#salval').val())/$('#liy').val())/12);
              
          });
          
          $( document ).ready(function() {
              $('#purdate').datepicker();
              Fixedasset.vendorlistselect();
              Fixedasset.glaccount();
              Fixedasset.glaccountaccumulated();
              Fixedasset.glaccountexpense();
              $("#assacct").select2({
                width: '100%',
                minimumInputLength: 3
              });
              $("#accumulated").select2({
                width: '100%',
                minimumInputLength: 3
              });
              $("#expnse").select2({
                width: '100%',
                minimumInputLength: 3
              });
          });
          
      },
    //});
    
    modifyasset: function(x) {
        
        //console.log(x);
        
        var obj = {
          id: x  
        };
        
        console.log(JSON.stringify(obj));
        
        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: '/icbs/fixedasset/editasset',
            data: JSON.stringify(obj),
            success: function(data) {
                console.log(JSON.stringify(data));

                    bootbox.dialog({
                            size: 'large',
                            title: "Edit Asset",
                            message: 
                                    '<div class="box box-default" style="border:none">' +

                                        '<div class="box-body" style="border:none">' +
                                            '<div class="row">' +
                                                        '<div class="col-md-6">' +                                       
                                                            '<h2>Details</h2>' +  
                                                            //asset number
                                                            '<label>Asset Number</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="assno" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanassno" class="help-block"></span>' +
                                                            '</div>' +
                                                            //asset account
                                                            '<label>Asset Account</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="assacct" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanassacct" class="help-block"></span>' +
                                                            '</div>' +
                                                            //accumulated
                                                            '<label>Accumulated</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="accumulated" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanaccumulated" class="help-block"></span>' +
                                                            '</div>' +
                                                            //expense
                                                            '<label>Expense</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="expnse" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanexpnse" class="help-block"></span>' +
                                                            '</div>' +
                                                        '</div>' +
                                                        '<div class="col-md-6">' +  
                                                            '<h2>Asset Information</h2>' +
                                                            //Description
                                                            '<label>Description</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="assdesc" placeholder="Enter asset description..." aria-describedby="basic-addon3">' +
                                                              '<span id="spanassdesc" class="help-block"></span>' +
                                                            '</div>' +
                                                            //Purchase Order number
                                                            '<label>PO No.</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="pono" placeholder="Enter PO..." aria-describedby="basic-addon3">' +
                                                              '<span id="spanpono" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Serial Number
                                                            '<label>Serial No.</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-barcode" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="seno" placeholder="Enter Serial..." aria-describedby="basic-addon3">' +
                                                              '<span id="spanseno" class="help-block"></span>' +
                                                            '</div>' +
                                                        '</div>' +
                                            '</div>' +
                                            '<div class="row">' +

                                                      '<div class="col-md-6">' +                                                
                                                            '<h2>Purchase Information</h2>' +

                                                            //Vendor link
                                                            '<label>Vendor Link</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></span>' +
                                                              '<select id="vlink" class="form-control">' +
                                                              '</select>' +
                                                              '<span id="spanvlink" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Purchase Date
                                                            '<label>Purchase Date</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="purdate" placeholder="Enter Date..." aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanpurdate" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Purchase Cost
                                                            '<label>Purchase Cost</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                              '<input type="text" class="form-control" id="asscost" placeholder="Enter Cost..." aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanasscost" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Is New
                                                            '<label>Is new</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3">@</span>' +
                                                              '<select id="inx" class="form-control" disabled>' +
                                                              '<option value="1">Yes</option>' +
                                                              '<option value="0">No</option>' +
                                                              '</select>' +
                                                              '<span id="spanin" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Salvage Value
                                                            '<label>Salvage Value</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                              '<input type="text" class="form-control" id="salval" placeholder="Enter Salvage Value..." aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spansalval" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Life in years
                                                            '<label>Life in years</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tree-deciduous" aria-hidden="true"></span></span>' +
                                                              '<input type="text" class="form-control" id="liy" placeholder="Enter Life Years..." aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanliy" class="help-block"></span>' +
                                                            '</div>' +
                                                        '</div>' +    
                                                        '<div class="col-md-6">' +    
                                                            '<h2>Accounting Information</h2>' +

                                                            //Depreciable Value
                                                            '<label>Depreciable Value</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                              '<input type="text" class="form-control" id="dvalue" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spandvalue" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Annual Depreciation Expense
                                                            '<label>Annual Depreciation Expense</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' +
                                                              '<input type="text" class="form-control" id="ade" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanade" class="help-block"></span>' +
                                                            '</div>' +

                                                            //Monthly Depreciation Expense
                                                            '<label>Monthly Depreciation Expense</label><font color="red">*</font>' +
                                                            '<div class="input-group">' +
                                                              '<span class="input-group-addon" id="basic-addon3">&#8369;</span>' + 
                                                              '<input type="text" class="form-control" id="mde" aria-describedby="basic-addon3" disabled>' +
                                                              '<span id="spanmde" class="help-block"></span>' +
                                                            '</div>' +

                                                      '</div>' +
                                                    '</div>' +
                                        '</div>' +


                                    '</div>',
                            buttons: {
                                success: {
                                    label: "Update",
                                    className: "btn-success",
                                    callback: function () {

                                        var obj = {
                                            id: x,
                                            assno: $('#assno').val(),
                                            assacct: $('#assacct').val(),
                                            accumulated: $('#accumulated').val(),
                                            expnse: $('#expnse').val(),
                                            assdesc: $('#assdesc').val(),
                                            pono: $('#pono').val(),
                                            seno: $('#seno').val(),
                                            vlink: $('#vlink').val(),
                                            purdate: $('#purdate').val(),
                                            asscost: $('#asscost').val(),
                                            inx: $('#inx').val(),
                                            salval: $('#salval').val(),
                                            liy: $('#liy').val(),
                                            dvalue: $('#dvalue').val(),
                                            ade: $('#ade').val(),
                                            mde: $('#mde').val()
                                        };

                                        console.log(JSON.stringify(obj));
                                        $.ajax({
                                            type: 'POST',
                                            contentType: "application/json",
                                            url: '/icbs/fixedasset/updateasset',
                                            data: JSON.stringify(obj),
                                            success: function(data) {
                                                console.log(data);
                                                console.log('success');
                                            },
                                            error: function(data) {
                                                console.log(data);
                                                console.log('failed');
                                                bootbox.hideAll();
                                                bootbox.alert("Update success!!!", function() {
                                                    location.reload();
                                                });
                                            }
                                        });
                                    }
                                }
                            }
                        }
                    );
            $('#assno').val(data[0].assetcode);
            $('#assacct').val(data[0].glacc);
            $('#accumulated').val(data[0].creditglacc);
            $('#expnse').val(data[0].ebitglacc);
            $('#assdesc').val(data[0].assetdesc);
            $('#pono').val(data[0].assetpo);
            $('#seno').val(data[0].assetserial);
            $('#vlink').val(data[0].vendorlink);
            $('#purdate').val(data[0].purdate);
            $('#asscost').val(data[0].purcost);
            $('#inx').val(data[0].isnew);
            $('#salval').val(data[0].salvagevalue);
            $('#liy').val(data[0].lifeinyears);
            $('#dvalue').val(data[0].deprevalue);
            $('#ade').val(data[0].annualexpense);
            $('#mde').val(data[0].monthlyexpense);
            Fixedasset.vendorlistselect();
            },
                error: function(data) {
                console.log(data);
            }
        });


    },
    
    deleteasset: function(y) {
              
        bootbox.confirm("Delete this asset?", function(result) {

    		if(result) {

                    var obj = {
                        id: y  
                    };
                    
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json",
                        url: '/icbs/fixedasset/deleteasset',
                        data: JSON.stringify(obj),
                        success: function(data) {
                            console.log(data);
                            console.log('success');
                        },
                        error: function(data) {
                            console.log(data);
                            console.log('failed');
                            bootbox.hideAll();
                            bootbox.alert("Asset Deleted!!!", function() {
                                location.reload();
                            });
                        }
                    });       		
            
            }

    	});
     
    },
    
    vendorlistselect: function() {
        
        $.ajax({
	    type: 'post',
	    contentType: "application/json",
	    url: '/icbs/fixedasset/showvendors',
	    success: function(data) {
                $.each(data, function (key, value) {
                   $('#vlink').append("<option value='" + value.id + "'>" + value.companyname + "</option>");
                });
            },
            error: function(data) {
                
            }
        });
        
    },
    
    vendorlist: function() {
 
        $.ajax({
	    type: 'post',
	    contentType: "application/json",
	    url: '/icbs/fixedasset/showvendors',
	    success: function(data) {
    		console.log(JSON.stringify(data));
    		$('#vendorlist').dataTable().fnClearTable();
                    $('#vendorlist').dataTable().fnDestroy();
                    $('#vendorlist > tbody').html('');
                    $.each(data, function (_key, _value) {
                         var tr = "<tr id=" + _value.id + ">";

                            tr += "<td>" + _value.companyname + "</td>";
                            tr += "<td>" + _value.contactname + "</td>";
                            tr += "<td>" + _value.address + "</td>";
                            tr += "<td>" + _value.contactno + "</td>";
                            tr += "<td>" + _value.email + "</td>";
                            tr += "<td><button type='button' class='btn btn-primary btn-xs' onclick='Fixedasset.modifyvendor(" + _value.id + ");'>Edit Vendor</button><button type='button' class='btn btn-danger btn-xs' onclick='Fixedasset.deletevendor(" + _value.id + ");'>Delete Vendor</button></td>";
                            tr += "</tr>";
                            $('#vendorlist').append(tr);

                    });
                    $('#vendorlist').DataTable();
    	    },
    	    error: function(data) {
                    console.log(data);
    	    }
    	});  
        
    },

    glaccount: function() {

      $.ajax({
        type: 'post',
        contentType: "application/json",
        url: '/icbs/fixedasset/showglaccounts',
        success: function(data) {
                console.log(JSON.stringify(data));
                $.each(data, function (key, value) {
                   $('#assacct').append("<option value='" + value.code + "'>" + value.short_name + "</option>");
                });
        },
        error: function(data) {
            console.log(data);
            //assacct accumulated expnse
        }
      });  
        
    },

    glaccountaccumulated: function() {
 
      $.ajax({
        type: 'post',
        contentType: "application/json",
        url: '/icbs/fixedasset/showglaccounts',
        success: function(data) {
                //console.log(JSON.stringify(data));
                $.each(data, function (key, value) {
                   $('#accumulated').append("<option value='" + value.code + "'>" + value.short_name + "</option>");
                });
        },
        error: function(data) {
            //console.log(data);
            //assacct accumulated expnse
        }
      });  
        
    },

    glaccountexpense: function() {
 
      $.ajax({
        type: 'post',
        contentType: "application/json",
        url: '/icbs/fixedasset/showglaccounts',
        success: function(data) {
                //console.log(JSON.stringify(data));
                $.each(data, function (key, value) {
                   $('#expnse').append("<option value='" + value.code + "'>" + value.short_name + "</option>");
                });
        },
        error: function(data) { 
            //console.log(data);
            //assacct accumulated expnse
        }
      });  
        
    },
    
    addnewvendor: function() {
        
        bootbox.dialog({
                title: "New Vendor",
                message: 
                        '<div class="box box-default" style="border:none">' +
                            
                            '<div class="box-body" style="border:none">' +
                                '<div class="row">' +
                                            '<div class="col-md-12">' +                                       
                                                //'<h2>Details</h2>' +  
                                                //Company Name
                                                '<label>Company Name</label><font color="red">*</font>' +
                                                '<div class="input-group">' +
                                                  '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>' +
                                                  '<input type="text" class="form-control" id="compname" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                  '<span id="spancompname" class="help-block"></span>' +
                                                '</div>' +
                                                //Contact Name
                                                '<label>Contact Name</label><font color="red">*</font>' +
                                                '<div class="input-group">' +
                                                  '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span></span>' +
                                                  '<input type="text" class="form-control" id="contname" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                  '<span id="spancontname" class="help-block"></span>' +
                                                '</div>' +
                                                //Address
                                                '<label>Address</label><font color="red">*</font>' +
                                                '<div class="input-group">' +
                                                  '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                  '<input type="text" class="form-control" id="address" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                  '<span id="spanaddress" class="help-block"></span>' +
                                                '</div>' +
                                                //Email Address
                                                '<label>Email Address</label><font color="red">*</font>' +
                                                '<div class="input-group">' +
                                                  '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                  '<input type="text" class="form-control" id="emailadd" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                  '<span id="spanemailadd" class="help-block"></span>' +
                                                '</div>' +
                                                //Contact Number
                                                '<label>Contact Number</label><font color="red">*</font>' +
                                                '<div class="input-group">' +
                                                  '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                  '<input type="text" class="form-control" id="contno" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                  '<span id="spancontno" class="help-block"></span>' +
                                                '</div>' +
                                                //Remarks
                                                '<label>Remarks</label><font color="red">*</font>' +
                                                '<div class="input-group">' +
                                                  '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                  '<input type="text" class="form-control" id="rem" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                  '<span id="spanrem" class="help-block"></span>' +
                                                '</div>' +
                                            '</div>' +
                                '</div>' +
                        '</div>',
                buttons: {
                    success: {
                        label: "Save",
                        className: "btn-success",
                        callback: function () {
                           
                            if($('#compname').val() === '') {
                                
                                $('#spancompname').html("Please enter company name!!!");
                                return false;
                            }
                            if($('#contname').val() === '') {
                                
                                $('#spancontname').html("Please enter contact name!!!");
                                return false;
                            }
                            if($('#address').val() === '') {
                                
                                $('#spanaddress').html("Please enter address!!!");
                                return false;
                            }
                            if($('#emailadd').val() === '') {
                                
                                $('#spanemailadd').html("Please enter email add!!!");
                                return false;
                            }
                            if($('#contno').val() === '') {
                                
                                $('#spancontno').html("Please enter contact no!!!");
                                return false;
                            }

                            var obj = {
                                compname: $('#compname').val(),
                                contname: $('#contname').val(),
                                address: $('#address').val(),
                                emailadd: $('#emailadd').val(),
                                contno: $('#contno').val(),
                                rem: $('#rem').val()
                            };
                                    
                            console.log(JSON.stringify(obj));
                            $.ajax({
                                type: 'POST',
                                contentType: "application/json",
                                url: '/icbs/fixedasset/pushvendor',
                                data: JSON.stringify(obj),
                                success: function(data) {
                                    console.log(data);
                                    bootbox.hideAll();
                                    bootbox.alert("Save success!!!", function() {
                                        location.reload();
                                    });
                                },
                                error: function(data) {
                                    console.log(data);
                                }
                            });
                        }
                    }
                }
            }
        );        
        
    },
    
    modifyvendor: function(item) {
        
        //console.log(x);
        
        var obj = {
          id: item  
        };
        
        console.log(JSON.stringify(obj));
        
        $.ajax({
            type: 'POST',
            contentType: "application/json",
            url: '/icbs/fixedasset/editvendor',
            data: JSON.stringify(obj),
            success: function(data) {
                    bootbox.dialog({
                        title: "Modify Vendor Information",
                        message: 
                                '<div class="box box-default" style="border:none">' +

                                    '<div class="box-body" style="border:none">' +
                                        '<div class="row">' +
                                                    '<div class="col-md-12">' +                                       
                                                        //'<h2>Details</h2>' +  
                                                        //Company Name
                                                        '<label>Company Name</label><font color="red">*</font>' +
                                                        '<div class="input-group">' +
                                                          '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span></span>' +
                                                          '<input type="text" class="form-control" id="compname" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                          '<span id="spancompname" class="help-block"></span>' +
                                                        '</div>' +
                                                        //Contact Name
                                                        '<label>Contact Name</label><font color="red">*</font>' +
                                                        '<div class="input-group">' +
                                                          '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span></span>' +
                                                          '<input type="text" class="form-control" id="contname" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                          '<span id="spancontname" class="help-block"></span>' +
                                                        '</div>' +
                                                        //Address
                                                        '<label>Address</label><font color="red">*</font>' +
                                                        '<div class="input-group">' +
                                                          '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                          '<input type="text" class="form-control" id="address" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                          '<span id="spanaddress" class="help-block"></span>' +
                                                        '</div>' +
                                                        //Email Address
                                                        '<label>Email Address</label><font color="red">*</font>' +
                                                        '<div class="input-group">' +
                                                          '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                          '<input type="text" class="form-control" id="emailadd" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                          '<span id="spanemailadd" class="help-block"></span>' +
                                                        '</div>' +
                                                        //Contact Number
                                                        '<label>Contact Number</label><font color="red">*</font>' +
                                                        '<div class="input-group">' +
                                                          '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                          '<input type="text" class="form-control" id="contno" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                          '<span id="spancontno" class="help-block"></span>' +
                                                        '</div>' +
                                                        //Remarks
                                                        '<label>Remarks</label><font color="red">*</font>' +
                                                        '<div class="input-group">' +
                                                          '<span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span></span>' +
                                                          '<input type="text" class="form-control" id="rem" aria-describedby="basic-addon3" placeholder="Enter here...">' +
                                                          '<span id="spanrem" class="help-block"></span>' +
                                                        '</div>' +
                                                    '</div>' +
                                        '</div>' +
                                '</div>',
                        buttons: {
                            success: {
                                label: "Save",
                                className: "btn-success",
                                callback: function () {

                                    if($('#compname').val() === '') {

                                        $('#spancompname').html("Please enter company name!!!");
                                        return false;
                                    }
                                    if($('#contname').val() === '') {

                                        $('#spancontname').html("Please enter contact name!!!");
                                        return false;
                                    }
                                    if($('#address').val() === '') {

                                        $('#spanaddress').html("Please enter address!!!");
                                        return false;
                                    }
                                    if($('#emailadd').val() === '') {

                                        $('#spanemailadd').html("Please enter email add!!!");
                                        return false;
                                    }
                                    if($('#contno').val() === '') {

                                        $('#spancontno').html("Please enter contact no!!!");
                                        return false;
                                    }

                                    var obj = {
                                        id: item,
                                        compname: $('#compname').val(),
                                        contname: $('#contname').val(),
                                        address: $('#address').val(),
                                        emailadd: $('#emailadd').val(),
                                        contno: $('#contno').val(),
                                        rem: $('#rem').val()
                                    };

                                    console.log(JSON.stringify(obj));
                                    $.ajax({
                                        type: 'POST',
                                        contentType: "application/json",
                                        url: '/icbs/fixedasset/updatevendor',
                                        data: JSON.stringify(obj),
                                        success: function(data) {
                                            console.log(data);
                                            bootbox.hideAll();
                                            bootbox.alert("Update success!!!", function() {
                                                location.reload();
                                            });
                                        },
                                        error: function(data) {
                                            console.log(data);
                                            bootbox.hideAll();
                                            bootbox.alert("Update success!!!", function() {
                                                location.reload();
                                            });
                                        }
                                    });
                                }
                            }
                        }
                    }
                ); 
                $('#compname').val(data[0].companyname);
                $('#contname').val(data[0].contactname);
                $('#address').val(data[0].address);
                $('#emailadd').val(data[0].email);
                $('#contno').val(data[0].contactno);
                $('#rem').val(data[0].remarks);
            },
            error: function(data) {
                
            }
        });

    },
    
    deletevendor: function(dv) {
              
        bootbox.confirm("Delete this vendor?", function(result) {

    		if(result) {

                    var obj = {
                        id: dv  
                    };
                    
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json",
                        url: '/icbs/fixedasset/deletevendor',
                        data: JSON.stringify(obj),
                        success: function(data) {
                            console.log(data);
                            console.log('success');
                        },
                        error: function(data) {
                            console.log(data);
                            console.log('failed');
                            bootbox.hideAll();
                            bootbox.alert("Vendor Deleted!!!", function() {
                                location.reload();
                            });
                        }
                    });       		
            
            }

    	});
     
    }
      
};

Fixedasset.fixedassetlist();
Fixedasset.vendorlist();

// $('#assacct').keyup(function () {

//         var obj = {
//           key: $('#assacct').val()
//         };

//         console.log(JSON.stringify(obj));
//         // $.ajax({
//         //   type: 'post',
//         //   contentType: "application/json",
//         //   url: '/icbs/fixedasset/showglaccounts',
//         //   data: JSON.stringify(obj),
//         //   success: function(data) {
//         //           console.log(JSON.stringify(data));
//         //           $.each(data, function (key, value) {
//         //              $('#assacct').append("<option value='" + value.code + "'>" + value.short_name + "</option>");
//         //           });
//         //   },
//         //   error: function(data) {
//         //       console.log(data);
//         //       //assacct accumulated expnse
//         //   }
//         // });  

// });