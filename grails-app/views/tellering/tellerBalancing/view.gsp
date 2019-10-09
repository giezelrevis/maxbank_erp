<%@ page contentType="text/html;charset=UTF-8" import="icbs.deposit.Deposit" %>


<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Teller Balancing</title>
        
        <!-- Page specific CSS and JS -->
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'cashfromvault.css')}" type="text/css">
        <script type="text/javascript" src="${resource(dir: 'js', file: 'cashfromvault.js')}"></script>
    </head>
    <body>
        <content tag="main-content">
            <g:if test="${flash.message}">
                <div class="box-body">
                    <div class="alert alert-info alert-dismissable">
                        <i class="fa fa-info"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Message</b> <div class="message" role="status">${flash.message}</div>
                    </div>
                </div>
            </g:if>
            
            <div class="fieldcontain form-group ${hasErrors(bean: tellerBalancingInstance, field: 'txnAmt', 'has-error')} ">
    <label class="control-label col-sm-4" for="txnAmt">
        <g:message code="tellerBalancing.txnAmt.label" default="Ending Cash" />
    </label>

    <div class="col-sm-6">
        <g:field name="txnAmt" value="${fieldValue(bean: tellerBalancingInstance, field: 'txnAmt')}" class="txn-amt form-control"/>
    </div>             
</div>

<div class="container-fluid">
    <fieldset class="col-xs-9">
        <div class="infowrap">
            
        </div><table class="table table-bordered table-striped">
                <legend class="section-header"><h4>Breakdown</h4> </legend>
                <tr>
                    <td>
                        <strong>1000-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills1000" value="${tellerBalancingInstance?.bills1000}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total1000" id="total1000" value="${tellerBalancingInstance?.total1000}" placeholder="0" class="form-control"/>
                    </td>                  
                </tr>
                <tr>
                    <td>
                        <strong>500-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills500" value="${tellerBalancingInstance?.bills500}" class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total500" id="total500" value="${tellerBalancingInstance?.total500}" placeholder="0" class="form-control"/>
                    </td>                   
                </tr>
                <tr>
                    <td>
                        <strong>200-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills200" value="${tellerBalancingInstance?.bills200}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total200" id="total200" value="${tellerBalancingInstance?.total200}" placeholder="0" class="form-control"/>
                    </td>                   
                </tr>
                <tr>
                    <td>
                        <strong>100-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills100" value="${tellerBalancingInstance?.bills100}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total100" id="total100" value="${tellerBalancingInstance?.total100}" placeholder="0" class="form-control"/>
                    </td>                   
                </tr>
                <tr>
                    <td>
                        <strong>50-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills50" value="${tellerBalancingInstance?.bills50}"class="form-control to-compute"/>
                    </td>    
                    <td>
                        <g:textField type="number" disabled="true" name="total50" id="total50" value="${tellerBalancingInstance?.total50}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>20-Peso Bills</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="bills20" value="${tellerBalancingInstance?.bills20}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" disabled="true" name="total20" id="total20" value="${tellerBalancingInstance?.total20}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>10-Peso Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins10" value="${tellerBalancingInstance?.coins10}"class="form-control to-compute"/>
                    </td> 
                    <td>
                        <g:textField type="number" disabled="true" name="total10" id="total10" value="${tellerBalancingInstance?.total10}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>5-Peso Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins5" value="${tellerBalancingInstance?.coins5}"class="form-control to-compute"/>
                    </td> 
                    <td>
                        <g:textField type="number" disabled="true" name="total5" id="total5" value="${tellerBalancingInstance?.total5}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>1-Peso Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins1" value="${tellerBalancingInstance?.coins1}"class="form-control to-compute"/>
                    </td>  
                    <td>
                        <g:textField type="number" disabled="true" name="total1" id="total1" value="${tellerBalancingInstance?.total1}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>25-Centavo Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins025" value="${tellerBalancingInstance?.coins025}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total025" id="total025" value="${tellerBalancingInstance?.total025}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>10-Centavo Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins010" value="${tellerBalancingInstance?.coins010}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total010" id="total010" value="${tellerBalancingInstance?.total010}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>5-Centavo Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins005" value="${tellerBalancingInstance?.coins005}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total005" id="total005" value="${tellerBalancingInstance?.total005}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <strong>1-Centavo Coins</strong>
                    </td>
                    <td>
                        <g:textField type="number" name="coins001" value="${tellerBalancingInstance?.coins001}"class="form-control to-compute"/>
                    </td>
                    <td>
                        <g:textField type="number" disabled="true" name="total001" id="total001" value="${tellerBalancingInstance?.total001}" placeholder="0" class="form-control"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        <g:textField disabled="true" name="total" id="total" value="0" class="form-control total"/>
                        <i style="color:green" class="fa fa-check-circle fa-2x fa-align-center total-match dont-show"></i>
                    </td>
                </tr>
            </table>
    </fieldset>
</div>
            
        </content>
        
        <content tag="main-actions">
            <ul>
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to tellering index Page?');">Return to Tellering Index Page</g:link></li>
                <li><g:link action="comfirmTellerBalance" onclick="return confirm('Confirm Balance?');">Confirm Balance</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>
