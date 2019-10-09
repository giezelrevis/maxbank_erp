<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
 <script type="text/javascript" src="${resource(dir: 'js', file: 'cashfromvault_php.js')}"></script>

<table class="table table-bordered table-striped">
                <legend class="section-header"><h4>Breakdown</h4> </legend>
                <tr>
                    <td>
                        <strong>1000-Peso Bills</strong>
                    </td>
                    <td>
                        <g:field min='0' type="number" name="bills1000" value="${txnCashFromVaultInstance?.bills1000}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total1000" id="total1000" value="${txnCashFromVaultInstance?.total1000}" placeholder="0" class="form-control"/>
                    </td>                  
                </tr>
                <tr>
                    <td>
                        <strong>500-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills500" value="${txnCashFromVaultInstance?.bills500}" class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total500" id="total500" value="${txnCashFromVaultInstance?.total500}" placeholder="0" class="form-control"/>
                    </td>                   
                </tr>
                <tr>
                    <td>
                        <strong>200-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills200" value="${txnCashFromVaultInstance?.bills200}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" readonly="true" name="total200" id="total200" value="${txnCashFromVaultInstance?.total200}" placeholder="0" class="form-control"/>
                    </td>                   
                </tr>
                <tr>
                    <td>
                        <strong>100-Peso Bills</strong>
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
                        <strong>50-Peso Bills</strong>
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
                        <strong>20-Peso Bills</strong>
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
                        <strong>10-Peso Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins10" value="${txnCashFromVaultInstance?.coins10}"class="form-control to-compute"/>
                    </td> 
                    <td>
                        <g:textField type="number" readonly="true" name="total10" id="total10" value="${txnCashFromVaultInstance?.total10}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>5-Peso Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins5" value="${txnCashFromVaultInstance?.coins5}"class="form-control to-compute"/>
                    </td> 
                    <td>
                        <g:textField type="number" readonly="true" name="total5" id="total5" value="${txnCashFromVaultInstance?.total5}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>1-Peso Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins1" value="${txnCashFromVaultInstance?.coins1}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" readonly="true" name="total1" id="total1" value="${txnCashFromVaultInstance?.total1}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>25-Centavo Coins</strong>
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
                        <strong>10-Centavo Coins</strong>
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
                        <strong>5-Centavo Coins</strong>
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
                        <strong>1-Centavo Coins</strong>
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
