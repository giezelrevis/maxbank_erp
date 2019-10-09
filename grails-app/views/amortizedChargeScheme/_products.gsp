<%@ page import="icbs.lov.ProductType" %>
<%@ page import="icbs.lov.ConfigItemStatus" %>
<div class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="">Products</label>
    <div class="col-sm-8"><g:select id="products" name="products" from="${icbs.admin.Product.findAllByProductTypeAndConfigItemStatus(ProductType.get(6),ConfigItemStatus.get(2))}" optionKey="id" optionValue="name" value="${amortizedChargeSchemeInstance?.products?.id}" class="many-to-one form-control" multiple="" /></div>
</div>