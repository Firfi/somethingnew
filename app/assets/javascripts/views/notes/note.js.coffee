class Somethingnew.Views.Note extends Backbone.View

  template: JST['notes/note']
  tagName: 'tr'

  events: ->
    'click .delete': 'deleteNote'

  render: ->
    $(@el).html(@template(note: @model))
    this

  deleteNote: (event) ->
    event.preventDefault()
    @model.destroy
      success: (model, response) =>
        @remove()