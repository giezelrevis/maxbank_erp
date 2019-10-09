<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<div  name="inlineSearchDiv"id="inlineSearchDiv">
<g:javascript>
    var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
</g:javascript>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="section-container">
    <fieldset><legend class="section-header">Passbooks</legend>
     <g:form id="searchForm" name="searchForm">
        <!--Custom Action  -->
        <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
        <g:hiddenField id="searchDomain" name="searchDomain" value="deposit-passbook"/>
        <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>
        <div class="row">
            <div class="col-md-12">
                <div class=" col-md-2">
                     <g:select name="max" value="${params.max}" from="[10, 20, 30, 40]" class="form-control input-sm "onchange="searchVar.searchMe();" />
                </div>
                <div class="input-group col-md-10">
                    <input id="searchQuery"name="searchQuery"type="text" class="form-control" value="${params?.searchQuery}"onchange="searchVar.searchMe();">
                    <span class="input-group-btn">
                      <a href="#" class="btn btn-primary" id="searchbtn" onclick="searchVar.searchMe();">Search</a>
                    </span>
                </div><!-- /input-group -->
            </div><!-- /.col-lg-6 -->
        </div>
    </g:form>
    <div id="grid">
            <div class="box-body table-responsive no-padding">
                            <table class="table table-hover table-condensed table-bordered table-striped">
                                <tr> 
                                    <td width="15%"><label>Passbook No.</label></td>
                                    <td width="10%"><label>Issued Date</label></td>
                                    <td width="15%"><label>Issued By</label></td>
                                    <td width="15%"><label>Remarks</label></td>
                                    <td width="10%"><label>Status</label></td>
                                    <td><label>Action</label></td>
                                </tr>
                                <g:each in="${domainInstanceList}" status="i" var="domainInstance">
                                        <tr>
                                             <g:hiddenField name="id" value="${domainInstance?.id}" disabled="disabled" />
                                             <g:hiddenField name="deposit_id" id="deposit_id" value="${domainInstance?.deposit?.id}" />
                                             <td>${domainInstance?.passbook?.passbookNo}</td>
                                             <td>${domainInstance?.dateIssued?.format("MM/dd/yyyy")}</td>
                                             <td>${domainInstance?.issuedBy?.username}</td>
                                             <td>${domainInstance?.remarks}</td>
                                             <td>${domainInstance?.passbook?.status}</td>
                                             <td>   
                                                
                                                <g:form controller="deposit" action="printPassbookCover" target="_blank">
                                                    <%-- input type="button" class="btn btn-secondary" value="Edit" onclick="editPassbook(${domainInstance?.id})"/ --%> 
                                                    <input onclick='changeStatus("${domainInstance?.passbook?.passbookNo}","${domainInstance?.id}")' type="button" class="btn btn-xs btn-primary" value="Change">
                                                    <g:hiddenField name="passbookNo" value="${domainInstance?.passbook?.passbookNo}" />
                                                    <input type="button" class="btn btn-xs btn-secondary" name="Cover" value="Cover" onclick="submit_me.click();">
                                                    <input type="submit" style="display:none" value="Cover" id="submit_me">
                                                </g:form>     
                                             </td>
                                        </tr>
                               </g:each>     
                            </table>
                            <script>
                                
                                   function updateStatus(x,y)
                                   {
                                    var xhttp = new XMLHttpRequest();
                                    xhttp.onreadystatechange = function() {
                                      if (xhttp.readyState == 4 && xhttp.status == 200) {
                                        //document.getElementById("demo").innerHTML = xhttp.responseText;
                                        console.log('?err '+xhttp.responseText);
                                      }
                                    };
                                    xhttp.open("POST", "/icbs/deposit/ups?txn="+x+"&txnid="+y, true);
                                    xhttp.send();
                                    searchbtn.click();
                                    //location.reload();
                                    
                                   }
                                   function changeStatus(x,y)
                                   {
                                        httpRequest = new XMLHttpRequest();
                                        console.log('Y  -  '+y);

                                        if (!httpRequest) {
                                          alert('Giving up :( Cannot create an XMLHTTP instance');
                                          return false;
                                        }

                                        httpRequest.onreadystatechange = function(){
                                            if (httpRequest.readyState === XMLHttpRequest.DONE) {
                                                if (httpRequest.status === 200) 
                                                {
                                                    //console.log(httpRequest.responseText);
                                                    var msg = '<label>Change Passbook Status</label><select id="alrt" class="form-control">';
                                                    msg +='<option selected disabled >--select status--';
                                                    $.each(JSON.parse(httpRequest.responseText),function(id,val){
                                                        msg +='<option value='+val.id+'>'+val.description;
                                                    });
                                                     msg +='</select>';
                                                    alertify.confirm(AppTitle,msg,function(evt,value){ updateStatus(alrt.value,y); },function(){});
                                                }
                                            } else {
                                                alert('There was a problem with the request.');
                                            }
                                        };
                                        httpRequest.open('POST', '/icbs/deposit/pslist');
                                        httpRequest.send()
                                            
                                        
                                   }
                            </script>
                <div class="pagination">
                        <g:paginate total="${domainInstanceCount ?: 0}"/>
                </div>
            </div>
    </div>
    </fieldset>
</div>
</div>