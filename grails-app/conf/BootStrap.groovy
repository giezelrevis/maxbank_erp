class BootStrap {

    def messageSource 
    def grailsApplication

    def init = { servletContext ->
        //def cloneForDomains={def cloned=delegate.class.newInstance();
        //         cloned.properties=delegate.properties;
        //        return cloned;}
        grailsApplication.domainClasses.each {domainClass ->//iterate over the domainClasses
                domainClass.metaClass.retrieveErrors = {
                def errorString = delegate?.errors?.allErrors?.collect{messageSource.getMessage(it,null)}?.join(' \n')
 
                return errorString
            }
        }        
    }
    def destroy = {
    }
}
