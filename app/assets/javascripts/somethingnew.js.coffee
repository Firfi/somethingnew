window.Somethingnew =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Somethingnew.Routers.Notes
    Backbone.history.start({root: '/notes/', pushState: true})


$(document).ready ->
  return if window.location.pathname.indexOf('/notes') isnt 0 # this shit reacts on root path too for some reason
  Somethingnew.init()
