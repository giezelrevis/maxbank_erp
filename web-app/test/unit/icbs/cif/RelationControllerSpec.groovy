package icbs.cif



import grails.test.mixin.*
import spock.lang.*

@TestFor(RelationController)
@Mock(Relation)
class RelationControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.relationInstanceList
            model.relationInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.relationInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def relation = new Relation()
            relation.validate()
            controller.save(relation)

        then:"The create view is rendered again with the correct model"
            model.relationInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            relation = new Relation(params)

            controller.save(relation)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/relation/show/1'
            controller.flash.message != null
            Relation.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def relation = new Relation(params)
            controller.show(relation)

        then:"A model is populated containing the domain instance"
            model.relationInstance == relation
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def relation = new Relation(params)
            controller.edit(relation)

        then:"A model is populated containing the domain instance"
            model.relationInstance == relation
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/relation/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def relation = new Relation()
            relation.validate()
            controller.update(relation)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.relationInstance == relation

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            relation = new Relation(params).save(flush: true)
            controller.update(relation)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/relation/show/$relation.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/relation/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def relation = new Relation(params).save(flush: true)

        then:"It exists"
            Relation.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(relation)

        then:"The instance is deleted"
            Relation.count() == 0
            response.redirectedUrl == '/relation/index'
            flash.message != null
    }
}
