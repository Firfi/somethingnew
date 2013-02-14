class Somethingnew.Routers.Notes extends Backbone.Router
  routes:
    '': 'index'
  initialize: ->
    @collection = new Somethingnew.Collections.Notes
    @collection.fetch() # @collection.reset($('#container').data 'entries')
  index: ->
    view = new Somethingnew.Views.NotesIndex(collection: @collection)
    $('#container').html(view.render().el)