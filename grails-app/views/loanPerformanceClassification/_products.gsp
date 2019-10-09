<%@ page import="icbs.lov.ProductType" %>

<div class="fieldcontain form-group">
    <label class="control-label col-sm-4" for="">Products</label>
    <div class="col-sm-8"><g:select id="products" name="products" from="${icbs.admin.Product.findAllWhere(productType:ProductType.get(6))}" optionKey="id" optionValue="name" value="${loanPerformanceClassificationInstance?.products?.id}" class="many-to-one form-control" multiple="" /></div>
</div>