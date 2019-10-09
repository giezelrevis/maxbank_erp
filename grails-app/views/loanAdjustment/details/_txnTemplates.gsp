
<div>
    <div id="txn-template"><g:select id="txnTemplate" name="txnTemplate.id" from="${icbs.admin.TxnTemplate.findAllByMemoTxnType(txnType).sort{it.code}}" optionKey="id" optionValue="description" value="${loanLedgerInstance?.txnTemplate?.id ?: params?.txnTemplate}" class="many-to-one form-control"/></div>
</div>

