require('routers/index_route')
require('routers/tags_index_route')

App.Router.map (match) ->
  match('/').to 'index'
  match('tags').to 'tagsIndex'
