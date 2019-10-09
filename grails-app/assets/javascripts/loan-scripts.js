/*
 * Functions for dynamic list of inputs
 */

function addInput(url, index, target) {
	$.ajax({
	    type: 'POST',
	    data: {index:index},
	    url: url,
	    success: function(msg){			
	    	var item = $(msg);
	    	//var remove = $('<div class="remove-button form-group form-buttons"><button type="button" class="btn btn-danger multi-field-btn-delete" onclick="removeInput(this)"><span class="fa fa-minus"></span> Remove</button></div>');
	    	//$(item).append(remove.clone());

			// Append new input	group
			//$('.multi-input').last().after(item);
			$('#' + target).append(item);

			// Add a remove button for the first input if there are other inputs
			/*if ($('.multi-input').size() > 1 && $('.multi-input').first().find('button').length == 0)
			{  
				$(".multi-input").first().append(remove.clone());
			}*/						
	    },
	    error:function(XMLHttpRequest,textStatus,errorThrown){
    		alert(XMLHttpRequest+textStatus+errorThrown);
		}
	});
}

function removeInput(input) {	
	// Remove input
	$(input).parent().parent().remove();	
	//$(input).parent().parent().hide();
	//alert($(input).parent().parent().find('select').val());
	//$(input).parent().parent().find('select').val(0);
	//$(input).parent().parent().find('input').val('');	
	//alert($(input).parent().parent().find('select').val());

	// Remove the remove button on the first input if it is alone
	/*if ($(".multi-input").size() == 1) {
		$(".multi-input").first().find("button").remove();
	}*/
}