<%@ page import="icbs.gl.CfgAcctGlTemplateDet" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cfgAcctGlTemplateDet.label', default: 'CfgAcctGlTemplateDet')}" />
		<title id="titles">Create New Gl Link Entry</title>
	</head>
	<body>
            <content tag="breadcrumbs">
                <span class="fa fa-chevron-right"></span><a href="${createLink(uri: '/cfgAcctGlTemplate')}">Account GL Link Templates</a>
                <span class="fa fa-chevron-right"></span><span class="current">Create New Gl Link Entry</span>
            </content>
            <content tag="main-content">
            <g:javascript>
                $( document ).ready(function() {
                    console.log( "ready!" );
                    document.getElementById('actionmenuCreate').style.display = "block";
                    document.getElementById('actionmenuEdit').style.display = "none";
                    document.getElementById("glCode").readOnly = true;
                    document.getElementById("glDescription").readOnly = true;
                    
                    changeDropdownStatus();
                    
                });
                function validateFields(urlnumber){
                     console.log("URL NUMBER: "+urlnumber);
                    var cfgdetid = $('#cfgdetid').val(); 
                    var cfgtemplateid = $('#cfgtemplateid').val();
                    var transactionType = $('#transactionType').val();
                    var status
                    if(transactionType==4){
                         status = $('#status1').val();
                    }else{
                         status = $('#status').val();
                    }
                    var glCode = $('#glCode').val();
                    var glDescription = $('#glDescription').val();
                    var ordinalPos = $('#ordinals').val();
                    var actionUrl = "";

                    
                    
                    if(cfgtemplateid=="" || glCode=="" || glDescription=="" || ordinalPos=="" || status=="" || transactionType==""){
                        
                        alertify.alert(AppTitle,"Cannot proceed, Fields with null values ",
                            function(){
                               
                            }
                         );  

                    }else{
                        var confirmation="";
                        var url;
                        if(urlnumber==1){
                            actionUrl = 'insertnewcfgDetAjax';
                            url = "${createLink(controller:'CfgAcctGlTemplateDet', action: 'insertnewcfgDetAjax')}";
                            console.log('actionUrl: '+actionUrl);
                            confirmation = "Are you sure you want to create this ?";

                        }else{
                            actionUrl = 'editCfgDetInformationAjax';
                            url = "${createLink(controller:'CfgAcctGlTemplateDet', action: 'editCfgDetInformationAjax')}";
                            console.log('actionUrl: '+actionUrl);
                            confirmation = "Are you sure you want to Update this ?";
                        }
                        alertify.confirm(AppTitle,confirmation,
                            function(){
                                var financialyear = $('#finyear').val();
                                var branchid = $('#brchid').val();

                                console.log("*****************************************");
                                console.log("cfgdetid: "+cfgdetid);
                                console.log("cfgtemplateid: "+cfgtemplateid);
                                console.log("transactionType: "+transactionType);
                                console.log("status: "+status);
                                console.log("glCode: "+glCode);
                                console.log("ordinalPos: "+ordinalPos);
                                console.log("glDescription: "+glDescription);
                                console.log("financialyear: "+financialyear);
                                console.log("branchid: "+branchid);
                                console.log("*****************************************");

                                var obj = { 
                                       glcode: glCode,
                                       financialyear: financialyear,
                                       branchid: branchid,
                                }; 

                                console.log(JSON.stringify(obj));
                                console.log("Object Loaded iwth data...");

                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json",
                                    url: "${createLink(controller:'CfgAcctGlTemplateDet', action: 'checkGlcodeAjax')}",
                                    data: JSON.stringify(obj),
                                    success: function(data){
                                        if(data.length >=1){

                                            var obj = { 
                                                cfgtemplateid: cfgtemplateid,
                                                transactiontype: transactionType,
                                                statustype: status,
                                                ordinalvalue: ordinalPos,
                                                glcode: glCode,
                                                gldescription: glDescription,
                                                cfgdetid: cfgdetid,
                                            }; 
                                            console.log(JSON.stringify(obj));
                                            $.ajax({
                                                type: "POST",
                                                contentType: "application/json",
                                                url: url,
                                                data: JSON.stringify(obj),

                                                success: function(data){
                                                    if(urlnumber==1){
                                                        alertify.alert(AppTitle,"Successfully Created!",
                                                           function(){
                                                               window.location.href="/icbs/cfgAcctGlTemplateDet/show/"+cfgdetid;
                                                           }
                                                       );                                                    
                                                    
                                                    }else{
                                                        alertify.alert(AppTitle,"Successfully Updated!",
                                                           function(){
                                                               window.location.href="/icbs/cfgAcctGlTemplateDet/show/"+cfgdetid;
                                                           }
                                                       );     
                                                    }


                                                },
                                                error: function(data){

                                                    console.log(data);
                                                    console.log("error updating");

                                                },

                                            });                                     

                                        }else{
                                            alertify.alert(AppTitle,"Sorry!. Invalid Gl Code!",
                                                function(){

                                                }
                                            ); 
                                        }


                                    },
                                    error: function(data){

                                        console.log(data);
                                        console.log("error updating");

                                    },

                                });  
                            },
                            function(){
                             
                            }
                        );
                    }
                }
                
                function changeDropdownStatus(){
                    var dropdownvalue = $('#transactionType').val();
                    
                    if(dropdownvalue==1 || dropdownvalue == 2 || dropdownvalue ==3){
                        console.log("Transaction type: Deposit");
                        document.getElementById('statusSelectDeposit').style.display = "block";
                        document.getElementById('statusSelectLoans').style.display = "none";
                    }else{
                        console.log("Transaction type: Loans");
                        document.getElementById('statusSelectDeposit').style.display = "none";
                        document.getElementById('statusSelectLoans').style.display = "block";
                        document.getElementById('ordinalPositionDeposit').style.display = "none";
                        document.getElementById('ordinalPositionLoans').style.display = "block";
                        document.getElementById('ordinaldivCurrent').style.display="block";
                        document.getElementById('ordinaldiv').style.display="none";
                    }
                    checkDuplicatesCfgAcctGlTemplateDetAjax();
                    
                }
                function statusDropDown(){
                   var status 
                   var transactionType = $('#transactionType').val();
                   if(transactionType==1 || transactionType==2 || transactionType==3){
                        status = $('#status').val();
                        document.getElementById('ordinalPositionDeposit').style.display = "block";
                        document.getElementById('ordinalPositionLoans').style.display = "none";
                   }else{
                        status = $('#status1').val();
                        document.getElementById('ordinalPositionDeposit').style.display = "none";
                        document.getElementById('ordinalPositionLoans').style.display = "block";
                        if(status==1){
                            document.getElementById('ordinaldivCurrent').style.display="block";
                            document.getElementById('ordinaldiv').style.display="none";
                        }else{
                            document.getElementById('ordinaldivCurrent').style.display="none";
                            document.getElementById('ordinaldiv').style.display="block";
                        }
                   }
                   console.log('status: '+status);
                   checkDuplicatesCfgAcctGlTemplateDetAjax();
                }
                
                function checkDuplicatesCfgAcctGlTemplateDetAjax(){
                    var cfgtemplateid = $('#cfgtemplateid').val();
                    var transactionType = $('#transactionType').val();
                    var status 
                   
                   if(transactionType==4){
                        status = $('#status1').val();
                   }else{
                        status = $('#status').val();
                   }
                   var ordinalvalue = $('#ordinals').val();
                   console.log("ordinalvalue: "+ordinalvalue);
                   
                   if(cfgtemplateid=="" || transactionType=="" || status=="" || ordinalvalue==""){

                   
                   }else{
                        var obj = { 
                               
                               cfgtemplateid: cfgtemplateid,
                               transactiontype: transactionType,
                               statustype: status,
                               ordinalvalue: ordinalvalue,
                        }; 
                        
                        console.log(JSON.stringify(obj));
                        console.log("Object Loaded iwth data...");
                        
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "${createLink(controller:'CfgAcctGlTemplateDet', action:'checkduplicatesCfgglAcctDetAjax')}",
                            data: JSON.stringify(obj),

                            success: function(data){
                                if(data.length >=1){
                                    alertify.confirm(AppTitle,"There was an Existing record on CfgAcctGlTemplateDet Table Would you like to Update it?",
                                        function(){
                                          
                                          $.each(data, function (_key, _value) {
                                                console.log(JSON.stringify(data));
                                                console.log(_value.gl_code);
                                                console.log(_value.gl_description);
                                                document.getElementById("glCode").readOnly = false;
                                                document.getElementById("glDescription").readOnly = false;
                                                $('#cfgdetid').val(_value.id);
                                                console.log("cfgdetid: "+_value.id);
                                                $("#glCode").val (_value.gl_code); 
                                                $('#glDescription').val(_value.gl_description);
                                                
                                                document.getElementById('actionmenuCreate').style.display = "none";
                                                document.getElementById('actionmenuEdit').style.display = "block";
                                          });
                                        },
                                        function(){
                                          
                                          document.getElementById("glCode").readOnly = true;
                                          document.getElementById("glDescription").readOnly = true;
                                          $("#glCode").val (''); 
                                          $('#glDescription').val('');
                                          
                                        }
                                    );
                                    
                                }else{
                                    console.log("success you can add....");
                                    document.getElementById("glCode").readOnly = false;
                                    document.getElementById("glDescription").readOnly = false;
                                    $("#glCode").val (''); 
                                    $('#glDescription').val('');
                                }                
                            },
                            error: function(data){
                            
                                console.log(data);
                                console.log("error updating");
                                
                            },

                        });                 
                   }
                }
                
                
                
            </g:javascript> 

		<div id="edit-cfgAcctGlTemplateDet" class="content scaffold-edit" role="main">
                 <!-- CFG Template -->   
                 <div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="GL Acct Template id" />
                                    <span class="required-indicator">*</span>
                            </label>
                            <g:hiddenField id="cfgdetid" name="cfgdetid" value=""/>
                            <g:hiddenField id="cfgtemplateid" name="cfgtemplateid" value="${params.id}"/>
                            <g:hiddenField id="finyear" name="finyear" value="${g.formatDate(date: (runDate), format: 'yyyy')}"/>
                            <g:hiddenField id="brchid" name="brchid" value="${icbs.admin.Branch.findByName(session.branch).id}"/>
                            
                            
                            <div class="col-sm-8"><g:textField id="cfgdescripss" name="cfgdescripss" required="" value="${icbs.gl.CfgAcctGlTemplate.findById(params.id).description}" class="form-control" readonly="readonly" />
                            </div>             
                    </div>
                     <!-- TRANSACTION TYPE -->
                    <div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="Transaction Type" />
                              
                                    <span class="required-indicator">*</span>
                            </label>
                            <div class="col-sm-8"><g:select id="transactionType" name="transactionType"  required="true" noSelection="${['':'']}" from="${icbs.lov.GlLinkEntryType.findAllByStatus(true)}" value="" optionKey="id" optionValue ="description"  onChange="changeDropdownStatus();" class="form-control"/>

                            </div>             
                    </div>
                     <!-- STATUS DEPOSIT-->
                    <div id="statusSelectDeposit" class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="Status" />
                              
                                    <span class="required-indicator">*</span>
                            </label>
                            <div  class="col-sm-8"><g:select id="status" name="status"  required="true" noSelection="${['':' ']}" from="${icbs.lov.DepositStatus.findAll{id == 2 || id == 5}}" value="" optionKey="id" optionValue="description"  onChange="statusDropDown();" class="form-control"/>

                            </div>             
                    </div>
                     <!-- STATUS LOANS-->
                    <div id="statusSelectLoans" class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="Status" />
                              
                                    <span class="required-indicator">*</span>
                            </label>
                            <div  class="col-sm-8"><g:select id="status1" name="status1"  required="true" noSelection="${['':'']}" from="${icbs.lov.LoanPerformanceId.findAllByStatus(true)}" value="" optionKey="id" optionValue="description"  onChange="statusDropDown();" class="form-control"/>

                            </div>             
                    </div>
                    <!-- GL ORDINAL POSITION Deposit-->
                    <div id="ordinalPositionDeposit" class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="Ordinal Position" />
                                    <span class="required-indicator">*</span>
                            </label>
                            <div class="col-sm-8"><g:select id="ordinals" name="ordinals" from="${0..3}" value="" noSelection="['':'-Choose Ordinal Position']" onChange="checkDuplicatesCfgAcctGlTemplateDetAjax();" />
                            </div>             
                    </div>
             <!-- GL ORDINAL POSITION Loans-->
                    <div id="ordinalPositionLoans" class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="Ordinal Position" />
                                    <span class="required-indicator">*</span>
                            </label>
                            <div id="ordinaldivCurrent" class="col-sm-8"><g:select id="ordinals" name="ordinals" from="${0..9}" value="" noSelection="['':'-Choose Ordinal Position']" onChange="checkDuplicatesCfgAcctGlTemplateDetAjax();"/>

                            </div>
                            <div id="ordinaldiv" class="col-sm-8"><g:select id="ordinals" name="ordinals" from="${0..8}" value="" noSelection="['':'-Choose Ordinal Position']" onChange="checkDuplicatesCfgAcctGlTemplateDetAjax();"/>

                            </div>   
                    </div>                    

                    <!-- GL CODE -->
                    <div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="GL Code" />
                                    <span class="required-indicator">*</span>
                            </label>
                            <div class="col-sm-8"><g:textField id="glCode" name="glCode" required="" value="" class="form-control"/>

                                <g:hasErrors bean="${cfgAcctGlTemplateDetInstance}" field="glCode">
                                    <div class="controls">
                                            <span class="help-block">
                                                <g:eachError bean="${cfgAcctGlTemplateDetInstance}" field="glCode">
                                                    <g:message error="${it}" /><br/>
                                                </g:eachError>
                                            </span>
                                    </div>
                                </g:hasErrors>
                            </div>             
                    </div>
                    <!-- GL DESCRIPTION -->
                    <div class="fieldcontain form-group ${hasErrors(bean: cfgAcctGlTemplateDetInstance, field: 'glDescription', 'has-error')} required">
                            <label class="control-label col-sm-4" for="glDescription">
                                    <g:message code="cfgAcctGlTemplateDet.glDescription.label" default="GL Description" />
                                    <span class="required-indicator">*</span>
                            </label>
                            <div class="col-sm-8"><g:textField id="glDescription" name="glDescription" required="" value="" class="form-control"/>

                                <g:hasErrors bean="${cfgAcctGlTemplateDetInstance}" field="glDescription">
                                    <div class="controls">
                                            <span class="help-block">
                                                <g:eachError bean="${cfgAcctGlTemplateDetInstance}" field="glDescription">
                                                    <g:message error="${it}" /><br/>
                                                </g:eachError>
                                            </span>
                                    </div>
                                </g:hasErrors>
                            </div>             
                    </div>



		</div>
            </content>
            <content tag="main-actions">
                <ul>
                    <li id="actionmenuCreate"><a href="#" onClick='validateFields(1);' >Create</a></li>
                    <li id="actionmenuEdit"><a href="#" onClick='validateFields(2);' >Edit</a></li>
                    <li><g:link action="show" id="${params.id}">Back</g:link></li>
                </ul>
            </content>
            
	</body>
</html>
