#= require json2
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require_tree .

class Application extends Backbone.View
  id: 'jobs-app'

  initialize: ->
    console.log 'init'

  render: ->
    console.log 'render'
    $(@el).text 'foo'


$(document).ready ->
  $('button').click (e) ->
    e.preventDefault()

    # Take the naming from Objective-C Cocoa
    window.App = new Application()
    App.render()
    $('body').append App.el

