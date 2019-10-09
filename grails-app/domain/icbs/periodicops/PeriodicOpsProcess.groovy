package icbs.periodicops

import icbs.lov.PeriodicOpsModule;

class PeriodicOpsProcess {
	
	PeriodicOpsModule periodicOpsModule
	String periodicOpsPhase
	String processDescription
	String status
	
	static constraints = {
		processDescription maxSize:50
		status maxSize:2
	}
	
	static mapping = {
		processDescription sqlType:'varchar'
		status sqlType:'varchar'
	}
}
