<%@ page import="icbs.loans.CreditInvestigation" %>


<legend>Checklist</legend>
<div >
    <table border=0 class="table table-hover table-condensed table-bordered table-striped">
     <tr style="background-color: #00ace6;color: white;font-weight: bold;">
            <td colspan=2>
                    <label ><h4><strong>TO SUPPORT CLIENT INFORMATION</h4></strong></label>
        </td>
     </tr>
     <tr>
            <td >
                    <div>
                            <g:checkBox disabled="${disabled}" id="formA1" name="formA1" value="${creditInvestigationInstance?.formA1}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA1">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA1">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td>1. Duly Accomplished Application Form </td>
     </tr>		

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA2" name="formA2" value="${creditInvestigationInstance?.formA2}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA2">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA2">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td> 
            <td> 2. Duly Accomplished Co-Maker Statement </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA3" name="formA3" value="${creditInvestigationInstance?.formA3}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA3">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA3">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 3. 2pcs 2X2 Picture </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA4" name="formA4" value="${creditInvestigationInstance?.formA4}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA4">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA4">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 4. Valid IDs of Applicant/s, co-maker/s and mortgator/s </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA5" name="formA5" value="${creditInvestigationInstance?.formA5}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA5">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA5">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 5. Signed Authorization Letter(Bank Checking/Court Checking) </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA6" name="formA6" value="${creditInvestigationInstance?.formA6}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA6">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA6">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 6. Copy of Official Receipt (Inspection and Appraisal FEE) </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA7" name="formA7" value="${creditInvestigationInstance?.formA7}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA7">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA7">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 7. Signed Waiver of Confidentiality of Client Information </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA8" name="formA8" value="${creditInvestigationInstance?.formA8}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA8">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA8">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 8. Signed Waiver of Secrecy of Bank Deposit Under RA No. 1405 </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA9" name="formA9" value="${creditInvestigationInstance?.formA9}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA9">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA9">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 9. Photocopy of Passbook/s or Bank Statements of deposit with other Bank/s </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA10" name="formA10" value="${creditInvestigationInstance?.formA10}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA10">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA10">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 10. Report on Customer as of the date of application (if existing client) </td>
     </tr>

     <tr>
            <td>
                    <div>
                            <g:checkBox id="formA11" name="formA11" value="${creditInvestigationInstance?.formA11}"/>
                            <g:hasErrors bean="${creditInvestigationInstance}" field="formA11">
                                    <div >
                                            <span >
                                                    <g:eachError bean="${creditInvestigationInstance}" field="formA11">
                                                            <g:message error="${it}" /><br/>
                                                    </g:eachError>       
                                            </span>
                                    </div>	
                            </g:hasErrors>
                    </div>
            </td>
            <td> 11. Latest proof of income & project for financing(reffer below specific document) </td>
     </tr>
    </table>

    <table class="table table-hover table-condensed table-bordered table-striped">
            <tr style="background-color: #00ace6;color: white;font-weight: bold;">
                    <td colspan=3>
                            <label><h4><strong>ON COLLATERAL</h4></strong></label>
                    </td>
            </tr>
            <tr style="background-color: #0086b3;">
                    <td ></td>
                    <td colspan=2 style="color: white;font-weight: bold;">
                        <label><h5><strong>A. REAL ESTATE</strong></h5></label>
                    </td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB1" name="formB1" value="${creditInvestigationInstance?.formB1}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB1">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB1">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>1. Photocopy of title offered collateral/s</td>
            </tr>		
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB2" name="formB2" value="${creditInvestigationInstance?.formB2}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB2">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB2">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>2. Current tax declaration (of land and improvement/s(if applicable)</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB3" name="formB3" value="${creditInvestigationInstance?.formB3}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB3">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB3">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>3. Latest tax clearance/s</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB4" name="formB4" value="${creditInvestigationInstance?.formB4}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB4">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB4">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>4. Latest tax receipt/s</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB5" name="formB5" value="${creditInvestigationInstance?.formB5}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB5">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB5">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>5. Approved Subdivision/Lot Plan</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB6" name="formB6" value="${creditInvestigationInstance?.formB6}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB6">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB6">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>6. Affidavit of Non-tenancy</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB7" name="formB7" value="${creditInvestigationInstance?.formB7}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB7">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB7">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>7. Special Power of Attorney notarized by nearest Philippine Consulate</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB8" name="formB8" value="${creditInvestigationInstance?.formB8}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB8">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB8">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>8. Deed of sale</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB9" name="formB9" value="${creditInvestigationInstance?.formB9}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB9">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB9">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>9. Approval of mortgage</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB10" name="formB10" value="${creditInvestigationInstance?.formB10}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB10">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB10">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>10. Permit to Mortgage</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB11" name="formB11" value="${creditInvestigationInstance?.formB11}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB11">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB11">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>11. Certificate of Full payment from DAR/Landbank</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB12" name="formB12" value="${creditInvestigationInstance?.formB12}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB12">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB12">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>12. Extra-judicial settlement</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB13" name="formB13" value="${creditInvestigationInstance?.formB13}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB13">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB13">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>13. Conformity of occupants/owner of improvements</td>
            </tr>	
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB14" name="formB14" value="${creditInvestigationInstance?.formB14}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB14">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB14">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td>14. Master Deed in case if condominium unit/s</td>
            </tr>

            <tr style="background-color: #0086b3;">
                    <td></td>
                   <td colspan=2 style="color: white;font-weight: bold;">
                            <label><h5><strong>B. CHATTEL/MOVABLE PROPERTIES</strong></h5></label>
                    </td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB15" name="formB15" value="${creditInvestigationInstance?.formB15}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB15">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB15">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td> 1. Copy of latest OR and Certificate of Registration</td>
            </tr>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB16" name="formB16" value="${creditInvestigationInstance?.formB16}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB16">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB16">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td> 2. LTO Verification</td>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB17" name="formB17" value="${creditInvestigationInstance?.formB17}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB17">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB17">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td> 3. Comprehensive and TPL Insurance</td>
            <tr>
                    <td>
                    </td>
                    <td >
                            <div>
                                    <g:checkBox id="formB18" name="formB18" value="${creditInvestigationInstance?.formB18}"/>
                                    <g:hasErrors bean="${creditInvestigationInstance}" field="formB18">
                                            <div >
                                                    <span >
                                                            <g:eachError bean="${creditInvestigationInstance}" field="formB18">
                                                                    <g:message error="${it}" /><br/>
                                                            </g:eachError>       
                                                    </span>
                                            </div>	
                                    </g:hasErrors>
                            </div>
                    </td>
                    <td> 4. Stencils</td>

    </table>	
</div>
