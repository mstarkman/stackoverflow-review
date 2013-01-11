require('routers/tags_index_route')

App.IndexRoute = App.TagsIndexRoute.extend
  renderTemplates: ->
    @render('tagsIndex')
