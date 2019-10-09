<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="form-group fieldcontain ${hasErrors(bean: customerInstance, field: 'type', 'has-error')} ">
	<label class="control-label col-sm-4" for="type">
            Customer Type
	</label>
	 <div class="col-sm-8">
            <g:select id="type" name="type.id" from="${icbs.lov.CustomerType.findAllByStatus(true)}" optionKey="id" optionValue ="description" value="${customerInstance?.type?.id}" class="form-control" />
            <g:hasErrors bean="${customerInstance}" field="type">
                <div class="controls">
                    <span class="help-block">
                        <g:eachError bean="${customerInstance}" field="type">
                            <g:message error="${it}" /><br/>
                        </g:eachError>
                    </span>
                </div>
             </g:hasErrors>    
         </div>
</div>