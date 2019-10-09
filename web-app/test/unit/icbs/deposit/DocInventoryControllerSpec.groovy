package icbs.deposit



import grails.test.mixin.*
import spock.lang.*

@TestFor(DocInventoryController)
@Mock(DocInventory)
class DocInventoryControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.docInventoryInstanceList
            model.docInventoryInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.docInventoryInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def docInventory = new DocInventory()
            docInventory.validate()
            controller.save(docInventory)

        then:"The create view is rendered again with the correct model"
            model.docInventoryInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            docInventory = new DocInventory(params)

            controller.save(docInventory)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/docInventory/show/1'
            controller.flash.message != null
            DocInventory.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def docInventory = new DocInventory(params)
            controller.show(docInventory)

        then:"A model is populated containing the domain instance"
            model.docInventoryInstance == docInventory
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def docInventory = new DocInventory(params)
            controller.edit(docInventory)

        then:"A model is populated containing the domain instance"
            model.docInventoryInstance == docInventory
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/docInventory/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def docInventory = new DocInventory()
            docInventory.validate()
            controller.update(docInventory)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.docInventoryInstance == docInventory

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            docInventory = new DocInventory(params).save(flush: true)
            controller.update(docInventory)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/docInventory/show/$docInventory.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/docInventory/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def docInventory = new DocInventory(params).save(flush: true)

        then:"It exists"
            DocInventory.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(docInventory)

        then:"The instance is deleted"
            DocInventory.count() == 0
            response.redirectedUrl == '/docInventory/index'
            flash.message != null
    }
}
