<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" %>
<div  name="inlineSearchDiv" id="inlineSearchDiv">
    <g:javascript>
        var searchVar = new icbs.Utilities.Search("${createLink(controller : 'search', action:'search')}");
    </g:javascript>
        <div class="section-container">
            <fieldset><legend class="section-header">Transactions</legend>
                <g:form id="searchForm" name="searchForm">
                <!--Custom Action  -->
                <g:hiddenField id="id" name="id" value="${params?.id ?:depositInstance?.id}"/>
                <g:hiddenField id="type" name="type" value="${params?.type ?:depositInstance?.type?.id}"/>
                <g:hiddenField id="searchDomain" name="searchDomain" value="depositreprint"/>
                <g:hiddenField id="actionTemplate" name="actionTemplate" value="${params.actionTemplate}"/>

                
                    <div class="row">
                        <div class="col-md-12">
                            <div class=" col-md-5">
                                    <label>&nbsp;Txn Date:</label>
                                <input type="date" name="txndate" id="txndate" class="form-control"/>
                            </div>

                                <input style="display:none" id="searchQuery" name="searchQuery" type="text" class="form-control" value="${params?.searchQuery}" onchange="searchVar.searchMe();"> 
                                    <label>&nbsp;</label>     
                            <span class="input-group-btn" >
                                <a href="#" class="btn btn-primary" onclick="searchVar.searchMe();">Search</a>
                            </span>         
                        </div>
                    </div>
            </g:form>
        </div>
        <script>
            $(document).ready(function() {
                   $('#tblreprintGrid').DataTable();
                   
               } );
                
             $(function() {
                  $( "#startdate" ).datepicker();
                  console.log("pasok sa startdae date picker");
                  });

             $(function() {
               $( "#enddate" ).datepicker();
               console.log("pasok sa enddate date picker");
             });
               
               $(function() {
                var type = document.getElementById('type').value;              
                        if(type == 3){
                            $( "#gridFD" ).show();
                        }
                        
                        else{
                            $( "#grid" ).show();
                        }
                  });
               
            
        </script>
        <g:if test="${params.type == '3'}">
            <div id="gridFD">
                <table class="table table-hover table-condensed table-bordered table-striped" id="tblreprintGrid">
                <thead>        
                    <tr> 
                        <th>ID</th>
                        <th>Txn Date</th>
                        <th>Txn Type</th>                        
                        <th>DR Amt</th>
                        <th>CR Amt</th>
                        <th>Bal</th>
                        <th>Currency</th>
                        <th>Txn Seq Start</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${domainInstanceList}" status="i" var="Fd">   
                        <tr>
                            <td>${Fd?.id}</td>
                            <td>${Fd?.txnDate?.format("MM/dd/yyyy")}</td>
                            <td>${Fd?.txnType}</td>                            
                            <td><g:formatNumber format="###,###,##0.00" number="${Fd.debitAmt}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${Fd.creditAmt}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${Fd.bal}"/></td>
                            <td>${Fd?.currency?.code}</td>
                            <td><g:link action="reprintPassbookShow" controller="tellering" id="${Fd?.id}">${fieldValue(bean: Fd, field: "passbookLine").padLeft(3, '0')}</g:link></td>
                        </tr>
                    </g:each>  
                </tbody>
            </table>
        </div>  
        </g:if>
        <g:else>
        <div id="grid">
            <table class="table table-hover table-condensed table-bordered table-striped" id="tblreprintGrid">
                <thead>        
                    <tr> 
                        <th>ID</th>
                        <th>Txn Date</th>
                        <th>Txn Type</th>
                        <g:if test="${params.type == '2'}">
                        <th>Chq No.</th> 
                        </g:if>
                        <th>DR Amt</th>
                        <th>CR Amt</th>
                        <th>Bal</th>
                        <th>Currency</th>
                        <th>Txn Seq Start</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${domainInstanceList}" status="i" var="domainInstance">   
                        <tr>
                            <td>${domainInstance?.id}</td>
                            <td>${domainInstance?.txnDate?.format("MM/dd/yyyy")}</td>
                            <td>${domainInstance?.txnType}</td>
                            <g:if test="${params.type == '2'}"> 
                                <g:if test="${domainInstance?.txnFile?.txnTemplate?.id == 12 || domainInstance?.txnFile?.txnTemplate?.id == 13 || domainInstance?.txnFile?.txnTemplate?.id == 17 || domainInstance?.txnFile?.txnTemplate?.id == 19}">
                                    <td>${domainInstance?.txnRef}</td>
                                </g:if>
                               <g:else>
                                    <td> </td>
                                </g:else>     
                            </g:if>
                            <td><g:formatNumber format="###,###,##0.00" number="${domainInstance?.debitAmt}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${domainInstance?.creditAmt}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${domainInstance?.bal}"/></td>  
                            <td>${domainInstance?.currency?.code}</td>
                            <td><g:link action="reprintPassbookShow" controller="tellering" id="${domainInstance.id}">${fieldValue(bean: domainInstance, field: "passbookLine").padLeft(3, '0')}</g:link></td>
                        </tr>
                    </g:each>  
                </tbody>
            </table>
        </div>
        </g:else>
</div>
