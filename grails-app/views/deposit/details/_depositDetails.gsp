<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
    <div class="section-container">
        <g:hiddenField id="depositFromSearch" name="depositFromSearch" value="${depositInstance?.id}"/>
        <fieldset>
        <legend class="section-header">${boxName?boxName:"Deposit Account Information"}</legend>
            <table class="table table-bordered table-striped">
                <tbody>
                    <tr>
                        <td style="font-weight:bold" width="30%">Account Number</td>
                        <td width="70%">${depositInstance?.acctNo}</td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Account Name</td>
                        <td width="70%">${depositInstance?.acctName}</td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Branch</td>
                        <td width="70%">${depositInstance?.branch?.name}</td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Deposit Product</td>
                        <td width="70%">${depositInstance?.product?.name}</td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Date Opened</td>
                        <td width="70%"><g:formatDate format="MM/dd/yyyy" date="${depositInstance?.dateOpened}"/></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Interest Rate</td>
                        <td width="70%"><g:formatNumber format="#,##0.00" number="${depositInstance?.interestRate}"/> %</td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold" width="30%">Status</td>
                        <td width="70%" id="dpstatus">${depositInstance?.status?.description}</td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
    </div>