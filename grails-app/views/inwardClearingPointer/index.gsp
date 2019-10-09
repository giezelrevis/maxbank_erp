
<!DOCTYPE html>
<html>
    <head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'inwardClearingPointer.label', default: 'InwardClearingPointer')}" />
	<title>Inward Clearing Pointer Maintenance</title>
    </head>
    <body>
         <content tag="breadcrumbs">
                 <span class="fa fa-chevron-right"></span><span class="current">Inward Clearing Pointer Maintenance</span>
            </content>
	<content tag="main-content">
            <div class="content scaffold-show" role="main">
		<g:if test="${flash.message}">
                    <script>
                        $(function(){
                            console.log("haha: "+"${flash.message}");
                            
                            
                            var x = '${flash.message}';
                                
                            alertify.alert(AppTitle,""+x, function(){
                                  
                            });
                                
                        });
                    </script>
                </g:if>
		<g:form>            	
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-2">
				<g:select name="max" value="${params.max}" from="[25, 50, 75, 100]" class="form-control input-sm" onchange="this.form.submit()" />
                            </div>
                            <div class="input-group col-md-10">
				<g:textField  type="text" name="query" class="form-control" placeholder="Enter Code or Name"/>
                                <div class="input-group-btn">
		                    <g:submitButton name="Search" class="btn btn-primary"></g:submitButton>
		                </div>
                            </div>
                        </div>
                    </div>				
                </g:form>
		<div class="table-responsive">		
                    <table class="table table-hover table-condensed table-bordered table-striped">
                        <thead>
                            <tr>					
				<td><label>Description</label></td>
                                <td><label>Inward File BRSTN</label></td>
                                <td><label>Transaction Pointer</label></td>
                                <td><label>Action</label></td>
                            </tr>
			</thead>
			<tbody>
                            <g:each in="${inwardClearingPointerInstanceList}" status="i" var="InwardClearingPointerInstance">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">					
                                    <td>${InwardClearingPointerInstance?.description}</td> 
                                    <td>${InwardClearingPointerInstance?.inwardBRSTN}</td>
                                    <td>${InwardClearingPointerInstance?.txnTemplate?.description}</td>
                                    <td>
                                        <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#editInwardClearingPointerModal${i}">Edit</a>
                                        <a href="#" class="btn btn-danger" onClick="deleteIccPointer(${InwardClearingPointerInstance?.id});">Delete</a>
                                        <script>
                                            function deleteIccPointer(idid){
                                                console.log("icc pointer id: "+idid);
                                                alertify.confirm(AppTitle,"Are you sure you want to delete this?",
                                                    function(){
                                                        //======================== ajax function ====================
                                                            var obj = { 
                                                                
                                                                inwardMasterId: idid
                                                            }; 
                                                            console.log(JSON.stringify(obj));
                                                            console.log("Object Loaded iwth data...");
                                                            $.ajax({
                                                                type: "POST",
                                                                contentType: "application/json",
                                                                url: "${createLink(controller:'InwardClearingPointer', action:'deleteInwardClearingPointer')}",
                                                                data: JSON.stringify(obj),

                                                                success: function(data){

                                                                    if(data.length > 0){

                                                                        window.location.href = "/icbs/inwardClearingPointer";


                                                                    }
                                                                },
                                                                error: function(data){

                                                                },

                                                            });   
                                                            //===================== end of ajax function ================
                                                    },
                                                    function(){
                                                      alertify.error('Canceled');
                                                    });
                                            }
                                        </script>    
                                    </td>
                                    
				</tr>
                                <!-- //--------------------------- MODAL FOR EDIT INWARD CLEARING POINTER -------------------\\  -->
                        
                                <!-- Modal MEMO CREDIT-->
                                <div id="editInwardClearingPointerModal${i}" class="modal fade" role="dialog">
                                    <g:form name="editInwardClearingPointerModal" id="editInwardClearingPointerModal${i}" controller="InwardClearingPointer" action="editInwardClearingPointer" >
                                        <div class="modal-dialog">
                                        <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    <h4 class="modal-title" style="color: black;">Edit Inward Clearing Pointer Details</h4>
                                                </div>

                                                <div class="modal-body">
                                                    <g:hiddenField id="inwardClearId${i}" name="inwardClearId" value="${InwardClearingPointerInstance?.id}" />
                                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                                        <label class="control-label col-sm-4" style="color: gray;">Description: </label>
                                                        <div class="col-sm-8"><g:textField id="description${i}" name="description" value="${InwardClearingPointerInstance?.description}" class="form-control"/></div>
                                                    </div>
                                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                                        <label class="control-label col-sm-4" style="color: gray;">Inward File BRSTN: </label>
                                                        <div class="col-sm-8"> <g:textField id="inwardBRSTN${i}" name="inwardBRSTN" value="${InwardClearingPointerInstance?.inwardBRSTN}" class="form-control"/></div>
                                                    </div>
                                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                                        <label class="control-label col-sm-4" style="color: gray;">Transaction pointer: </label>
                                                        <div class="col-sm-8"><g:select id="txnTemplatePointer${i}" name="txnTemplatePointer" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(7),icbs.lov.MemoTxnType.read(10),[sort:"code", order:"asc"])}" optionKey="id" optionValue ="description" value="${InwardClearingPointerInstance?.txnTemplate?.description}" class="form-control"/></div>
                                                    </div>

                                                </div>

                                                <div class="modal-footer">
                                                    <a href ="#" onclick="validatefieldsEdit(${i});" id="sender" name="sender" class="btn btn-primary">Update</a>
                                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                                </div>
                                                <g:javascript>
                                                    function validatefieldsEdit(x){
                                                        //description/inwardBRSTN/txnTemplatePointer
                                                        var inwardDescription = $('#description'+x).val();
                                                        var inwardBRSTN = $('#inwardBRSTN'+x).val();
                                                        var inwardTxnTemplatePointer = $('#txnTemplatePointer'+x).val();
                                                        var inwardMasterId = $('#inwardClearId'+x).val();
                                                        console.log("inwardDescription: "+inwardDescription);
                                                        console.log("inwardBRSTN: "+inwardBRSTN);
                                                        console.log("inwardTxnTemplatePointer: "+inwardTxnTemplatePointer);

                                                        if(inwardDescription=="" || inwardDescription==null){
                                                            notify.message('Sorr,Inward Clearing Pointer Description cannot be null!|error|alert'); 

                                                        }else if(inwardBRSTN=="" || inwardBRSTN==null){
                                                            notify.message('Sorry,Inward File BRSTN cannot be null!|error|alert'); 
                                                        }else{
                                                            alertify.confirm(AppTitle,"Are you sure you want to update this ?",
                                                                function(){
                                                                    //======================== ajax function ====================
                                                                    var obj = { 
                                                                        inwardDescription: inwardDescription,
                                                                        inwardBRSTN: inwardBRSTN,
                                                                        inwardTxnTemplatePointer: inwardTxnTemplatePointer,
                                                                        inwardMasterId: inwardMasterId
                                                                    }; 
                                                                    console.log(JSON.stringify(obj));
                                                                    console.log("Object Loaded iwth data...");
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        contentType: "application/json",
                                                                        url: "${createLink(controller:'InwardClearingPointer', action:'editInwardClearingPointer')}",
                                                                        data: JSON.stringify(obj),

                                                                        success: function(data){

                                                                            if(data.length > 0){
                                                                                
                                                                                window.location.href = "/icbs/inwardClearingPointer";
                                                                                  
                                                                                 
                                                                            }
                                                                        },
                                                                        error: function(data){

                                                                        },

                                                                    });   
                                                                    //===================== end of ajax function ================
                                                                },
                                                                function(){
                                                                  alertify.error('Canceled!');
                                                                });
                                                        }

                                                    }

                                                </g:javascript>    
                                            </div>

                                        </div>
                                    </g:form>
                                </div>
                                <!-- modal close -->                   
                                <!-- //---------------------------------------END OF MODAL----------------------------------\\  -->
                            </g:each>
			</tbody>
                    </table>
		</div>
		<div class="pagination">
                    <g:paginate total="${interestIncomeSchemeInstanceCount ?: 0}" />
		</div>
            </div>
	</content>
	<content tag="main-actions">
            <ul>
                <li><a href="#" data-toggle="modal" data-target="#newInwardClearingPointerModal" >New Inward Clearing Pointer</a></li> 
                <li><g:link class="icc" controller="deposit" action="viewInwardCheckClearing">Process Inward Clearing</g:link></li>
                
                <!-- //--------------------------- MODAL FOR NEW INWARD CLEARING POINTER -------------------\\  -->
                        
                <!-- Modal MEMO CREDIT-->
                <div id="newInwardClearingPointerModal" class="modal fade" role="dialog">
                    <g:form name="newInwardClearingPointerFormSend" id="newInwardClearingPointerFormSend" controller="InwardClearingPointer" action="saveInwardClearingPointer" >
                        <div class="modal-dialog">
                        <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title" style="color: black;">New Inward Clearing Pointer Details</h4>
                                </div>

                                <div class="modal-body">
                                    
                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                        <label class="control-label col-sm-4" style="color: gray;">Description: </label>
                                        <div class="col-sm-8"><g:textField id="description" name="description" value="" class="form-control"/></div>
                                    </div>
                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                        <label class="control-label col-sm-4" style="color: gray;">Inward File BRSTN: </label>
                                        <div class="col-sm-8"> <g:textField id="inwardBRSTN" name="inwardBRSTN" value="" class="form-control"/></div>
                                    </div>
                                    <div class="fieldcontain form-group ${hasErrors(bean: customerInstance, field: 'registrationDate', 'has-error')} ">
                                        <label class="control-label col-sm-4" style="color: gray;">Transaction pointer: </label>
                                        <div class="col-sm-8"><g:select id="txnTemplatePointer" name="txnTemplatePointer" from="${icbs.admin.TxnTemplate.findAllByTxnTypeAndMemoTxnType(icbs.lov.TxnType.read(7),icbs.lov.MemoTxnType.read(10),[sort:"code", order:"asc"])}" optionKey="id" optionValue ="description" value="1" class="form-control"/></div>
                                    </div>
                                    
                                </div>

                                <div class="modal-footer">
                                    <a href ="#" onclick="validatefields();" id="sender" name="sender" class="btn btn-primary">Submit</a>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                </div>
                                <g:javascript>
                                    function validatefields(){
                                        //description/inwardBRSTN/txnTemplatePointer
                                        var inwardDescription = $('#description').val();
                                        var inwardBRSTN = $('#inwardBRSTN').val();
                                        var inwardTxnTemplatePointer = $('#txnTemplatePointer').val();
                                        console.log("inwardDescription: "+inwardDescription);
                                        console.log("inwardBRSTN: "+inwardBRSTN);
                                        console.log("inwardTxnTemplatePointer: "+inwardTxnTemplatePointer);
                                        
                                        if(inwardDescription=="" || inwardDescription==null){
                                            notify.message('Sorr,Inward Clearing Pointer Description cannot be null!|error|alert'); 
                                            
                                        }else if(inwardBRSTN=="" || inwardBRSTN==null){
                                            notify.message('Sorry,Inward File BRSTN cannot be null!|error|alert'); 
                                        }else{
                                            alertify.confirm(AppTitle,"Are you sure you want to create this ?",
                                                function(){
                                                    document.getElementById("newInwardClearingPointerFormSend").submit();
                                                },
                                                function(){
                                                  alertify.error('Canceled!');
                                                });
                                        }
                                        
                                    }

                                </g:javascript>    
                            </div>

                        </div>
                    </g:form>
                </div>
                <!-- modal close -->                   
                <!-- //---------------------------------------END OF MODAL----------------------------------\\  -->
	    </ul>
	</content>
    </body>
</html>
