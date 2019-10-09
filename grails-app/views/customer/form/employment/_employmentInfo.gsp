<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<legend>Employment Information</legend>
<g:render template='form/employment/onetomany/employment' model="['employment':customerInstance?.employments[0],'i':0]"/>
