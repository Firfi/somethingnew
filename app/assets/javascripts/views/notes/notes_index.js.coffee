class Somethingnew.Views.NotesIndex extends Backbone.View

  template: JST['notes/index']
  errorTemplate: JST['notes/error']

  events: ->
    'submit #new_note': 'createNote'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendNote)
    this

  createNote: (event) ->
    event.preventDefault()
    data = Backbone.Syphon.serialize(this)
    @collection.create data,
      wait: true
      success: (model) =>
        $('#new_note')[0].reset()
        @closeAlerts()
        @appendNote(model)
      error: (model, err) =>
        @closeAlerts()
        if err.status is 422 # TODO validation error. there is constant somewhere but I can't find it now
          errors = $.parseJSON(err.responseText)['errors']
          pretty_errors = @mkPrettyErrors(errors)
          rendered = @errorTemplate(errors: pretty_errors)
          $('#alerts').append(rendered)


  appendNote: (note) ->
    view = new Somethingnew.Views.Note(model: note)
    $('#notes table').append(view.render().el)

  mkPrettyErrors: (errors) ->
    pretty_errors = {}
    form = $('#new_note')[0]
    for field of errors
      input = form.elements[field]
      label = $(input).siblings('label').text() || field
      pretty_errors[field] = {'label': label, 'message': errors[field]}
    pretty_errors

  closeAlerts: ->
    $('.alert').alert('close')


#this.model.save( {att1 : "value"}, {success :handler1, error: handler2});