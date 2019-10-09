$(function() {
    $('#findAcct').click(function() {
    id = $('#acctNo').val();
    $.get("/icbs-project/Search/search", 
        {searchType: '2', searchQuery: id}, 
        function(data) { 
            if(data != 'Not found') {
                $('#searchError').addClass('hide')
                $('#acctDetails').removeClass('hide')
                $('#acctID').text(data.customer.customerId)
                $('#acctName').text([data.customer.name1,data.customer.name2,data.customer.name3,data.customer.name4].join(" "))
                $('#acctStatus').text(data.status)
                $('#dateOpened').text(data.openingDate)
                $('#maturityDate').text(data.maturityDate)
                //$('#senderDOB').text(data.birthDate)
                // $('#senderAddress').text(data.addresses.join(", "))
                // $('#senderContactNo').text(data.contacts.join(", "))
            } else {
                $('#acctDetails').addClass('hide')
                $('#searchError').removeClass('hide')
                $('#searchError').text('Account Number not found.')
            }
        });
    });
});