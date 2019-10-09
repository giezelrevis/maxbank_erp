$(function () {

    $('#txnType').change(function () {
        require_passbook = $(this).find('option:selected').attr('data-require-passbook');
        if (require_passbook == 'Yes') {
            $('#passbookBal').removeAttr('disabled');
        } else {
            $('#passbookBal').attr('disabled', 'disabled');
            $('#passbookBal').val('');
            $('#passbookValidate').addClass('hide');
        }
    });

    /*
    $('#passbookBal').blur(function () {

        acctNo = $('#depositDetDiv dl:eq(0) dd').text();
        passbookBal = parseFloat(($(this).val()).replace(',',''));
        $('#passbooksw').val(0);
     //   $("#creditAmt").attr("disabled", "disabled");

        $.post('/icbs/tellering/validatePassbookBal', {acctNo: acctNo, passbookBal: passbookBal}, function (data) {
            if (data == 'false') {
                $('#passbookValidate').removeClass('glyphicon-ok').addClass('glyphicon-remove').removeClass('hide');

            } else {
                $('#passbookValidate').removeClass('glyphicon-remove').addClass('glyphicon-ok').removeClass('hide');
                $('#passbooksw').val(1);
               // $('#creditAmt').removeAttr("disabled");

            }

        });
    });
    */
});