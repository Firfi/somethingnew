class Somethingnew.Views.NotesIndex extends Backbone.View

  template: JST['notes/index']

  errorTemplate: JST['notes/error']

  events: ->
    'submit #new_note': 'createNote'
    'render': 'initTagAutocomplete'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template())
    $(@el).trigger('render', $(@el).find('form#new_note'))
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
        console.warn(model)
        @appendNote(model)
      error: (model, err) =>
        @closeAlerts()
        if err.status is 422 # validation error. there is constant somewhere but I can't find it now
          errors = $.parseJSON(err.responseText)['errors']
          pretty_errors = @mkPrettyErrors(errors)
          rendered = @errorTemplate(errors: pretty_errors)
          $('#alerts').append(rendered)


  appendNote: (note) ->
    view = new Somethingnew.Views.Note(model: note)
    $('#notes table tr:first').after(view.render().el)

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

  initTagAutocomplete: (form) ->

    extractor = (query, last = true) ->
      result = (query || "").split(',').map((r) -> r.trim()).filter((r) -> (r isnt ""))
      if last
        result.slice(-1)[0]|| ""
      else
        result

    @$('.typeahead').typeahead(
      source: (req, resp) ->
        res = extractor(req.term || req, false)
        term = res.slice(-1)[0]
        $.get(
          'api/v1/tags/autocomplete/'+term
          (data) =>
            resp data.filter((r) => res.indexOf(r) is -1)
        ) if term
      updater: (item) ->
        @$element.val().replace(/[^,]*$/, "") + item + ","

      matcher: (item) ->
        tquery = extractor(@query)
        return false unless tquery
        ~item.toLowerCase().indexOf(tquery)

      highlighter: (item) ->
        query = extractor(@query).replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&")
        item.replace new RegExp("(" + query + ")", "ig"), ($1, match) ->
          "<strong>" + match + "</strong>"
    )



#this.model.save( {att1 : "value"}, {success :handler1, error: handler2});