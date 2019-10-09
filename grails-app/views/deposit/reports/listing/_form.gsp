<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<g:form>
    <div class="row">
        <div class="col-md-4">
            <fieldset>
                <legend>Module</legend>
                <div class="row">
                    <div class="checkbox">
                        <label>
                          <input name="type"type="checkbox" value="0">
                          Savings Account
                        </label>
                   </div>
                   <div class="checkbox">
                        <label>
                          <input name="type" type="checkbox" value="1">
                         Current Account
                        </label>
                   </div>
                   <div class="checkbox">
                        <label>
                          <input name="type" type="checkbox" value="2">
                          Fixed Deposit Account
                        </label>
                   </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>Sorting Order</legend>
                <div class="radio">
                    <label>
                        <input type="radio" name="sorting" id="sorting" value="0">
                        By Account No
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" name="sorting" id="sorting" value="1">
                        By Status
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" name="sorting" id="sorting" value="2">
                        By Customer Name
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" name="sorting" id="sorting" value="3">
                        By Open Date
                    </label>
                </div>
            </fieldset>
        </div>
        
        <div class="col-md-8">
            <fieldset>
                <legend>Module</legend>
                 <div class="row">
                    <div class="checkbox">
                        <label>
                          <input name="range"type="checkbox" value="0">
                          Open Date
                        </label>
                   </div>
                   <div class="checkbox">
                        <label>
                          <input name="range" type="checkbox" value="1">
                         Interest Rate
                        </label>
                   </div>
                   <div class="checkbox">
                        <label>
                          <input name="range" type="checkbox" value="3">
                          Balance Amount
                        </label>
                   </div>
                    <div class="checkbox">
                        <label>
                          <input name="range" type="checkbox" value="3">
                          Status Date
                        </label>
                   </div>
                </div>
            </fieldset>
        </div>
    </div>
</g:form>