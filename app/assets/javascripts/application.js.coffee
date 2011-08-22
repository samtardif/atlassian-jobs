#= require json2
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require string_score
#= require_tree .
#= require_self

class Application extends Backbone.View
  tagName: 'form'
  id: 'jobs-app'

  template: _.template("""
    <div class="shadow"></div>
    <div class="letter">
      <div class="viewport"></div>
    </div>
  """)

  events:
    'click .shadow': 'hide'
    'submit':        'submit'


  initialize: ->
    @pageView = new PageView()

    $(@el)
      .html(@template())
      .find('.viewport').append(@pageView.el)

  render: ->
    @pageView.render()

  hide: ->
    $(@el).hide()

  submit: (e) ->
    e.preventDefault()

    alert @pageView.toJSON()


$(document).ready ->
  $('button').click (e) ->
    e.preventDefault()

    # Take the naming from Objective-C Cocoa
    window.App = new Application()
    $('body').append App.el
    App.render()
