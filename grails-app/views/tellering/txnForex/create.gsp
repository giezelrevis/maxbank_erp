<%@ page contentType="text/html;charset=UTF-8" %>


<!DOCTYPE html>

<html>
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="layout" content="main">
        <title>Forex Transaction</title>

        <!-- Page specific CSS and JS -->
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'cashfromvault.css')}" type="text/css">
        <script type="text/javascript">
            var c;
        </script>
        <script type="text/javascript" src="${resource(dir: 'js', file: 'cashfromvault.js')}"></script>
        
        <g:javascript>
            function add_commas(number){
                number = '' + number;
                if (number.length > 3) {
                        var mod = number.length % 3;
                        var output = (mod > 0 ? (number.substring(0,mod)) : '');
                        for (i=0 ; i < Math.floor(number.length / 3); i++) {
                                if ((mod == 0) && (i == 0))
                                        output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
                                else
                                        output+= ',' + number.substring(mod + 3 * i, mod + 3 * i + 3);
                        }
                        return (output);
                }
                else return number;
            }
        </g:javascript>
    </head>
    
    <body>
        <content tag="main-content"><g:hasErrors bean="${txnForexInstance}">
                <div id= "addCustomerRelatedError" class="box-body">
                    <div class="alert alert-danger alert-dismissable">
                        <i class="fa fa-ban"></i>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <b>Alert!</b> 
                        <ul class="errors" role="alert">
                            <div id="errorList">
                            </div>
                            <g:eachError bean="${txnForexInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                            </g:eachError>
                        </ul>            
                    </div>
                </div>
            </g:hasErrors>
            
            <g:form name="txnForexForm" action="saveTellerForexTxn" controller="tellering" method="POST">
                <g:render template='txnForex/form' model="[txnForexInstance:txnForexInstance]"/>
            </g:form>
 
        </content>
        
        <content tag="main-actions">
            <ul>
                <li><a class="save" onclick="checkIfAllowed($('#txnType').val(), 'form#txnForexForm', 'Sample', $('#txnAmt').val());">${message(code: 'default.button.create.label', default: 'Create')}</a></li></li>
                <li><g:link action="index" onclick="return confirm('Are you sure you want to return to the Tellering Index page?');">Tellering Index</g:link></li>
            </ul>                                        
        </content>
    </body>
</html>