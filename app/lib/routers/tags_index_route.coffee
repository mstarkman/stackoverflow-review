require('models/tag')
require('controllers/tags_index_controller')

App.TagsIndexRoute = Ember.Route.extend
  model: ->
    App.Tag.find()

  setupController: (controller, model) ->
    controller.set('content', model)

