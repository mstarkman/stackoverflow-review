attr = DS.attr

App.Tag = DS.Model.extend
  name: attr 'string'

require('models/fixtures/tags')
