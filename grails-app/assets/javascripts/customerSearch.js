$(function() {
    
    $('#findCustomer').click(function() {
    id = $('#senderCID').val();
    $.get("/icbs-project/Search/search", 
        {searchType: '1', searchQuery: id}, 
        function(data) { 
            if(data != 'Not found') {
                $('#searchError').addClass('hide')
                $('#senderDetails').removeClass('hide')
                $('#senderName').text([data.name1,data.name2,data.name3,data.name4].join(" "))
                $('#senderDOB').text(data.birthDate)
                $('#senderAddress').text(data.addresses.join(", "))
                $('#senderContactNo').text(data.contacts.join(", "))
            } else {
                $('#senderDetails').addClass('hide')
                $('#searchError').removeClass('hide')
                $('#searchError').text('Customer ID not found.')
            }
        });
    });
    
    $('#findBeneficiary').click(function() {
    id = $('#beneficiaryCID').val();
    $.get("/icbs-project/Search/search", 
        {searchType: '1', searchQuery: id}, 
        function(data) { 
            if(data != 'Not found') {
                $('#searchError2').addClass('hide')
                $('#beneficiaryDetails').removeClass('hide')
                $('#beneficiaryName').text([data.name1,data.name2,data.name3,data.name4].join(" "))
                $('#beneficiaryDOB').text(data.birthDate)
                $('#beneficiaryAddress').text(data.addresses.join(", "))
                $('#beneficiaryContactNo').text(data.contacts.join(", "))
            } else {
                $('#beneficiaryDetails').addClass('hide')
                $('#searchError2').removeClass('hide')
                $('#searchError2').text('Beneficiary not found.')
            }
        });
    });
});