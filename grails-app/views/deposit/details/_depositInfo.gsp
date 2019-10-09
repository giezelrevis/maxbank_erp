<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class ="row">
    <div class="col-md-12">
        <address>
            <strong>Principal Owner Name</strong><br>
            ${depositInstance?.customer?.displayName}<br>
            <strong>Account No</strong><br>
            ${depositInstance?.acctNo}<br>
            <strong>Account Name</strong><br>
            ${depositInstance?.acctName}<br>
        </address>
    </div>
</div>