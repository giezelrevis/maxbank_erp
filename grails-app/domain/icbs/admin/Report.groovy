package icbs.admin

import icbs.lov.ConfigItemStatus
import icbs.lov.ReportGroup
import icbs.lov.ReportType

class Report {

	String name
	ReportGroup reportGroup
	ReportType reportType
	String sourceFile
	String remarks
        String baseParams
        String reportUnit
        String outputParam
        String reportId
        String reportParam
        
    ConfigItemStatus configItemStatus

    static constraints = {
    	name maxSize:100, unique:true
    	reportGroup nullable:true
    	reportType nullable:true
    	sourceFile nullable:true
    	remarks nullable:true
        baseParams nullable:true
        reportUnit nullable:true
        outputParam nullable:true
        reportId nullable:true
        reportParam nullable:true
        configItemStatus nullable:false
        
    }

    static mapping = {
    	id sqlType:'int'
    	reportGroup sqlType:'smallint'
    	reportType sqlType:'smallint'
        configItemStatus sqlType:'smallint'
    }
}
