$(function() {
    c = false;
    toCompute = $('.to-compute');
    
    $(toCompute).add('.txn-amt').change(function() {
      total = 0;
      ntotal = 0;
        
      $(toCompute).each(function() {
          denomination = $(this).attr('name');
          switch(denomination) {
            case 'bills1000':
                total += 1000 * $(this).val();
                ntotal = 1000 * $(this).val();
                $('#total1000').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'bills500':
                total += 500 * $(this).val();
                ntotal = 500 * $(this).val();
                $('#total500').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'bills200':
                total += 200 * $(this).val();
                ntotal = 200 * $(this).val();
                $('#total200').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'bills100':
                total += 100 * $(this).val();
                ntotal = 100 * $(this).val();
                $('#total100').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'bills50':
                total += 50 * $(this).val();
                ntotal = 50 * $(this).val();
                $('#total50').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'bills20':
                total += 20 * $(this).val();
                ntotal = 20 * $(this).val();
                $('#total20').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins10':
                total += 10 * $(this).val();
                ntotal = 10 * $(this).val();
                $('#total10').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins5':
                total += 5 * $(this).val();
                ntotal = 5 * $(this).val();
                $('#total5').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins1':
                total += 1 * $(this).val();
                ntotal = 1 * $(this).val();
                $('#total1').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins025':
                total += 0.25 * $(this).val();
                ntotal = 0.25 * $(this).val();
                $('#total025').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins010':
                total += 0.10 * $(this).val();
                ntotal = 0.10 * $(this).val();
                $('#total010').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins005':
                total += 0.05 * $(this).val();
                ntotal = 0.05 * $(this).val();
                $('#total005').val(addCommas(ntotal.toFixed(2)));
                break;
            case 'coins001':
                total += 0.01 * $(this).val();
                ntotal = 0.01 * $(this).val();
                $('#total001').val(addCommas(ntotal.toFixed(2)));
                break;   
        }          
      });
      
      //$('#total').val(addCommas(total.toFixed(2)));
      $('#total').val(addCommas(total.toFixed(2)));
      $('.total-match').removeClass('fa-times-circle');
      $('.total-match').removeClass('fa-check-circle');
      
      if($('.txn-amt').val() > 0)
      {
        console.log('txn-amt? '+$('.txn-amt').val());
        if($(".txn-amt").val() == total) {
            $('i').css("color", "green");
            $('.total-match').removeClass('dont-show');
            $('.total-match').addClass('fa-check-circle');
            $("input[type=submit]").removeAttr('disabled');
            $('#save').removeAttr('disabled');
            console.log('equal');
            c = true;
            return c;
        } else {
            $('i').css("color", "red");
            $('.total-match').addClass('dont-show');
            $('.total-match').addClass('fa-times-circle');
            $("input[type=submit]").attr('disabled', 'true');
            $('#save').attr('disabled', 'disabled');
            console.log('not equal');
            c = false;
            return c;
        }
      }
    });
}); 

function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}