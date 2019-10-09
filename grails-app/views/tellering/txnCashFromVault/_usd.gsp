<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
 <script type="text/javascript" src="${resource(dir: 'js', file: 'cashfromvault_usd.js')}"></script>

<table class="table table-bordered table-striped">
                <legend class="section-header"><h4>Breakdown</h4> </legend>
                
                <tr>
                    <td>
                        <strong>100-Dollars</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills100" value="${txnCashFromVaultInstance?.bills100}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total100" id="total100" value="${txnCashFromVaultInstance?.total100}" placeholder="0" class="form-control"/>
                    </td>                   
                </tr>
                <tr>
                    <td>
                        <strong>50-Dollars</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills50" value="${txnCashFromVaultInstance?.bills50}"class="form-control to-compute"/>
                    </td>    
                    <td>
                        <g:textField type="number" readonly="true" name="total50" id="total50" value="${txnCashFromVaultInstance?.total50}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>20-Dollars</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills20" value="${txnCashFromVaultInstance?.bills20}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" readonly="true" name="total20" id="total20" value="${txnCashFromVaultInstance?.total20}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
               
                <tr>
                    <td>
                        <strong>10-Dollars</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills10" value="${txnCashFromVaultInstance?.bills10}"class="form-control to-compute"/>
                    </td> 
                    <td>
                        <g:textField type="number" readonly="true" name="total10" id="total10" value="${txnCashFromVaultInstance?.total10}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>5-Dollars</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills5" value="${txnCashFromVaultInstance?.bills5}"class="form-control to-compute"/>
                    </td> 
                    <td>
                        <g:textField type="number" readonly="true" name="total5" id="total5" value="${txnCashFromVaultInstance?.total5}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>2-Dollars</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills2" value="${txnCashFromVaultInstance?.bills2}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" readonly="true" name="total2" id="total2" value="${txnCashFromVaultInstance?.total2}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>1-Dollar</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills1" value="${txnCashFromVaultInstance?.bills1}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" readonly="true" name="total1" id="total1" value="${txnCashFromVaultInstance?.total1}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>1-Dollar (silver/gold)</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins100" value="${txnCashFromVaultInstance?.coins100}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" readonly="true" name="total0100" id="total0100" value="${txnCashFromVaultInstance?.total0100}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>50-cents (half dollar)</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins050" value="${txnCashFromVaultInstance?.coins050}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total050" id="total050" value="${txnCashFromVaultInstance?.total050}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>25-cents (quarter)</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins025" value="${txnCashFromVaultInstance?.coins025}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total025" id="total025" value="${txnCashFromVaultInstance?.total025}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>10-cents (dime)</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins010" value="${txnCashFromVaultInstance?.coins010}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total010" id="total010" value="${txnCashFromVaultInstance?.total010}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>5-cents  (nickel)</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins005" value="${txnCashFromVaultInstance?.coins005}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total005" id="total005" value="${txnCashFromVaultInstance?.total005}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>1-cent (penny)</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins001" value="${txnCashFromVaultInstance?.coins001}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total001" id="total001" value="${txnCashFromVaultInstance?.total001}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        <g:textField disabled="true"  name="total" id="total" value="0" class="form-control total"/>
                        
                    </td>
                </tr>
            </table>
