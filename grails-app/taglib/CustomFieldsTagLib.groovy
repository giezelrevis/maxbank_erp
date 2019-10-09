
class CustomFieldsTagLib {
    //field and bean is required
    def myTextField = { attrs, body ->
        
        
        //attrs.class = hasErrors(bean:attrs.bean, field:attrs.field, 'error')
        attrs.class += " form-control"
        println attrs
        out << "<div class =\"form-group\">"
        out << g.myLabel(attrs)
        
        out << "<div class=\"control-label col-sm-8\">"
        out << g.textField(attrs)
        out << "</div>"
        out << "</div>"
    }
    def myTextArea = { attrs, body ->
        if(!attrs.name){
            attrs.name = attrs.field
        }
        if(!attrs.id){
            attrs.id = attrs.field
        }
        attrs.class = hasErrors(bean:attrs.bean, field:attrs.field, 'error')
        attrs.class += " form-control "
        println attrs
        out << "<div class =\"form-group\">"
        out << g.myLabel(attrs)
        
        out << "<div class=\"control-label col-sm-8\">"
        out << g.textArea(attrs)
        out << "</div>"
        out << "</div>"
        
        
    }
    def mySelect = { attrs, body ->
        if(!attrs.name){
            attrs.name = attrs.field
        }
        if(!attrs.id){
            attrs.id = attrs.field
        }
        attrs.class = hasErrors(bean:attrs.bean, field:attrs.field, 'error')
        attrs.class += " form-control "
        println attrs
        out << "<div class =\"form-group\">"
        out << g.myLabel(attrs)
        
        out << "<div class=\"control-label col-sm-8\">"
        out << g.select(attrs)
        out << "</div>"
        out << "</div>"
    }
    
    def myLabel = {attrs, body ->
        println "attrs,body" +attrs
        def labelCode = attrs.labelCode
        def label = attrs.label
        def required = attrs.required
        println "label = " +attrs.label
        out << "<label class=\"control-label col-sm-4\">"
        out << label
        if(required=="true"){
            out << "<span class=\"required-indicator\">*</span>"
        }
	out << "</label>"
    }
    def myDatePicker = {attrs, body ->
        
        
        
        
        
    }
}
		