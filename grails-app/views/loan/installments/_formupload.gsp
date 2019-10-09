
<script type="text/javascript">
    $('#installmentDate').datepicker({
        format: "mm/dd/yyyy",
        todayBtn: "linked",
        multidate: false,
        autoclose: true,
        todayHighlight: true
    });

    if ("${add}" == 'true') {        
        if ($('#numInstallments').val() == '' || $('#numInstallments').val() == '0') {
            $('#numInstallments').val('1');
        } else {
            var numInstallments = $('#numInstallments').val();
            numInstallments++;
            $('#numInstallments').val(numInstallments);
        }
    }
  
</script>

<div>
    <g:if test="${message}">
        <div class="box-body">
            <div class="alert alert-info alert-dismissable">
                <i class="fa fa-info"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Message</b> <div class="message" role="status">${message}</div>
            </div>
        </div>
    </g:if>
    <g:hasErrors bean="${installment}"> 
        <div class="box-body">
            <div class="alert alert-danger alert-dismissable">
                <i class="fa fa-ban"></i>
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <b>Alert!</b> 
                <ul class="errors" role="alert">
                    There are errors
                </ul>            
            </div>
        </div>
    </g:hasErrors>

    <div name="add-installment-form">
		<div  class="fieldcontain form-group ${hasErrors(bean: installment, field: 'installmentDate', 'has-error')}">
			
                         <div class="col-sm-8">
                        <g:uploadForm name="fileinfo">
                         <input  id="file2" class="btn btn-info-form-control" type="file" name="file" />
                        </g:uploadForm>
                        
			</div>
                        
		</div>
                
                <div class="fieldcontain form-group ${hasErrors(bean: installment, field: 'installmentDate', 'has-error')}">
			<h4>All fields in the csv file must be filled with correct values</h4>
                        <h4>Follow Column Arrangement : </h4><h5><span style="color:red;">Installment_date</span>, <span style="color:green;">Principal_amount</span>, <span style="color:red;">Interest_amount</span>, <span style="color:green;">Service_charge</span></h5>
                        <h5>System does not accept any<span style="color:red;"> NULL</span> values</h5>
                        <h5>Installment Date must be in<span style="color:red;"> MM/dd/YYYY</span> date format</h5>
                        <!--<h5>Columns<span style="color:red;"> Cannot be rearrange</span> please follow the <span style="color:green;">sample excel file</span> on the link below</h5> 
                        <strong >Download Sample CSV file: </strong><g:link  role="button" action="downloadSampleExcel">file.xls</g:link></br> -->

		</div>


    </div>
    
    
    
</div>


     
    </div>
</div>





