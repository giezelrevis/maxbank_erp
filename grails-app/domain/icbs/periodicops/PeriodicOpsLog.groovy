package icbs.periodicops

import com.sun.beans.decoder.FalseElementHandler;
import java.sql.Time
import icbs.admin.UserMaster

class PeriodicOpsLog {
	PeriodicOpsProcess periodicOpsProcess
	String processUID
	Date runDate
	Date cpuDate
	String startTime
	String endTime
        String errorCode
	Integer status
        UserMaster user
	
	static constraints = {
		periodicOpsProcess nullable:false
		processUID maxsize:50
                errorCode nullable:true
	}
	
	static mapping = {
            id sqlType:'int', generator:'increment'
		runDate sqlType:'date'
		cpuDate sqlType:'date'
		//startTime sqlType:'time'
		//endTime sqlType:'time'
	}

}
