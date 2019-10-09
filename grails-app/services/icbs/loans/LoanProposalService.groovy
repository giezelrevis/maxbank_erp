package icbs.loans
import grails.transaction.Transactional

@Transactional
class LoanProposalService {
    
    def getNextDueDate(Date prevDueDate, int frequency) {
        def calendar = new GregorianCalendar()
        calendar.setTime(prevDueDate)

        switch(frequency) {
            case 1:  // daily
                calendar.add(Calendar.DAY_OF_MONTH, 1)
            break

            case 2:  // daily (no weekends)
                switch(calendar.get(Calendar.DAY_OF_WEEK)) {
                    case Calendar.FRIDAY:
                        calendar.add(Calendar.DAY_OF_MONTH, 3)
                    break

                    case Calendar.SATURDAY:
                        calendar.add(Calendar.DAY_OF_MONTH, 2)
                    break

                    default:
                        calendar.add(Calendar.DAY_OF_MONTH, 1)
                    break
                }
            break

            case 3:  // weekly
                calendar.add(Calendar.DAY_OF_MONTH, 7)
            break

            case 4:  // bi-weekly
                calendar.add(Calendar.DAY_OF_MONTH, 14)
            break

            case 5:  // semi-monthly
                calendar.add(Calendar.DAY_OF_MONTH, 15)
            break

            case 6:  // monthly (30 days)
                calendar.add(Calendar.DAY_OF_MONTH, 30)
            break

            case 7:  // monthly
                calendar.add(Calendar.MONTH, 1)
            break

            case 8:  // bi-monthly
                calendar.add(Calendar.MONTH, 2)
            break

            case 9:  // quarterly
                calendar.add(Calendar.MONTH, 3)
            break

            case 10:  // semi-annually
                calendar.add(Calendar.MONTH, 6)
            break

            case 11:  // annually
                calendar.add(Calendar.YEAR, 1)
            break

            /*case 2:  // weekly (last day)
                calendar.add(Calendar.DAY_OF_MONTH, 7)
                if (installmentNo == 1) {                            
                    switch(calendar.get(Calendar.DAY_OF_WEEK)) {
                        case Calendar.SUNDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 6)
                        break

                        case Calendar.MONDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 5)
                        break

                        case Calendar.TUESDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 4)
                        break

                        case Calendar.WEDNESDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 3)
                        break

                        case Calendar.THURSDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 2)
                        break

                        case Calendar.FRIDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, 1)
                        break
                    }
                }                                                                
            break

            case 3:  // weekly (first day)
                calendar.add(Calendar.DAY_OF_MONTH, 7)
                if (installmentNo == 1) {                            
                    switch(calendar.get(Calendar.DAY_OF_WEEK)) {
                        case Calendar.MONDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, -1)
                        break

                        case Calendar.TUESDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, -2)
                        break

                        case Calendar.WEDNESDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, -3)
                        break

                        case Calendar.THURSDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, -4)
                        break

                        case Calendar.FRIDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, -5)
                        break

                        case Calendar.SATURDAY:
                            calendar.add(Calendar.DAY_OF_MONTH, -6)
                        break
                    }
                }                                
            break*/            
        }

        return calendar.getTime()
    }

    def getNumOfWeekends(Date startDate, Date endDate) {
        def numOfWeekends = 0;

        def date1 = startDate.clearTime()
        def date2 = endDate.clearTime()

        def calendar = new GregorianCalendar()
        calendar.setTime(date1)

        while(date1 < date2) {
            date1 = date1 + 1
            calendar.add(Calendar.DAY_OF_MONTH, 1)

            if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY ||
                calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                numOfWeekends++
            }                        
        }        

        return numOfWeekends
    }
}
