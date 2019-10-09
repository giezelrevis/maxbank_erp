$(document).ready(function(){

    //Clones the row inside the info1 class and transforms it to plain html
    var clonedRow = $('.info1').clone().html();

    //Wraps clonedRow with tr tags since cloning ignores those
    var appendRow = '<tr class = "info1">' + clonedRow + '</tr>'; 

    $('#btnAddMore').click(function(){
        //Gets the last row and appends appendRow when correct row is found
        $('.check-table tr:last').after(appendRow);
        });

    //Deletes a row
    $('.deleteThisRow').live('click',function(){
        var rowLength = $('.info1').length;

        if(rowLength > 1){
            deleteRow(this);
        }else{
            $('.check-table tr:last').after(appendRow);
            deleteRow(this);
        }
    });

    function deleteRow(currentNode){
        $(currentNode).parent().parent().remove();
        }
    });