<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->
<%@ page import="icbs.lov.ProductType" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<div class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="">Products</label>
    <div class="col-sm-8"><g:select id="products" name="products" from="${icbs.admin.Product.findAllByProductTypeLessThanEqualsAndConfigItemStatus(ProductType.get(3),ConfigItemStatus.get(2))}" optionKey="id" optionValue="name" value="${depositInterestSchemeInstance?.products?.id}" class="many-to-one form-control" multiple="" /></div>
</div>