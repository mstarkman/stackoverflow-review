require('routers/index_router')

App.Router.map (match) ->
  match('/').to 'index'
  match('tags').to 'tagsIndex'
