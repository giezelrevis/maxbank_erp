<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<legend>Business Information</legend>
<g:render template='form/business/onetomany/business' model="['business':customerInstance?.businesses[0],'i':0]"/>
    
        