<%@ page import="icbs.loans.LoanApplication" %>


    <g:set var="loanService" bean="loanService"/>
    
    <div class="table-responsive">
        <table class="table table-hover table-condensed table-bordered table-striped">
            <thead>
                <tr>
                    <td><label>No.</label></td>
                    <td><label>Installment Date</label></td>
                    <td><label>Principal</label></td>
                    <td><label>Interest</label></td>
                    <td><label>Total Due</label></td>
                    <td><label>Balance</label></td>
                </tr>
            </thead>
            <tbody>
            <g:set var="totalPrincipal" value="${0}" />
            <g:set var="totalInterest" value="${0}" />
            <g:set var="totalDue" value="${0}" />

            %{-- single payment --}%
            <g:if test="${interestIncomeScheme.installmentCalcType.id == 1 && interestIncomeScheme.advInterestType.id == 1}">
                <tr>
                   
                    <g:set var="dueDate" value="${firstInstallmentDate ?: openingDate + term}" />
                    <g:set var="term" value="${dueDate - (interestStartDate ?: openingDate)}" />
                    <g:set var="interest" value="${(amount * interestRate * term) / divisor}" />
                    <g:set var="due" value="${amount + interest}" />
                    <td>1</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${amount}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interest}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td>0.00</td>
                    <g:set var="totalPrincipal" value="${amount}" />
                    <g:set var="totalInterest" value="${interest}" />
                    <g:set var="totalDue" value="${due}" />
                </tr>                
            </g:if>
            
             <g:if test="${interestIncomeScheme.installmentCalcType.id == 1 && interestIncomeScheme.advInterestType.id == 2}">
                        <tr>
                            <g:set var="dueDate" value="${firstInstallmentDate ?: openingDate + term}" />
                            <g:set var="term" value="${dueDate - (interestStartDate ?: openingDate)}" />
                            <g:set var="interest" value="${(amount * interestRate * term) / divisor}" />
                            <g:set var="due" value="${amount - interest}" />
                            <g:set var="due1" value="${amount}" />
                            <g:set var="interest1" value="${interest - interest}" />
                            <td>1</td>
                            <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${amount}" /></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${interest1} " /></td>
                            <td><g:formatNumber format="###,###,##0.00" number="${due1}" /></td>
                            <td>0.00</td>
                            <g:set var="totalPrincipal" value="${amount}" />
                            <g:set var="totalInterest" value="${interest}" />
                            <g:set var="totalDue" value="${due1} " />
                        </tr>
                    </g:if>

            %{-- manual --}%
            <g:elseif test="${interestIncomeScheme.installmentType.id == 5 || interestIncomeScheme.installmentCalcType.id == 6}">
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />
                <g:set var="prevBalance" value="${amount}" />
                <g:each var="i" in="${1..installmentDates.size()}">
                <tr>
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                        <g:set var="dueDate" value="${installmentDates[i - 1]}" />
                    </g:else>
                    <%
                        /*def interest
                        if (interestStartDate) {
                            if (dueDate > interestStartDate) {
                                interest = prevBalance * (interestRate / divisor) * (dueDate - interestStartDate)
                                interestStartDate = null
                            } else {
                                interest = 0
                            }                            
                        } else {
                            interest = prevBalance * (interestRate / divisor) * (dueDate - prevDueDate)
                        }*/
                    %>
                    <%--<g:set var="interest" value="${prevBalance * (interestRate / divisor) * (dueDate - prevDueDate)}" />--%>                    
                    <g:set var="due" value="${principalAmounts[i - 1] + interestAmounts[i - 1]}" />
                    <g:set var="balance" value="${prevBalance - principalAmounts[i - 1]}" />
                    <td>${i}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${principalAmounts[i - 1]}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interestAmounts[i - 1]}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${balance}" /></td>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="prevBalance" value="${balance}" />
                    <g:set var="totalPrincipal" value="${totalPrincipal + principalAmounts[i - 1]}" />
                    <g:set var="totalInterest" value="${totalInterest + interestAmounts[i - 1]}" />
                    <g:set var="totalDue" value="${totalDue + due}" />
                
                </tr>
                </g:each>
            </g:elseif>

            %{-- declining fixed principal --}%                
            <g:elseif test="${interestIncomeScheme.installmentCalcType.id == 2}">                     
                <g:set var="principal" value="${amount / (numInstallments + balloonInstallments)}" />
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />
                <g:set var="prevBalance" value="${amount}" />
                <g:each var="i" in="${1..numInstallments}">
                <tr>
                    <g:if test="${i == numInstallments && balloonInstallments > 0}">
                        <g:set var="principal" value="${amount - (principal * (i - 1))}" />
                    </g:if>
                    
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>
            
                    <%
                        def interest
                        def numDays
                        if (interestStartDate) {                        
                            if (dueDate > interestStartDate) {
                                numDays = dueDate - interestStartDate
                                if (frequency == 1 || frequency == 2) {
                                    numDays = 1
                                }

                                interest = prevBalance * (interestRate / divisor) * numDays
                                interestStartDate = null
                            } else {
                                interest = 0
                            }
                        } else {
                            numDays = dueDate - prevDueDate
                            if (frequency == 1 || frequency == 2) {
                                numDays = 1
                            }

                            interest = prevBalance * (interestRate / divisor) * numDays
                        }
                    %>     
                    <%--<g:set var="numDays" value="${dueDate - prevDueDate}" />
                    <g:if test="${frequency == 1 || frequency == 2}">
                        <g:set var="numDays" value="${1}" />
                    </g:if>              
                    <g:set var="interest" value="${prevBalance * (interestRate / divisor) * numDays}" />--%>

                    <g:set var="due" value="${principal + interest}" />
                    <g:set var="balance" value="${prevBalance - principal}" />
                    <td>${i}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${principal}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interest}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${balance}" /></td>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="prevBalance" value="${balance}" />
                    <g:set var="totalPrincipal" value="${totalPrincipal + principal}" />
                    <g:set var="totalInterest" value="${totalInterest + interest}" />
                    <g:set var="totalDue" value="${totalDue + due}" />
                </tr>
                </g:each>
            </g:elseif>

            %{-- annuity/mortgage --}%
            <g:elseif test="${interestIncomeScheme.installmentCalcType.id == 3}">
                <%
                    def frequencyFactor

                    if (frequency == 1 || frequency == 2) {
                        frequencyFactor = 365
                    } else if (frequency == 3) {
                        frequencyFactor = 52
                    } else if (frequency == 4) {
                        frequencyFactor = 26
                    } else if (frequency == 5) {
                        frequencyFactor = 24
                    } else if (frequency == 6 || frequency == 7) {
                        frequencyFactor = 12
                    } else if (frequency == 8) {
                        frequencyFactor = 6
                    } else if (frequency == 9) {
                        frequencyFactor = 4
                    } else if (frequency == 10) {
                        frequencyFactor = 2
                    } else if (frequency == 11) {
                        frequencyFactor = 1
                    } else {
                        frequencyFactor = 365
                    }

                    def factor = interestRate / frequencyFactor

                    def due = installmentAmount ?: amount * (factor / (1 - ((1 / (1 + factor))**numInstallments)))
                %>            
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />    
                <g:set var="prevBalance" value="${amount}" />                
                <g:each var="i" in="${1..numInstallments}">
                <tr>
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                     
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>
            
                    <%
                        def interest
                        def numDays
                        if (interestStartDate) {                        
                            if (dueDate > interestStartDate) {
                                numDays = dueDate - interestStartDate
                                if (frequency == 1 || frequency == 2) {
                                    numDays = 1
                                }

                                interest = prevBalance * (interestRate / divisor) * numDays
                                interestStartDate = null
                            } else {
                                interest = 0
                            }
                        } else {
                            numDays = dueDate - prevDueDate
                            if (frequency == 1 || frequency == 2) {
                                numDays = 1
                            }

                            interest = prevBalance * (interestRate / divisor) * numDays
                        }

                        def principal
                        if (i == numInstallments) {
                            principal = prevBalance
                            due = principal + interest
                        } else {
                            principal = due - interest
                        }
                    %>
                    <%--<g:set var="numDays" value="${dueDate - prevDueDate}" />
                    <g:if test="${frequency == 1 || frequency == 2}">
                        <g:set var="numDays" value="${1}" />
                    </g:if>  
                    <g:set var="interest" value="${prevBalance * (interestRate / divisor) * numDays}" />--%>

                    <%--<g:if test="${i == numInstallments}">
                        <g:set var="principal" value="${prevBalance}" /> 
                        <g:set var="due" value="${principal + interest}" />
                    </g:if>
                    <g:else>
                        <g:set var="principal" value="${due - interest}" /> 
                    </g:else>--%> <%-- transferred to gsp block, not working here --%>
                    
                    <g:set var="balance" value="${prevBalance - principal}" />
                    <td>${i}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${principal}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interest}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${balance}" /></td>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="prevBalance" value="${balance}" />
                    <g:set var="totalPrincipal" value="${totalPrincipal + principal}" />
                    <g:set var="totalInterest" value="${totalInterest + interest}" />
                    <g:set var="totalDue" value="${totalDue + due}" />
                </tr>
                </g:each>
            </g:elseif>

            %{-- rule of 78 --}%
            <g:elseif test="${interestIncomeScheme.installmentCalcType.id == 4}">
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />
                <g:set var="factor" value="${0}" />
                <g:each var="i" in="${1..numInstallments}">
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="factor" value="${factor + i}" />
                </g:each>                
                <g:set var="maturityDate" value="${dueDate}" />                

                <g:if test="${interestStartDate}">
                    <g:set var="term" value="${maturityDate - interestStartDate}" />
                </g:if>
                <g:else>
                    <g:set var="term" value="${maturityDate - openingDate}" />
                </g:else>

                <g:if test="${frequency == 2}">
                    <g:if test="${interestStartDate}">
                        <g:set var="weekends" value="${loanService.getNumOfWeekends(interestStartDate, maturityDate)}" />
                        <g:set var="term" value="${maturityDate - interestStartDate - weekends}" />
                    </g:if>
                    <g:else>
                        <g:set var="weekends" value="${loanService.getNumOfWeekends(openingDate, maturityDate)}" />
                        <g:set var="term" value="${maturityDate - openingDate - weekends}" />
                    </g:else>                    
                </g:if>

                <g:set var="principal" value="${amount / numInstallments}" /> 
                <g:set var="totalInterest" value="${amount * (interestRate / divisor) * term}" /> 
                <g:set var="prevDueDate" value="${firstInstallmentDate}" 
                <g:set var="baseDate" value="${firstInstallmentDate}" />    
                <g:set var="prevBalance" value="${amount}" />
                <g:each var="i" in="${1..numInstallments}">
                <tr>                 
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>
                    
                    <g:set var="interest" value="${((numInstallments + 1 - i) / factor) * totalInterest}" />
                    <g:set var="due" value="${principal + interest}" />
                    <g:set var="balance" value="${prevBalance - principal}" />
                    <td>${i}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${principal}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interest}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${balance}" /></td>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="prevBalance" value="${balance}" />
                    <g:set var="totalPrincipal" value="${totalPrincipal + principal}" />
                    <g:set var="totalDue" value="${totalDue + due}" />
                </tr>
                </g:each>                
            </g:elseif>

            %{-- straight/flat --}%
            <g:elseif test="${interestIncomeScheme.installmentCalcType.id == 5}">
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />
                <g:each var="i" in="${1..numInstallments}">
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>
                    <g:set var="prevDueDate" value="${dueDate}" />
                </g:each>
                <g:set var="maturityDate" value="${dueDate}" />

                <g:if test="${interestStartDate}">
                    <g:set var="term" value="${maturityDate - interestStartDate}" />
                </g:if>
                <g:else>
                    <g:set var="term" value="${maturityDate - openingDate}" />
                </g:else>

                <g:if test="${frequency == 2}">
                    <g:if test="${interestStartDate}">
                        <g:set var="weekends" value="${loanService.getNumOfWeekends(interestStartDate, maturityDate)}" />
                        <g:set var="term" value="${maturityDate - interestStartDate - weekends}" />
                    </g:if>
                    <g:else>
                        <g:set var="weekends" value="${loanService.getNumOfWeekends(openingDate, maturityDate)}" />
                        <g:set var="term" value="${maturityDate - openingDate - weekends}" />
                    </g:else> 
                </g:if>

                <g:set var="totalInterest" value="${amount * (interestRate / divisor) * term}" />
                <g:set var="interest" value="${totalInterest / (numInstallments + balloonInstallments)}" />
                <g:set var="principal" value="${amount / (numInstallments + balloonInstallments)}" />
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />
                <g:set var="prevBalance" value="${amount}" />
                <g:each var="i" in="${1..numInstallments}">
                <tr>
                    <g:if test="${i == numInstallments && balloonInstallments > 0}">
                        <g:set var="principal" value="${amount - (principal * (i - 1))}" />
                        <g:set var="interest" value="${totalInterest - (interest * (i - 1))}" />
                    </g:if>

                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>

                    <g:set var="due" value="${principal + interest}" />
                    <g:set var="balance" value="${prevBalance - principal}" />
                    <td>${i}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${principal}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interest}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${balance}" /></td>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="prevBalance" value="${balance}" />
                    <g:set var="totalPrincipal" value="${totalPrincipal + principal}" />
                    <g:set var="totalDue" value="${totalDue + due}" />
                </tr>
                </g:each>
            </g:elseif>
            %{-- periodic annuity --}%
            <g:elseif test="${interestIncomeScheme.installmentCalcType.id == 7}">
                <%
                    def frequencyFactor

                    if (frequency == 1 || frequency == 2) {
                        frequencyFactor = 365
                    } else if (frequency == 3) {
                        frequencyFactor = 52
                    } else if (frequency == 4) {
                        frequencyFactor = 26
                    } else if (frequency == 5) {
                        frequencyFactor = 24
                    } else if (frequency == 6 || frequency == 7) {
                        frequencyFactor = 12
                    } else if (frequency == 8) {
                        frequencyFactor = 6
                    } else if (frequency == 9) {
                        frequencyFactor = 4
                    } else if (frequency == 10) {
                        frequencyFactor = 2
                    } else if (frequency == 11) {
                        frequencyFactor = 1
                    } else {
                        frequencyFactor = 365
                    }

                    def factor = interestRate / frequencyFactor

                    def due = installmentAmount ?: amount * (factor / (1 - ((1 / (1 + factor))**numInstallments)))
                %>            
                <g:set var="prevDueDate" value="${firstInstallmentDate}" />
                <g:set var="baseDate" value="${firstInstallmentDate}" />    
                <g:set var="prevBalance" value="${amount}" />                
                <g:each var="i" in="${1..numInstallments}">
                <tr>
                    <g:if test="${i == 1 && firstInstallmentDate}">
                        <g:set var="dueDate" value="${firstInstallmentDate}" />
                    </g:if>
                    <g:else>
                     
                        <g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, baseDate, frequency)}" />
                    </g:else>
                    <%--<g:set var="dueDate" value="${loanService.getNextDueDate(prevDueDate, frequency)}" />--%>
            
                    <%
                        def interest
                        def numDays
                        if (interestStartDate) {                        
                            if (dueDate > interestStartDate) {
                                numDays = dueDate - interestStartDate
                                if (frequency == 1 || frequency == 2) {
                                    numDays = 1
                                }

                                interest = prevBalance * (interestRate / divisor) * numDays
                                interestStartDate = null
                            } else {
                                interest = 0
                            }
                        } else {
                            numDays = dueDate - prevDueDate
                            if (frequency == 1 || frequency == 2) {
                                numDays = 1
                            }

                            interest = prevBalance * (interestRate / divisor) * numDays
                            if (frequency == 7){
                                interest = prevBalance * (interestRate / 12)
                            }
                        }

                        def principal
                        if (i == numInstallments) {
                            principal = prevBalance
                            due = principal + interest
                        } else {
                            principal = due - interest
                        }
                    %>
                    <%--<g:set var="numDays" value="${dueDate - prevDueDate}" />
                    <g:if test="${frequency == 1 || frequency == 2}">
                        <g:set var="numDays" value="${1}" />
                    </g:if>  
                    <g:set var="interest" value="${prevBalance * (interestRate / divisor) * numDays}" />--%>

                    <%--<g:if test="${i == numInstallments}">
                        <g:set var="principal" value="${prevBalance}" /> 
                        <g:set var="due" value="${principal + interest}" />
                    </g:if>
                    <g:else>
                        <g:set var="principal" value="${due - interest}" /> 
                    </g:else>--%> <%-- transferred to gsp block, not working here --%>
                    
                    <g:set var="balance" value="${prevBalance - principal}" />
                    <td>${i}</td>
                    <td><g:formatDate format="MM-dd-yyyy" date="${dueDate}"/></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${principal}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${interest}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${due}" /></td>
                    <td><g:formatNumber format="###,###,##0.00" number="${balance}" /></td>
                    <g:set var="prevDueDate" value="${dueDate}" />
                    <g:set var="prevBalance" value="${balance}" />
                    <g:set var="totalPrincipal" value="${totalPrincipal + principal}" />
                    <g:set var="totalInterest" value="${totalInterest + interest}" />
                    <g:set var="totalDue" value="${totalDue + due}" />
                </tr>
                </g:each>
            </g:elseif>                
                <tr>
                    <td></td>
                    <td></td>
                    <td><label><g:formatNumber format="###,###,##0.00" number="${totalPrincipal}" /></label></td>
                    <td><label><g:formatNumber format="###,###,##0.00" number="${totalInterest}" /></label></td>
                    <td><label><g:formatNumber format="###,###,##0.00" number="${totalDue}" /></label></td>
                    <td></td>
                </tr>               
            </tbody>
        </table>
    </div>